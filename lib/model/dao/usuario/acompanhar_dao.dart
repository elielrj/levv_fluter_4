import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/bo/acompanhar/acompanhar.dart';

import 'interface_usuario_dao.dart';

class AcompanharDAO
    with NomeDoDocumentoDoUsuarioCorrente
    implements InterfaceUsuarioDAO<Acompanhar> {
  final collectionPath = "acompanhar";

  static const documentSucessfullyCreate =
      "AcompanharDAO: DocumentSnapshot successfully create!";
  static const documentSucessfullyUpdate =
      "AcompanharDAO: DocumentSnapshot successfully update!";
  static const documentSucessfullyRetrive =
      "AcompanharDAO: DocumentSnapshot successfully retrive!";
  static const documentSucessfullyRetriveAll =
      "AcompanharDAO: DocumentSnapshot successfully retrive all!";
  static const documentSucessfullyDelete =
      "AcompanharDAO: DocumentSnapshot successfully delete!";

  static const documentErrorCreate = "AcompanharDAO: Error crete document!";
  static const documentErrorUpdate = "AcompanharDAO: Error update document!";
  static const documentErrorRetrive = "AcompanharDAO: Error retrive document!";
  static const documentErrorRetriveAll =
      "AcompanharDAO: Error retrive all document!";
  static const documentErrorDelete = "AcompanharDAO: Error delete document!";

  @override
  Future<void> criar(Acompanhar object) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .set(await toMap(object))
        .then((value) => print(documentSucessfullyCreate),
            onError: (e) => print("$documentErrorCreate --> ${e.toString()}"));
  }

  @override
  Future<void> atualizar(Acompanhar object) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .update(await toMap(object))
        .then((value) => print(documentSucessfullyUpdate),
            onError: (e) => print("$documentErrorUpdate --> ${e.toString()}"));
  }

  @override
  Future<List<Acompanhar>> buscarTodos() async {
    List<Acompanhar> usuariosAcompanhadores = [];

    await FirebaseFirestore.instance.collection(collectionPath).get().then(
      (res) {
        res.docs.map(
            (e) async => usuariosAcompanhadores.add(await fromMap(e.data())));
        print(documentSucessfullyRetriveAll);
      },
      onError: (e) => print("$documentErrorRetriveAll --> ${e.toString()}"),
    );

    return usuariosAcompanhadores;
  }

  @override
  Future<Acompanhar> buscar() async {
    Acompanhar acompanhar = Acompanhar();

    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .get()
        .then(
      (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;

        acompanhar = await fromMap(data);
        print(documentSucessfullyRetrive);
      },
      onError: (e) => print("$documentErrorRetrive --> $e"),
    );

    return acompanhar;
  }

  @override
  Future<void> deletar(Acompanhar object) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .delete()
        .then(
          (doc) => print(documentSucessfullyDelete),
          onError: (e) => print("$documentErrorDelete --> ${e.toString()}"),
        );
  }

  @override
  Future<Map<String, dynamic>> toMap(Acompanhar object) async {
    return {
      if (object.exibirPerfil() != null) "perfil": object.exibirPerfil(),
    };
  }

  @override
  Future<Acompanhar> fromMap(Map<String, dynamic> map) async {
    return Acompanhar();
  }
}
