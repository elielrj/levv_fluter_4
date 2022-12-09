import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';

import 'package:levv4/model/bo/administrar/administrar.dart';
import 'interface_usuario_dao.dart';

class AdministrarDAO
    with NomeDoDocumentoDoUsuarioCorrente
    implements InterfaceUsuarioDAO<Administrar> {
  final collectionPath = "administrar";

  static const documentSucessfullyCreate =
      "AdministrarDAO DocumentSnapshot successfully create!";
  static const documentSucessfullyUpdate =
      "AdministrarDAO DocumentSnapshot successfully update!";
  static const documentSucessfullyRetrive =
      "AdministrarDAO DocumentSnapshot successfully retrive!";
  static const documentSucessfullyRetriveAll =
      "AdministrarDAO DocumentSnapshot successfully retrive all!";
  static const documentSucessfullyDelete =
      "AdministrarDAO DocumentSnapshot successfully delete!";

  static const documentErrorCreate = "AdministrarDAO Error crete document!";
  static const documentErrorUpdate = "AdministrarDAO Error update document!";
  static const documentErrorRetrive = "AdministrarDAO Error retrive document!";
  static const documentErrorRetriveAll =
      "AdministrarDAO Error retrive all document!";
  static const documentErrorDelete = "AdministrarDAO Error delete document!";

  @override
  Future<void> criar(Administrar object) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .set(await toMap(object))
        .then((value) => print(documentSucessfullyCreate),
            onError: (e) => print("$documentErrorCreate --> ${e.toString()}"));
  }

  @override
  Future<void> atualizar(Administrar object) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .update(await toMap(object))
        .then((value) => print(documentSucessfullyUpdate),
            onError: (e) => print("$documentErrorUpdate --> ${e.toString()}"));
  }

  @override
  Future<Administrar?> buscarTodos() async {
    List<Administrar> usuariosAdministradores = [];

    await FirebaseFirestore.instance.collection(collectionPath).get().then(
      (res) {
        res.docs.map(
            (e) async => usuariosAdministradores.add(await fromMap(e.data())));
        print(documentSucessfullyRetriveAll);
      },
      onError: (e) => print("$documentErrorRetriveAll--> ${e.toString()}"),
    );
  }

  @override
  Future<Administrar> buscar() async {
    Administrar administrar = Administrar();

    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .get()
        .then(
      (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;

        administrar = await fromMap(data);
        print(documentSucessfullyRetrive);
      },
      onError: (e) => print("$documentErrorRetrive --> $e"),
    );

    return administrar;
  }

  @override
  Future<void> deletar(Administrar object) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .delete()
        .then(
          (doc) => print(documentSucessfullyDelete),
          onError: (e) => print("$documentErrorDelete--> ${e.toString()}"),
        );
  }

  @override
  Future<Map<String, dynamic>> toMap(Administrar object) async {
    return {
      if (object.exibirPerfil() != null) "perfil": object.exibirPerfil(),
    };
  }

  @override
  Future<Administrar> fromMap(Map<String, dynamic> map) async {
    return Administrar();
  }
}
