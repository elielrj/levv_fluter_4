import 'pedido/pedido.dart';

class Celular {
  String _numero;
  String _ddd;
  List<Pedido> _listaDePedidos;
  Pedido _entrega;

  Celular(
    this._numero,
    this._ddd,
    this._listaDePedidos,
    this._entrega,
  );
}
