import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/autenticacao.dart';
import 'package:levv4/api/firebase_banco_de_dados/bando_de_dados.dart';

import '../../bo/usuario/perfil/administrar/administrar.dart';
import '../interface/i_crud_usuario_dao.dart';

class AdministrarDAO  implements ICrudUsuarioDAO<Administrar> {

  final bancoDeDados = BancoDeDados();
  final autenticacao = Autenticacao();
  final collectionPath = "administrar";

  @override
  Future<void> criar(Administrar object) async {

    String documentName = autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);


    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .set(await toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> atualizar(Administrar object) async {
    String documentName = autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .update(await toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<Administrar?> buscarTodos() async {
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
  Future<Administrar> buscarUmUsuarioPeloNomeDoDocumento(String reference) async {

    var administrar;

      await bancoDeDados.db.collection(collectionPath).doc(reference).get().then(
            (DocumentSnapshot doc) {

          final data = doc.data() as Map<String, dynamic>;

          administrar = fromMap(data);
        },
        onError: (e) => print("Error getting document: $e"),
      );

    return administrar;
  }

  @override
  Future<void> deletar(Administrar object) async {
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
  Future<Map<String, dynamic>> toMap(Administrar object) async {
    return {
      if (object.perfil != null) "perfil": object.perfil,
    };
  }

  @override
  Future<Administrar> fromMap(Map<String, dynamic> map) async{
    Administrar administrar = Administrar();
    administrar.perfil = map["perfil"];
    return administrar;
  }




}
