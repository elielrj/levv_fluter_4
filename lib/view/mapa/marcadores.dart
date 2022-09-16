import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../model/bo/pedido/item_do_pedido/item_do_pedido.dart';

mixin Marcadores {
  Set<Marker> marcadores = {};

  carregarMarcador(
      {required String tituloDoMarcador, required LatLng marcadoDeLatLng}) {
    marcadores.add(Marker(
      markerId: MarkerId("marcador-${marcadores.length + 1}"),
      position: marcadoDeLatLng,
      infoWindow: InfoWindow(title: tituloDoMarcador),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ));
  }

  carregarMarcadores({required List<ItemDoPedido> itensDoPedido}) {
    for (ItemDoPedido item in itensDoPedido) {
      carregarMarcador(
          tituloDoMarcador: "${item.ordem!}º Coleta",
          marcadoDeLatLng: LatLng(item.coleta!.geolocalizacao!.latitude,
              item.coleta!.geolocalizacao!.longitude));

      carregarMarcador(
          tituloDoMarcador: "${item.ordem!}º Entrega",
          marcadoDeLatLng: LatLng(item.entrega!.geolocalizacao!.latitude,
              item.entrega!.geolocalizacao!.longitude));
    }
  }

  limparMarcadores() {
    marcadores.clear();
  }

}
