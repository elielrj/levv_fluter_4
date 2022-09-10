import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

mixin Poligonos {
  Set<Polygon> listaDePoligonos = {};

  desenharPoligono(List<LatLng> listaDeLatLng) {
    listaDePoligonos.add(Polygon(
        polygonId: PolygonId("poligono-${listaDePoligonos.length + 1}"),
        fillColor: Colors.transparent,
        strokeColor: Colors.black,
        strokeWidth: 10,
        points: [for (var latLng in listaDeLatLng) latLng]));
  }

  limparPoligonos() {
    listaDePoligonos = {};
  }
}
