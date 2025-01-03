import 'package:levv4/controller/menu_botoes_controller/menu_botoes_controller.dart';
import 'package:flutter/material.dart';
import 'package:levv4/model/bo/pedido_old/pedido_old.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';

class TelaAcompanharController extends ChangeNotifier{

  final MenuBotoesController menuDosBotoesController = MenuBotoesController();

  void adicionarPedidos({required List<PedidoOld> listaDePedidos, required Usuario usuario}){

    usuario.listaDePedidos = listaDePedidos;

  }


}