import 'package:flutter/cupertino.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';
/*
class TelaEntregarController extends ChangeNotifier{

  Usuario? usuario;

  final pedidoDAO = PedidoDAO();

  final List<bool> listaDeStatusDosBotoes = [true, false, false];

  Future<void> buscarListaDePedidosDoUsuario(Usuario usuario) async {
    try{
      usuario = usuario;
      await pedidoDAO.buscarPedidosDoUsuario(usuario: usuario);
      notifyListeners();
    }catch(erro){
      print("Erro ao buscar pedidos para o usuário entregar!");
    }

  }
}
*/