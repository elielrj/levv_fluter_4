import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

mixin Polylines {
  Set<Polyline> listaDePolylines = {};

  carregarPolylines(
      {required List<LatLng> listaDeLatLng, required Color corDaLinha}) {
    listaDePolylines.add(Polyline(
        polylineId: PolylineId("polyline-${listaDePolylines.length + 1}"),
        color: corDaLinha,
        width: 20,
        points: [for (var latLng in listaDeLatLng) latLng]));
  }

  limparPolylines(){
    listaDePolylines = {};
  }
}
