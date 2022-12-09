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
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .set(await toMap(object))
        .then((value) => print(documentSucessfullyCreate),
            onError: (e) => print("$documentErrorCreate --> ${e.toString()}"));
  }

  @override
  Future<void> atualizar(Enviar object) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .update(await toMap(object))
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

        enviar = await fromMap(data);
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
            .map((e) async => enviadoresDePedido.add(await fromMap(e.data())));
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

  @override
  Future<Map<String, dynamic>> toMap(Enviar object) async {
    final arquivoDAO = ArquivoDAO();
    await arquivoDAO.upload(object.documentoDeIdentificacao!);

    return {
      if (object.exibirPerfil() != null) "perfil": object.exibirPerfil(),
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
    );
  }
}
