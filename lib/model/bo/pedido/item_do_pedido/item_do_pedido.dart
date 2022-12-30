import 'package:flutter/foundation.dart';

import '../../endereco/endereco.dart';

class ItemDoPedido extends ChangeNotifier {
  int? ordem;
  Endereco? coleta;
  Endereco? entrega;

  ItemDoPedido({this.ordem, this.coleta, this.entrega});

  void limpar() {
    coleta = null;
    entrega = null;
    ordem = null;
    notifyListeners();
  }
}
