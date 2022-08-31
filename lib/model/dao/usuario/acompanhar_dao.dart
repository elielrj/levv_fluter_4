import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:levv4/model/backend/firebase/auth/document_name_current_user.dart';
import 'package:levv4/model/backend/firebase/auth/firebase_auth.dart';
import 'package:levv4/model/backend/firebase/firestore/bando_de_dados.dart';
import 'package:levv4/model/backend/firebase/firestore/interface/crud_firebase_firestore.dart';

import '../../bo/usuario/perfil/acompanhar/acompanhar.dart';

class AcompanharDAO with DocumentNameCurrentUser implements CrudFirebaseFirestore<Acompanhar> {

  final bancoDeDados = BancoDeDados(FirebaseFirestore.instance);
  final autenticacao = Autenticacao(FirebaseAuth.instance);
  final collectionPath = "acompanhar";

  @override
  Future<void> create(Acompanhar object) async {

    String documentName = name(autenticacao.auth.currentUser!);


    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .set(toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> update(Acompanhar object) async {
    String documentName = name(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .update(toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<Acompanhar?> retriveAll() async {
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
  Future<Acompanhar> searchByReference(String reference) async {

    var acompanhar;

     await bancoDeDados
         .db
         .collection(collectionPath)
         .doc(reference)
         .get()
         .then(
           (DocumentSnapshot doc)  {

         final data =  doc.data() as Map<String, dynamic>;

         acompanhar = fromMap(data);
       },
       onError: (e) => print("Error getting document: $e"),
     );

   return acompanhar;
  }

  @override
  Future<void> delete(Acompanhar object) async {
    String documentName = name(autenticacao.auth.currentUser!);


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
  Map<String, dynamic> toMap(Acompanhar object) {
    return {
      if (object.perfil != null) "perfil": object.perfil,
    };
  }

  @override
  Acompanhar fromMap(Map<String, dynamic> map) {
    Acompanhar acompanhar = Acompanhar();
    acompanhar.perfil = map["perfil"];
    return acompanhar;
  }
}
