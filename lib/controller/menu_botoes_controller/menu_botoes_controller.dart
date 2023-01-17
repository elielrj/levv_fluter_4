import 'package:flutter/material.dart';
import 'package:levv4/api/imagem/image_levv.dart';

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
}
