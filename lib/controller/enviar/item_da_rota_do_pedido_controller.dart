import 'package:flutter/material.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';


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

  void trocarStatusDeVisualizacaoDeMapa(){
    isShowMap = !isShowMap;
  }


}