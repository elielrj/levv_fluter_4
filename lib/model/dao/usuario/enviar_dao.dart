import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:levv4/model/backend/firebase/auth/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/backend/firebase/auth/autenticacao.dart';
import 'package:levv4/model/backend/firebase/firestore/bando_de_dados.dart';
import 'package:levv4/model/backend/firebase/firestore/interface/crud_firebase_firestore.dart';

import '../../bo/usuario/perfil/enviar/enviar.dart';

class EnviarDAO with NomeDoDocumentoDoUsuarioCorrente implements CrudFirebaseFirestore<Enviar> {

  final bancoDeDados = BancoDeDados(FirebaseFirestore.instance);
  final autenticacao = Autenticacao();
  final collectionPath = "enviar";

  @override
  Future<void> create(Enviar object) async {

    String documentName = nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .set(toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> update(Enviar object) async {
    String documentName = nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .update(toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<Enviar?> retriveAll() async {
    //todo buscar todos, ver como fazer isso
    await bancoDeDados.db.collection(collectionPath).get().then(
      (res) {
        print("Successfully completed");
        return res.docs;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Future<Enviar> searchByReference(String reference) async {

    var enviar;

      await bancoDeDados.db.collection(collectionPath).doc(reference).get().then(
            (DocumentSnapshot doc) {

          final data = doc.data() as Map<String, dynamic>;

          enviar = fromMap(data);
        },
        onError: (e) => print("Error getting document: $e"),
      );

    return enviar;
  }

  @override
  Future<void> delete(Enviar object) async {
    String documentName = nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  @override
  Map<String, dynamic> toMap(Enviar object) {
    return {
      if (object.perfil != null) "perfil": object.perfil,
      if (object.nome != null) "nome": object.nome,
      if (object.sobrenome != null) "sobrenome": object.sobrenome,
      if (object.cpf != null) "cpf": object.cpf,
      if (object.nascimento != null) "nascimento": Timestamp.fromMillisecondsSinceEpoch(object.nascimento!.millisecondsSinceEpoch),
      if (object.enderecosFavoritos != null) "enderecosFavoritos": object.enderecosFavoritos,
      if (object.casa != null) "casa": object.casa,
      if (object.trabalho != null) "trabalho": object.trabalho,
      if (object.documentoDeIdentificacao != null) "documentoDeIdentificacao": object.documentoDeIdentificacao,
    };
  }

  @override
  Enviar fromMap(Map<String, dynamic> map) {

    Timestamp timestamp = map["nascimento"];
    DateTime dateTime = timestamp.toDate();

    return Enviar(
      nome: map["nome"],
      sobrenome: map["sobrenome"],
      cpf: map["cpf"],
      nascimento: dateTime,
      enderecosFavoritos: map["enderecosFavoritos"],
      casa: map["casa"],
      trabalho: map["trabalho"],
      documentoDeIdentificacao: map["documentoDeIdentificacao"],
    );
  }




}
