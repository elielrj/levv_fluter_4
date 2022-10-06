import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_auth/autenticacao.dart';
import 'package:levv4/api/firebase_banco_de_dados/bando_de_dados.dart';

import '../../bo/usuario/perfil/acompanhar/acompanhar.dart';
import '../interface/i_crud_usuario_dao.dart';

class AcompanharDAO  implements ICrudUsuarioDAO<Acompanhar> {

  final bancoDeDados = BancoDeDados();
  final autenticacao = Autenticacao();
  final collectionPath = "acompanhar";

  @override
  Future<void> criar(Acompanhar object) async {

    String documentName = autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);


    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .set(await toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> atualizar(Acompanhar object) async {
    String documentName = autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .update(await toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<Acompanhar?> buscarTodos() async {
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
  Future<Acompanhar> buscarUmUsuarioPeloNomeDoDocumento(String reference) async {

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
  Future<void> deletar(Acompanhar object) async {
    String documentName = autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);


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
  Future<Map<String, dynamic>> toMap(Acompanhar object) async {
    return {
      if (object.perfil != null) "perfil": object.perfil,
    };
  }

  @override
  Future<Acompanhar> fromMap(Map<String, dynamic> map) async {
    Acompanhar acompanhar = Acompanhar();
    acompanhar.perfil = map["perfil"];
    return acompanhar;
  }
}
