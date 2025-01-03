import 'endereco/endereco.dart';

class PedidoDeEntrega {
  String _numero;
  double _valor;
  bool _isDisponivel;
  bool _isEntregue;
  bool _isPago;
  DateTime _criado;
  Endereco _coleta;
  Endereco _entrega;

  PedidoDeEntrega(
    this._numero,
    this._valor,
    this._isDisponivel,
    this._isEntregue,
    this._isPago,
    this._criado,
    this._coleta,
    this._entrega,
  );
}
