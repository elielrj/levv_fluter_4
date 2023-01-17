import 'package:flutter/material.dart';
import 'package:levv4/api/mascara/formatter_valor_em_real.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/api/numerador_de_pedido/numerador_de_pedido.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/entregar/entregar.dart';
import 'package:levv4/model/bo/enviar/enviar.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';
import 'package:levv4/view/enviar/rota_do_pedido.dart';
import 'package:levv4/view/localizar/localizar/localizar.dart';

class CriadorDePedido extends ChangeNotifier {



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

  Future<void> enviarPedido({required Usuario usuario}) async {

    final numeradorDePedido = NumeradorDePedido();
    _pedido.numero = numeradorDePedido.criarNumeroDoPedido();
    _pedido.pedidoFoiPago = false;
    _pedido.pedidoFoiEntregue = false;
    _pedido.pedidoEstaDisponivelParaEntrega = true;
    _pedido.dataHoraDeCriacaoDoPedido = DateTime.now();
    _pedido.usuarioDonoDoPedido = usuario;


    final localizar = Localizar();
    Endereco? endereco = await localizar.converterPositionEmEndereco(await localizar.determinarPosicao());
    if(endereco != null){
      _pedido.municipioDoPedido = endereco.cidade;
      print("Municipio do pedido obtido com sucesso: ${_pedido.municipioDoPedido}");
    }  else{
      _pedido.municipioDoPedido = _pedido.itensDoPedido![0].coleta!.cidade;
      print("Municipio do pedido não obtido com sucesso: ${_pedido.municipioDoPedido}");
    }




    final pedidoDAO = PedidoDAO();
    await pedidoDAO.criar(_pedido);
  }

  bool pedidoEstaCompleto() {
    for (ItemDoPedido itemDoPedido in _pedido.itensDoPedido!) {
      if (itemDoPedido.coleta != null &&
          itemDoPedido.entrega != null) {
        if(itemDoPedido.coleta!.geolocalizacao != Endereco.MARCO_ZERO &&
            itemDoPedido.entrega!.geolocalizacao != Endereco.MARCO_ZERO){
          return true;
        }

      }
    }
    return false;
  }

  void limparPedido() {
    _pedido.limparPedido();
    calcularValorDoPedido();
    notifyListeners();
  }

  void calcularValorDoPedido() {
    if (pedidoEstaCompleto()) {
      _pedido.calcularValor();
    }

    double total = _pedido.valor ?? 0.00;

    String novoValor = (total).toStringAsFixed(2).replaceAll('.', ',');

    controllerValorPedido.textEditingController.text = novoValor;
    controllerValorPedido.textEditingController.notifyListeners();

    notifyListeners();

    print("calculo do valor->>>> ${valorDoPedido.toString()}");
  }
}
