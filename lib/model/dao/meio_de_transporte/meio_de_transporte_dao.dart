import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/dao/meio_de_transporte/i_crud_meio_de_transporte_dao.dart';
import 'package:levv4/model/dao/meio_de_transporte/mixin_meio_de_transporte_create.dart';
import 'package:levv4/model/dao/meio_de_transporte/mixin_meio_de_transporte_delete.dart';
import 'package:levv4/model/dao/meio_de_transporte/mixin_meio_de_transporte_retrive.dart';
import 'package:levv4/model/dao/meio_de_transporte/mixin_meio_de_transporte_update.dart';

class MeioDeTransporteDAO with MixinMeioDeTransporteCreate,
    MixinMeioDeTransporteUpdate,
    MixinMeioDeTransporteDelete,
    MixinMeioDeTransporteRetrive
    implements ICrudMeioDeTransporteDAO<MeioDeTransporte>{

  final collectionPath = "meio_de_transporte";

  static const documentSucessfullyCreate =
      "MeioDeTransporteDAO: DocumentSnapshot successfully create!";
  static const documentSucessfullyUpdate =
      "MeioDeTransporteDAO: DocumentSnapshot successfully update!";
  static const documentSucessfullyRetrive =
      "MeioDeTransporteDAO: DocumentSnapshot successfully retrive!";
  static const documentSucessfullyRetriveAll =
      "MeioDeTransporteDAO: DocumentSnapshot successfully retrive all!";
  static const documentSucessfullyDelete =
      "MeioDeTransporteDAO: DocumentSnapshot successfully delete!";

  static const documentErrorCreate = "MeioDeTransporteDAO: Error crete document!";
  static const documentErrorUpdate = "MeioDeTransporteDAO: Error update document!";
  static const documentErrorRetrive = "MeioDeTransporteDAO: Error retrive document!";
  static const documentErrorRetriveAll =
      "MeioDeTransporteDAO: Error retrive all document!";
  static const documentErrorDelete = "MeioDeTransporteDAO: Error delete document!";
  
  @override
  Future<void> criar(MeioDeTransporte object) async {
    try{
      await createMeioDeTransporte(object);
      print(documentSucessfullyCreate);
    }catch(erro){
      print("$documentErrorCreate--> ${erro.toString()}");
    }

  }

  @override
  Future<void> atualizar(MeioDeTransporte object)async  {
    try{
      await updateMeioDeTransporte(object);
      print(documentSucessfullyCreate);
    }catch(erro){
      print("$documentErrorCreate--> ${erro.toString()}");
    }
    
  }

  @override
  Future<MeioDeTransporte> buscar(String nomeDoMeioDeTransporte) async {
    MeioDeTransporte meioDeTransporte = APe();
    try{
      meioDeTransporte = await retriveMeioDeTransporte(nomeDoMeioDeTransporte);
      print(documentSucessfullyCreate);
    }catch(erro){
      print("$documentErrorCreate--> ${erro.toString()}");
    }
    return meioDeTransporte;
  }

  @override
  Future<List<MeioDeTransporte>> buscarTodos() {
    // TODO: implement buscarTodos
    throw UnimplementedError();
  }

  @override
  Future<void> deletar(MeioDeTransporte object) async {
    try{
      await deleteMeioDeTransporte(object);
      print(documentSucessfullyCreate);
    }catch(erro){
      print("$documentErrorCreate--> ${erro.toString()}");
    }
  }

  @override
  MeioDeTransporte fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap(MeioDeTransporte object) {
    // TODO: implement toMap
    throw UnimplementedError();
  }
  
}