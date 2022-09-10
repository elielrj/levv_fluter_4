import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Localizar {

  static get LATLNG_TUBARAO => const LatLng(-28.467, -49.0075);

  Future<Position> localizacaoAtual() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
