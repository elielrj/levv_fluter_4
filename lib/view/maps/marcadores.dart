import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  carregarMarcadores({required Map<String, LatLng> tituloComLatLng}) {
    tituloComLatLng.forEach((key, value) {
      carregarMarcador(tituloDoMarcador: key, marcadoDeLatLng: value);
    });
  }

  limparMarcadores() {
    marcadores = {};
  }
}
