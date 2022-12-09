import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';

abstract class ICrudMeioDeTransporteDAO<T> {
  Future<void> criar(T object);

  Future<void> atualizar(T object);

  Future<MeioDeTransporte> buscar(String nomeDoMeioDeTransporte);

  Future<List<MeioDeTransporte>> buscarTodos();

  Future<void> deletar(T object);

  Map<String, dynamic> toMap(T object);

  T fromMap(Map<String, dynamic> map);
}
