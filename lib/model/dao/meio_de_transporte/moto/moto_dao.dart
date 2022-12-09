import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/api/firebase_banco_de_dados/bando_de_dados.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/motorizado.dart';
import 'package:levv4/model/dao/meio_de_transporte/motorizado/i_crud_motorizado_dao.dart';
import '../../../../api/firebase_autenticacao/autenticacao.dart';
import '../../../bo/meio_de_transporte/moto.dart';
import '../i_crud_meio_de_transporte_dao.dart';

class MotoDAO
    with NomeDoDocumentoDoUsuarioCorrente
    implements ICrudMotorizadoDAO<Moto> {
  final collectionPath = "meios_de_transportes";

  static const documentSucessfullyCreate =
      "MotoDAO: DocumentSnapshot successfully create!";
  static const documentSucessfullyUpdate =
      "MotoDAO: DocumentSnapshot successfully update!";
  static const documentSucessfullyRetrive =
      "MotoDAO: DocumentSnapshot successfully retrive!";
  static const documentSucessfullyRetriveAll =
      "MotoDAO: DocumentSnapshot successfully retrive all!";
  static const documentSucessfullyDelete =
      "MotoDAO: DocumentSnapshot successfully delete!";

  static const documentErrorCreate = "MotoDAO: Error crete document!";
  static const documentErrorUpdate = "MotoDAO: Error update document!";
  static const documentErrorRetrive = "MotoDAO: Error retrive document!";
  static const documentErrorRetriveAll = "MotoDAO: Error retrive all document!";
  static const documentErrorDelete = "MotoDAO: Error delete document!";

  @override
  Future<void> criar(Moto object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .set(toMap(object))
          .then((value) => print(documentSucessfullyCreate),
              onError: (e) => print("$documentErrorCreate--> ${e.toString}"));
      print(documentSucessfullyCreate);
    } catch (erro) {
      print("$documentErrorCreate--> ${erro.toString()}");
    }
  }

  @override
  Future<void> atualizar(Moto object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .update(toMap(object))
          .then((value) => print(documentSucessfullyUpdate),
              onError: (e) => print("$documentErrorUpdate--> ${e.toString}"));
      print(documentSucessfullyUpdate);
    } catch (erro) {
      print("$documentErrorUpdate--> ${erro.toString()}");
    }
  }

  Future<Moto> buscar() async {
    Moto moto = Moto();

    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .get()
          .then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;

          moto = fromMap(data);
          print(documentSucessfullyRetrive);
        },
        onError: (e) => print("$documentErrorRetrive--> ${e.toString}"),
      );
      print(documentSucessfullyRetrive);
    } catch (erro) {
      print("$documentErrorRetriveAll--> ${erro.toString()}");
    }

    return moto;
  }

  @override
  Future<List<Moto>> buscarTodos() async {
    List<Moto> motos = [];

    try {
      await FirebaseFirestore.instance.collection(collectionPath).get().then(
        (res) {
          res.docs.map((e) => motos.add(fromMap(e.data())));
          print(documentSucessfullyRetriveAll);
        },
        onError: (e) => print("$documentErrorRetriveAll--> ${e.toString}"),
      );
      print(documentSucessfullyRetriveAll);
    } catch (erro) {
      print("$documentErrorRetriveAll--> ${erro.toString()}");
    }

    return motos;
  }

  @override
  Future<void> deletar(Moto object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .delete()
          .then(
            (doc) => print(documentSucessfullyDelete),
            onError: (e) => print("$documentErrorDelete--> ${e.toString}"),
          );
      print(documentSucessfullyDelete);
    } catch (erro) {
      print("$documentErrorDelete--> ${erro.toString()}");
    }
  }

  @override
  Map<String, dynamic> toMap(Moto object) {
    return {
      if (object.modelo != null) "modelo": object.modelo,
      if (object.marca != null) "marca": object.marca,
      if (object.cor != null) "cor": object.cor,
      if (object.placa != null) "placa": object.placa,
      if (object.renavam != null) "renavam": object.renavam,
      if (object.documentoDoVeiculo != null)
        "documentoDoVeiculo": object.documentoDoVeiculo
    };
  }

  @override
  Moto fromMap(Map<String, dynamic> map) {
    return Moto(
      modelo: map["modelo"],
      marca: map["marca"],
      cor: map["cor"],
      placa: map["placa"],
      renavam: map["renavam"],
      documentoDoVeiculo: map["documentoDoVeiculo"],
    );
  }
}
