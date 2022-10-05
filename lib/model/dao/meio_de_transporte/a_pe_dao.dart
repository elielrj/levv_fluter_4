import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:levv4/model/backend/firebase/firestore/bando_de_dados.dart';
import 'package:levv4/model/backend/firebase/firestore/interface/crud_firebase_firestore.dart';

import '../../backend/firebase/auth/mixin_nome_do_documento_do_usuario_corrente.dart';
import '../../backend/firebase/auth/autenticacao.dart';
import '../../bo/meio_de_transporte/a_pe.dart';


class APeDAO with NomeDoDocumentoDoUsuarioCorrente implements CrudFirebaseFirestore<APe> {

  final autenticacao = Autenticacao();
  final bancoDeDados = BancoDeDados(FirebaseFirestore.instance);

  final collectionPath = "meios_de_transportes";

  @override
  Future<void> create(APe object) async {

    String documentName =  nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .set(toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> update(APe object) async {

    String documentName =  nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .update(toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<APe?> retriveAll() async {
    await bancoDeDados.db.collection(collectionPath).get().then(
      (res) {
        print("Successfully completed");
        return res.docs;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  Future<APe> retrive() async {

    String documentName =  nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    var ape;

    await bancoDeDados.db.collection(collectionPath).doc(documentName).get().then(
          (DocumentSnapshot doc)  {
        final data = doc.data() as Map<String, dynamic>;

        ape =  fromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );

    return ape;
  }

  @override
  Future<APe?> searchByReference(String reference) async {
    await bancoDeDados.db.collection(collectionPath).doc(reference).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        return fromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Future<void> delete(APe object) async {

    String documentName =  nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

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
  Map<String, dynamic> toMap(APe object) {

    return {
      if (object.nome != null) "nome": object.nome,
      if (object.peso != null) "peso": object.peso,
      if (object.volume != null) "volume": object.volume
    };
  }

  @override
  APe fromMap(Map<String, dynamic> map) {

    return APe(
      nome: map["nome"],
      peso: map["peso"],
      volume: map["volume"],
    );

  }
}
