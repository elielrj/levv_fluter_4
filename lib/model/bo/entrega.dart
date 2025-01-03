import 'celular.dart';
import 'pedido/pedido_de_entrega.dart';

class Entrega {
  PedidoDeEntrega _pedido;
  Celular _celular;

  Entrega(
    this._pedido,
    this._celular,
  );
}
