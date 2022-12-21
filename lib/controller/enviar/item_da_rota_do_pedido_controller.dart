import 'package:flutter/material.dart';


class ItemDaRotaDoPedidoController extends ChangeNotifier{

  final textEditingController = TextEditingController();

  bool isShowMap = false;

  void abrirMapa(){
    isShowMap = true;
  }

  void fecharMapa(){
    isShowMap = false;
    notifyListeners();
  }


}