import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:levv4/model/backend/firebase/auth/document_name_current_user.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/backend/firebase/auth/autenticacao.dart';
import 'package:levv4/model/backend/firebase/firestore/bando_de_dados.dart';
import 'package:levv4/model/dao/usuario/mixin_perfil.dart';

import '../../backend/firebase/firestore/interface/crud_firebase_firestore_to_user_basic.dart';

class UsuarioDAO
    with CreatePerfil, SearchByReferencePerfil, DeletePerfil
    implements CrudFirebaseFirestoreToUserBasic<Usuario> {

  final bancoDeDados = BancoDeDados(FirebaseFirestore.instance);

  final autenticacao = Autenticacao();

  final collectionPath = "usuarios";

  @override
  Future<void> criar(Usuario object) async {
    String documentName = autenticacao
        .nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await createPerfil(object.perfil);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .set(await toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> atualizar(Usuario object) async {
    String documentName = autenticacao
        .nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    //todo arrumar update p/ Perfil

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .update(await toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<Usuario?> buscarTodos() async {
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
  Future<Usuario> buscarUmDocumentoPelaReferencia(String nomeDoDocumento) async {
    var usuario;

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(nomeDoDocumento)
        .get()
        .then(
      (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;

        usuario = await fromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );

    return usuario;
  }

  @override
  Future<void> deletar(Usuario object) async {
    String documentName = autenticacao
        .nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await deletePerfil(object.perfil);

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
  Future<Map<String, dynamic>> toMap(Usuario object) async {
    DocumentReference documentReference = bancoDeDados.db.doc(
        "${object.perfil!.exibirPerfil().toString().toLowerCase()}/${object.celular}");

    return {
      if (object.celular != null) "celular": object.celular,
      if (object.perfil != null) "perfil": documentReference,
      //todo ver como receber List de Map
      // if (object.listaDePedidos != null) "listaDePedidos": object.listaDePedidos
    };
  }

  @override
  Future<Usuario> fromMap(Map<String, dynamic> map) async {
    var perfil;

    DocumentReference documentReference = map["perfil"];

    await documentReference.get().then((DocumentSnapshot doc) async {
      final data = doc.data() as Map<String, dynamic>;

      perfil = await searchByReferencePerfil(data, data["perfil"]);

      print("filtro: sucess ao buscar perfil de user!");
    }).onError((error, stackTrace) {
      print("filtro: error ao buscar perfil de user! ${error.toString()}");
    });

    return Usuario(
      celular: map["celular"],
      perfil: await perfil,
      listaDePedidos: null,
    );
  }
}
