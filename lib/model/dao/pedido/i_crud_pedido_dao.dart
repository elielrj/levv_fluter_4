import 'package:levv4/model/bo/pedido_old/pedido_old.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';

abstract class ICrudPedidoDAO<T> {
  Future<void> criar(T object);

  Future<void> atualizar(T object);

  Future<List<PedidoOld>> buscarTodos();

  Future<void> buscarPedidosDoUsuario({required Usuario usuario,int limite = 10});

  Future<List<PedidoOld>> buscarPedidosPorCidade(String cidade,{required Usuario usuario,int limite = 10});

 // Future<void> buscarUmUsuarioPeloNomeDoDocumento(String reference);

  Future<void> deletar(T object);

  //Map<String, dynamic> toMap(T object);

  //T fromMap(Map<String, dynamic> map);
}