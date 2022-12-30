import 'package:flutter/cupertino.dart';
import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';

import 'item_do_pedido/item_do_pedido.dart';
import '../meio_de_transporte/meio_de_transporte.dart';

class Pedido extends ChangeNotifier{
  String? numero;
  double? valor;
  bool? pedidoEstaDisponivelParaEntrega;
  bool? pedidoFoiEntregue;
  bool? pedidoFoiPago;
  DateTime? dataHoraDeCriacaoDoPedido;
  List<ItemDoPedido>? itensDoPedido;
  Usuario? transportadorDoPedido;
  Usuario? usuarioDonoDoPedido;
  int? transporte;
  int? volume;
  int? peso;

  Pedido(
      {this.numero,
      this.valor,
      this.pedidoEstaDisponivelParaEntrega,
      this.pedidoFoiEntregue,
      this.pedidoFoiPago,
      this.dataHoraDeCriacaoDoPedido,
      this.itensDoPedido,
      this.transportadorDoPedido,
      this.usuarioDonoDoPedido,
      this.transporte,
      this.volume,
      this.peso}) {
    itensDoPedido ??= [ItemDoPedido(ordem: 1)];
    peso ??= 0;
    volume ??= 0;
    transporte ??= Moto.VALUE;
    valor ??= 0;
  }

  limparPedido() {
    numero = "";
    valor = 0.00;
    pedidoEstaDisponivelParaEntrega = false;
    pedidoFoiEntregue = false;
    pedidoFoiPago = false;
    dataHoraDeCriacaoDoPedido = DateTime.now();
    itensDoPedido = [ItemDoPedido(ordem: 1)];
    transporte = Moto.VALUE;
    volume = 0;
    peso = 0;
notifyListeners();
  }

  calcularValor() {
    //todo Fórmula p/ calcular
    valor = 1.00;
  }

  double calcularDistancia(){
    //todo fazer
    return 10.0;
  }
}
