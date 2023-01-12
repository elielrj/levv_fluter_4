
import 'package:flutter/cupertino.dart';

class ListaDeStatusDosBotoes extends ChangeNotifier{
  final List<bool> _listaDeStatusDosBotoes = [true, false, false];

  List<bool> get listaDeStatusDosBotoes => _listaDeStatusDosBotoes;
}