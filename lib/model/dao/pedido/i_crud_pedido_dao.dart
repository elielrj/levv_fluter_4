import 'package:levv4/model/bo/pedido/pedido.dart';

abstract class ICrudPedidoDAO<T> {
  Future<void> criar(T object);

  Future<void> atualizar(T object);

  Future<List<Pedido>> buscarTodos();

  Future<List<Pedido>> buscarPedidosDoUsuario({int limite = 10});

  Future<List<Pedido>> buscarPedidosPorCidade(String cidade,{int limite = 10});

 // Future<void> buscarUmUsuarioPeloNomeDoDocumento(String reference);

  Future<void> deletar(T object);

  Map<String, dynamic> toMap(T object);

  T fromMap(Map<String, dynamic> map);
}