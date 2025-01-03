

import 'package:geolocator/geolocator.dart';


import 'package:levv4/model/bo/pedido_old/item_do_pedido.dart';

class CalcularDistaciaDoPedido {
  static double calcularDistancia({required ItemDoPedido itemDoPedido})  {

     ///start
   double startLatitude = itemDoPedido.coleta!.geolocalizacao!.longitude;
   double startLongitude = itemDoPedido.coleta!.geolocalizacao!.longitude;

    ///end
   double endLatitude = itemDoPedido.entrega!.geolocalizacao!.longitude;
   double endLongitude = itemDoPedido.entrega!.geolocalizacao!.longitude;

    ///distância
    return Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
  }
}
