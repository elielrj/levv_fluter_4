import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';

abstract class ICrudMotorizadoDAO<T>{
  Future<void> criar(T object);
  Future<void> atualizar(T object);
  //Future<void> buscar();
  //Future<void> buscarComDocumentReference(DocumentReference documentReference);
  Future<void> deletar(T object);
}