import 'package:flutter/material.dart';
import 'package:levv4/api/mascara/formatter_valor_em_real.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';

class CriadorDePedido  extends ChangeNotifier{

  final Mask controllerValorPedido = Mask(formatter: FormatterValorEmReal());

  final Pedido _pedido = Pedido();

  int pesoDoPedido() => _pedido.peso ?? 0;

  void novoPesoDoPedido(int novoPeso) {
    _pedido.peso = novoPeso;
  }

  int volumeDoPedido() => _pedido.volume ?? 0;

  void novoVolumeDoPedido(int novoVolume) {
    _pedido.volume = novoVolume;
  }

  int meioDeTransporte() => _pedido.transporte ?? 2;

  void novoMeioDeTransporte(int novoMeioDeTransporte) {
    _pedido.transporte = novoMeioDeTransporte;
  }

  // double valorDoPedido() => _pedido.valor ?? 0.00;
  double? get valorDoPedido => _pedido.valor;

  List<ItemDoPedido> get itensDoPedido =>
      _pedido.itensDoPedido ??= [ItemDoPedido()];

  Future<void> enviarPedido() async {
    final pedidoDAO = PedidoDAO();
    await pedidoDAO.criar(_pedido);
  }

  bool pedidoEstaCompleto() {
    for (ItemDoPedido itemDoPedido in _pedido.itensDoPedido!) {
      if (itemDoPedido.coleta != null &&
          itemDoPedido.entrega != null) {
        return true;
      }
    }
    return false;
  }

  limparPedido() {
    _pedido.limparPedido();
    notifyListeners();
  }

  void calcularValorDoPedido() {
    if(pedidoEstaCompleto()){
      _pedido.calcularValor();

      double total = _pedido.valor?? 0.00;

      String novoValor = (total).toStringAsFixed(2).replaceAll('.', ',');

      controllerValorPedido.textEditingController.text = novoValor;

      notifyListeners();

    }
  print("calculo do valor->>>> ${valorDoPedido.toString()}");
  }
}
