import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';

class TelaEntregarController {
  final pedidoDAO = PedidoDAO();
  List<Pedido> listaDePedidosDoUsuario = [];

  Future<void> buscarListaDePedidosDoUsuario() async {
    listaDePedidosDoUsuario = await pedidoDAO.buscarPedidosDoUsuario();
  }
}
