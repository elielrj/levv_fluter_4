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
    ordem = 1;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      if (ordem != null) "ordem": ordem,
      if (coleta != null) "coleta": coleta?.toMap(),
      if (entrega != null) "entrega": entrega?.toMap(),
    };
  }

  factory ItemDoPedido.fromMap(Map<String, dynamic> map) {
    return ItemDoPedido(
      ordem: map['ordem'],
      coleta: Endereco.fromMap(map['coleta']),
      entrega: Endereco.fromMap(map['entrega']),
    );
  }
}
