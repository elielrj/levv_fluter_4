import 'package:flutter/cupertino.dart';

class ListaDeStatusDosBotoes extends ChangeNotifier {
  final List<bool> _listaDeStatusDosBotoes = [true, false, false];

  List<bool> get listaDeStatusDosBotoes => _listaDeStatusDosBotoes;

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
