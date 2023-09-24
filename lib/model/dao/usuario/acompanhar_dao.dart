import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/biblioteca/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/bo/acompanhar/acompanhar.dart';

import 'interface_usuario_dao.dart';
/*
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
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .set(object.toMap());
      print(documentSucessfullyCreate);
    } catch (erro) {
      print("$documentErrorCreate --> ${erro.toString()}");
    }
  }

  @override
  Future<void> atualizar(Acompanhar object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .update(object.toMap());
      print(documentSucessfullyUpdate);
    } catch (erro) {
      print("$documentErrorUpdate --> ${erro.toString()}");
    }
  }

  @override
  Future<List<Acompanhar>> buscarTodos() async {
    List<Acompanhar> usuariosAcompanhadores = [];
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .get()
          .then((res) {
        res.docs.map(
            (e) async => usuariosAcompanhadores.add(Acompanhar.fromMap(e.data())));
      });
      print(documentSucessfullyRetriveAll);
    } catch (erro) {
      print("$documentErrorRetriveAll --> ${erro.toString()}");
    }

    return usuariosAcompanhadores;
  }

  @override
  Future<Acompanhar> buscar() async {
    Acompanhar acompanhar = Acompanhar();

    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .get();
      print(documentSucessfullyRetrive);
    } catch (erro) {
      print("$documentErrorRetrive --> ${erro.toString()}");
    }

    return acompanhar;
  }

  @override
  Future<void> deletar(Acompanhar object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .delete();
      print(documentSucessfullyDelete);
    } catch (erro) {
      print("$documentErrorDelete --> ${erro.toString()}");
    }
  }

}

*/