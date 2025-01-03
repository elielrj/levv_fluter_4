import 'package:flutter/cupertino.dart';
import 'package:levv4/model/bo/pedido_old/pedido_old.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';
import '../../model/bo/endereco/endereco.dart';
import 'package:geolocator/geolocator.dart';
import 'package:levv4/view/localizar/localizar/localizar.dart';
import 'package:levv4/controller/menu_botoes_controller/menu_botoes_controller.dart';

class TelaEntregarController extends ChangeNotifier{


  final MenuBotoesController menuDosBotoesController = MenuBotoesController();
  Endereco? endereco;

  Future<void> enderecoAtual() async {
    try {
      final localizar = Localizar();
      Position? position = await localizar.determinarPosicao();
      endereco = await localizar.converterPositionEmEndereco(position);
      print("Busca de endereço com sucesso: ${endereco!.cidade}");
    } catch (erro) {
      print("Busca de endereço sem sucesso!");
    }
  }
  void adicionarPedidos({required List<PedidoOld> listaDePedidos, required Usuario usuario}){

    usuario.listaDePedidos = listaDePedidos;

  }
}
