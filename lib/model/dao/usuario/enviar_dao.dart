import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/bo/enviar/enviar.dart';
import 'package:levv4/model/dao/arquivo/arquivo_dao.dart';
import 'interface_usuario_dao.dart';

class EnviarDAO
    with NomeDoDocumentoDoUsuarioCorrente
    implements InterfaceUsuarioDAO<Enviar> {
  final collectionPath = "enviar";

  static const documentSucessfullyCreate =
      "EnviarDAO: DocumentSnapshot successfully create!";
  static const documentSucessfullyUpdate =
      "EnviarDAO: DocumentSnapshot successfully update!";
  static const documentSucessfullyRetrive =
      "EnviarDAO: DocumentSnapshot successfully retrive!";
  static const documentSucessfullyRetriveAll =
      "EnviarDAO: DocumentSnapshot successfully retrive all!";
  static const documentSucessfullyDelete =
      "EnviarDAO: DocumentSnapshot successfully delete!";

  static const documentErrorCreate = "EnviarDAO: Error crete document!";
  static const documentErrorUpdate = "EnviarDAO: Error update document!";
  static const documentErrorRetrive = "EnviarDAO: Error retrive document!";
  static const documentErrorRetriveAll =
      "EnviarDAO: Error retrive all document!";
  static const documentErrorDelete = "EnviarDAO: Error delete document!";

  @override
  Future<void> criar(Enviar object) async {
    await _enviar(object);
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .set(object.toMap())
        .then((value) => print(documentSucessfullyCreate),
            onError: (e) => print("$documentErrorCreate --> ${e.toString()}"));
  }

  @override
  Future<void> atualizar(Enviar object) async {
    await _enviar(object);
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .update(object.toMap())
        .then((value) => print(documentSucessfullyUpdate),
            onError: (e) => print("$documentErrorUpdate --> ${e.toString()}"));
  }

  @override
  Future<Enviar> buscar() async {
    Enviar enviar = Enviar();

    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .get()
        .then(
      (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;

        enviar = Enviar.fromMap(data);
        print(documentSucessfullyRetrive);
      },
      onError: (e) => print("$documentErrorRetrive --> ${e.toString()}"),
    );

    return enviar;
  }

  @override
  Future<List<Enviar>> buscarTodos() async {
    List<Enviar> enviadoresDePedido = [];

    await FirebaseFirestore.instance.collection(collectionPath).get().then(
      (res) {
        res.docs
            .map((e) async => enviadoresDePedido.add(Enviar.fromMap(e.data())));
        print(documentSucessfullyRetriveAll);
      },
      onError: (e) => print("$documentErrorRetriveAll --> $e"),
    );
    return enviadoresDePedido;
  }

  @override
  Future<void> deletar(Enviar object) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .delete()
        .then(
          (doc) => print(documentSucessfullyDelete),
          onError: (e) => print("$documentErrorDelete --> ${e.toString()}"),
        );
  }

  Future<void> _enviar(Enviar object) async {
    final arquivoDAO = ArquivoDAO();
    await arquivoDAO.upload(object.documentoDeIdentificacao!);
  }
}
