import 'package:levv4/model/bo/usuario/usuario.dart';

import 'item_do_pedido/item_do_pedido.dart';
import '../meio_de_transporte/meio_de_transporte.dart';

class Pedido {
  String? numero;
  double? valor;
  bool? pedidoEstaDisponivelParaEntrega;
  bool? pedidoFoiEntregue;
  bool? pedidoFoiPago;
  DateTime? dataHoraDeCriacaoDoPedido;
  List<ItemDoPedido>? itensDoPedido;
  Usuario? transportadorDoPedido;
  Usuario? usuarioDonoDoPedido;
  MeioDeTransporte? transporte;
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
    itensDoPedido ??= [];
  }

  limparPedido() {
    numero = "";
    valor = 0.0;
    pedidoEstaDisponivelParaEntrega = false;
    pedidoFoiEntregue = false;
    pedidoFoiPago = false;
    dataHoraDeCriacaoDoPedido = DateTime.now();
    itensDoPedido = [];
    volume = 0;
    peso = 0;
  }
}
