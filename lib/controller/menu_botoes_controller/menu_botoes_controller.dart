import 'package:flutter/material.dart';
import 'package:levv4/api/imagem/image_levv.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';

class MenuBotoesController extends ChangeNotifier {
  final List<bool> _listaDeStatusDosBotoes = [true, false, false];

  List<bool> get listaDeStatusDosBotoes => _listaDeStatusDosBotoes;

  final List<String> listaDeNomeDosIcones = [
    ImageLevv.ICON_ACTIVE,
    ImageLevv.ICON_FINISHED,
    ImageLevv.ICON_PENDING
  ];

  final List<String> listaDeNomeDosBotoes = [
    "Ativos",
    "Finalizados",
    "Pendentes"
  ];

  void selecionarListaDePedidos(int index) {
    for (int vetor = 0; vetor < _listaDeStatusDosBotoes.length; vetor++) {
      _listaDeStatusDosBotoes[index] = true;
      if (vetor != index) {
        _listaDeStatusDosBotoes[vetor] = false;
      }
    }
    notifyListeners();
  }

  botaoSelecionado() {
    for (int index = 0; index < _listaDeStatusDosBotoes.length; index++) {
      if (_listaDeStatusDosBotoes[index]) {
        return index;
      }
    }
  }

  List<Pedido> pedidosSelecionados(Usuario usuario) {
    if (botaoSelecionado() == 0) {
      return usuario.listarPedidosAtivos();
    } else if (botaoSelecionado() == 1) {
      return usuario.listarPedidosFinalizados();
    } else {
      return usuario.listarPedidosPendentes();
    }
  }
}
