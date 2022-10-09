import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/autenticacao.dart';
import 'package:levv4/api/firebase_banco_de_dados/bando_de_dados.dart';

import '../../bo/usuario/perfil/enviar/enviar.dart';
import '../interface/i_crud_usuario_dao.dart';

class EnviarDAO implements ICrudUsuarioDAO<Enviar> {
  final bancoDeDados = BancoDeDados();
  final autenticacao = Autenticacao();
  final collectionPath = "enviar";

  @override
  Future<void> criar(Enviar object) async {
    String documentName = autenticacao
        .nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .set(await toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> atualizar(Enviar object) async {
    String documentName = autenticacao
        .nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .update(await toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<Enviar?> buscarTodos() async {
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
  Future<Enviar> buscarUmUsuarioPeloNomeDoDocumento(String reference) async {
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
  Future<void> deletar(Enviar object) async {
    String documentName = autenticacao
        .nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

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
  Future<Map<String, dynamic>> toMap(Enviar object) async {
    return {
      if (object.perfil != null) "perfil": object.perfil,
      if (object.nome != null) "nome": object.nome,
      if (object.sobrenome != null) "sobrenome": object.sobrenome,
      if (object.cpf != null) "cpf": object.cpf,
      if (object.nascimento != null)
        "nascimento": Timestamp.fromMillisecondsSinceEpoch(
            object.nascimento!.millisecondsSinceEpoch),
      if (object.enderecosFavoritos != null)
        "enderecosFavoritos": object.enderecosFavoritos,
      if (object.casa != null) "casa": object.casa,
      if (object.trabalho != null) "trabalho": object.trabalho,
      if (object.documentoDeIdentificacao != null)
        "documentoDeIdentificacao": object.documentoDeIdentificacao,
    };
  }

  @override
  Future<Enviar> fromMap(Map<String, dynamic> map) async {
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
