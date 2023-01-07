import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';

class TelaAcompanharController {
  List<Pedido> listaDePedidosDoUsuario = [];

  final pedidoDAO = PedidoDAO();

  Future<void> buscarListaDePedidosDoUsuario() async {
    try {
      listaDePedidosDoUsuario = await pedidoDAO.buscarPedidosDoUsuario();
      print('sucess ao buscar pedido!');
    } catch (error) {
      print("Erro ao buscar pedidos do usuário!");
    }
  }
}
