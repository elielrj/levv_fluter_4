import 'package:levv4/model/bo/entrega.dart';
import 'pedido/pedido_de_entrega.dart';

class Celular {
  String _numero;
  String _ddd;
  List<PedidoDeEntrega> _pedidos;
  List<Entrega> _entregas;

  Celular(
    this._numero,
    this._ddd,
    this._pedidos,
    this._entregas,
  );
}
