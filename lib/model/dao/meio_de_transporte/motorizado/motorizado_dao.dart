
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/motorizado.dart';
import 'package:levv4/model/dao/meio_de_transporte/motorizado/i_crud_motorizado_dao.dart';
import 'package:levv4/model/dao/meio_de_transporte/motorizado/mixin_motorizado_atualizar.dart';
import 'package:levv4/model/dao/meio_de_transporte/motorizado/mixin_motorizado_criar.dart';
import 'package:levv4/model/dao/meio_de_transporte/motorizado/mixin_motorizado_delete.dart';

class MotorizadoDAO
    with MixinMotorizadoCriar, MixinMotorizadoAtualizar, MixinMotorizadoDelete
    implements ICrudMotorizadoDAO<Motorizado> {
  static const collectionPath = "motorizado";

  static const documentSucessfullyCreate =
      "MotorizadoDAO: DocumentSnapshot successfully create!";
  static const documentSucessfullyUpdate =
      "MotorizadoDAO: DocumentSnapshot successfully update!";

  static const documentSucessfullyDelete =
      "MotorizadoDAO: DocumentSnapshot successfully delete!";

  static const documentErrorCreate = "MotorizadoDAO: Error crete document!";
  static const documentErrorUpdate = "MotorizadoDAO: Error update document!";

  static const documentErrorDelete = "MotorizadoDAO: Error delete document!";

  @override
  Future<void> criar(Motorizado motorizado) async {
    try {
      await criarMotorizado(motorizado);
      print(documentSucessfullyCreate);
    } catch (erro) {
      print("$documentErrorCreate--> ${erro.toString()}");
    }
  }

  @override
  Future<void> atualizar(Motorizado motorizado) async {
    try {
      await atualizarMotorizado(motorizado);
      print(documentSucessfullyUpdate);
    } catch (erro) {
      print("$documentErrorUpdate--> ${erro.toString()}");
    }
  }

  @override
  Future<void> deletar(Motorizado motorizado) async {
    try {
      await deleMotorizado(motorizado);
      print(documentSucessfullyDelete);
    } catch (erro) {
      print("$documentErrorDelete--> ${erro.toString()}");
    }
  }
}
