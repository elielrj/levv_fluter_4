import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/bo/map/interface_map.dart';
import 'item_do_pedido.dart';

@deprecated
class PedidoOld extends ChangeNotifier implements InterfaceMap {
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
  String? municipioDoPedido;

  PedidoOld(
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
      this.peso,
      this.municipioDoPedido}) {
    itensDoPedido ??= [ItemDoPedido(ordem: 1)];
    peso ??= 0;
    volume ??= 0;
    transporte ??= Moto.VALUE;
    valor ??= 0;
  }

  void limparPedido() {
    numero = null;
    valor = 0.00;
    pedidoEstaDisponivelParaEntrega = false;
    pedidoFoiEntregue = false;
    pedidoFoiPago = false;
    dataHoraDeCriacaoDoPedido = DateTime.now();
    //itensDoPedido = [ItemDoPedido(ordem: 1)];
    if (itensDoPedido!.length > 1) {
      itensDoPedido!.removeRange(1, itensDoPedido!.length);
    }

    itensDoPedido!.first.limpar();
    transporte = Moto.VALUE;
    volume = 0;
    peso = 0;

    notifyListeners();
  }

  calcularValor() {
    //todo Fórmula p/ calcular
    valor = 1.00;
  }

  double calcularDistancia() {
    //todo fazer
    return 10.0;
  }

  factory PedidoOld.fromMap(Map<String, dynamic> map) {
    Timestamp timestamp = map["dataHoraDeCriacaoDoPedido"];

    Map<String, dynamic> mapaDeItens = map['itensDoPedido'];

    List<ItemDoPedido> itens = [];

    mapaDeItens.forEach((key, value) {
      itens.add(ItemDoPedido.fromMap(value));
    });
   // mapaDeItens.values.forEach((element) {
    //  itens.add(ItemDoPedido.fromMap(element));
    //});

    Usuario? usuario;
    Map<String,dynamic> mapaDoUsuarioTransportador = map['transportadorDoPedido']??{};
    if(mapaDoUsuarioTransportador.isNotEmpty){
      Usuario? usuario = Usuario.fromMap(map['transportadorDoPedido']);
    }


    return PedidoOld(
      numero: map['numero'],
      valor: map['valor'],
      pedidoEstaDisponivelParaEntrega: map['pedidoEstaDisponivelParaEntrega'],
      pedidoFoiEntregue: map['pedidoFoiEntregue'],
      pedidoFoiPago: map['pedidoFoiPago'],
      dataHoraDeCriacaoDoPedido: timestamp.toDate(),
      transporte: map['transporte'],
      itensDoPedido: itens,
      transportadorDoPedido: usuario,
      volume: map['volume'],
      peso: map['peso'],
      usuarioDonoDoPedido: Usuario.fromMap(map['usuarioDonoDoPedido']),
      municipioDoPedido: map['municipioDoPedido'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapaDeItens = {};
    itensDoPedido!.forEach((element) {
      mapaDeItens.addAll({
        element.ordem.toString(): element.toMap(),
      });
    });

    return Map.from({
      if (numero != null) 'numero': numero,
      if (valor != null) 'valor': valor,
      if (pedidoEstaDisponivelParaEntrega != null)
        'pedidoEstaDisponivelParaEntrega': pedidoEstaDisponivelParaEntrega,
      if (pedidoFoiEntregue != null) 'pedidoFoiEntregue': pedidoFoiEntregue,
      if (pedidoFoiPago != null) 'pedidoFoiPago': pedidoFoiPago,
      if (dataHoraDeCriacaoDoPedido != null)
        'dataHoraDeCriacaoDoPedido': Timestamp.fromMillisecondsSinceEpoch(
            dataHoraDeCriacaoDoPedido!.millisecondsSinceEpoch),
      if (transporte != null) 'transporte': transporte,
      if (itensDoPedido != null) 'itensDoPedido': mapaDeItens,
      if (transportadorDoPedido != null)
        'transportadorDoPedido': transportadorDoPedido!
            .toMap()
            .update('enderecosFavoritos', (value) => {}),
      if (usuarioDonoDoPedido != null)
        'usuarioDonoDoPedido': usuarioDonoDoPedido!.toMap(),
      if (volume != null) 'volume': volume,
      if (peso != null) 'peso': peso,
      if (municipioDoPedido != null) 'municipioDoPedido': municipioDoPedido,
    });
  }


}
