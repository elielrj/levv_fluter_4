import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/api/texto/text_banco_de_dados.dart';
import 'package:levv4/model/dao/arquivo/arquivo_dao.dart';
import 'package:levv4/model/dao/meio_de_transporte/motorizado/i_crud_motorizado_dao.dart';
import '../../../bo/meio_de_transporte/carro.dart';

class CarroDAO
    with NomeDoDocumentoDoUsuarioCorrente
    implements ICrudMotorizadoDAO<Carro> {
  final collectionPath = "meios_de_transportes";

  static const documentSucessfullyCreate =
      "CarroDAO: DocumentSnapshot successfully create!";
  static const documentSucessfullyUpdate =
      "CarroDAO: DocumentSnapshot successfully update!";
  static const documentSucessfullyRetrive =
      "CarroDAO: DocumentSnapshot successfully retrive!";
  static const documentSucessfullyRetriveAll =
      "CarroDAO: DocumentSnapshot successfully retrive all!";
  static const documentSucessfullyDelete =
      "CarroDAO: DocumentSnapshot successfully delete!";

  static const documentErrorCreate = "CarroDAO: Error crete document!";
  static const documentErrorUpdate = "CarroDAO: Error update document!";
  static const documentErrorRetrive = "CarroDAO: Error retrive document!";
  static const documentErrorRetriveAll =
      "CarroDAO: Error retrive all document!";
  static const documentErrorDelete = "CarroDAO: Error delete document!";

  @override
  Future<void> criar(Carro object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .set(await toMap(object))
          .then((value) => print(documentSucessfullyCreate),
              onError: (e) => print("$documentErrorCreate--> ${e.toString}"));
      print(documentSucessfullyCreate);
    } catch (erro) {
      print("$documentErrorCreate--> ${erro.toString()}");
    }
  }

  @override
  Future<void> atualizar(Carro object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .update(await toMap(object))
          .then((value) => print(documentSucessfullyUpdate),
              onError: (e) => print("$documentErrorUpdate--> ${e.toString}"));
      print(documentSucessfullyUpdate);
    } catch (erro) {
      print("$documentErrorUpdate--> ${erro.toString()}");
    }
  }

  Future<Carro> buscar() async {
    Carro carro = Carro();
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .get()
          .then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;

          carro = fromMap(data);
          print(documentSucessfullyRetrive);
        },
        onError: (e) => print("$documentErrorRetrive--> ${e.toString}"),
      );
      print(documentSucessfullyRetrive);
    } catch (erro) {
      print("$documentErrorRetrive--> ${erro.toString()}");
    }

    return carro;
  }

  @override
  Future<List<Carro>> buscarTodos() async {
    List<Carro> carros = [];
    try {
      await FirebaseFirestore.instance.collection(collectionPath).get().then(
        (res) {
          res.docs.map((e) => carros.add(fromMap(e.data())));
          print(documentSucessfullyRetriveAll);
        },
        onError: (e) => print("$documentErrorRetriveAll--> ${e.toString()}"),
      );
      print(documentSucessfullyRetriveAll);
    } catch (erro) {
      print("$documentErrorRetriveAll--> ${erro.toString()}");
    }

    return carros;
  }

/*
  @override
  Future<Carro> buscarUmUsuarioPeloNomeDoDocumento(String reference) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(reference)
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        return fromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }*/

  @override
  Future<void> deletar(Carro object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .delete()
          .then(
            (doc) => print(documentSucessfullyDelete),
            onError: (e) => print("$documentErrorDelete--> ${e.toString()}"),
          );
      print(documentSucessfullyDelete);
    } catch (erro) {
      print("$documentErrorDelete--> ${erro.toString()}");
    }
  }

  @override
  Future<Map<String, dynamic>> toMap(Carro object) async {

    final arquivoDAO = ArquivoDAO();
    await arquivoDAO.upload(object.documentoDoVeiculo!);

    return {
      if (object.modelo != null) TextBancoDeDados.MODELO: object.modelo,
      if (object.marca != null) TextBancoDeDados.MARCA: object.marca,
      if (object.cor != null) TextBancoDeDados.COR: object.cor,
      if (object.placa != null) TextBancoDeDados.PLACA: object.placa,
      if (object.renavam != null) TextBancoDeDados.RENAVAN: object.renavam,
    };
  }

  @override
  Carro fromMap(Map<String, dynamic> map) {
    return Carro(
      modelo: map[TextBancoDeDados.MODELO],
      marca: map[TextBancoDeDados.MARCA],
      cor: map[TextBancoDeDados.COR],
      placa: map[TextBancoDeDados.PLACA],
      renavam: map[TextBancoDeDados.RENAVAN],
    );
  }
}
