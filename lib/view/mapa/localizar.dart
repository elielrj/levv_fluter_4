import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Localizar {

  static get LATLNG_TUBARAO => const LatLng(-28.467, -49.0075);
  static get LATLNG_TUBARAO_TESTE_PRIMEIRA_ENTREGA => const GeoPoint(-28.4650, -49.0043);
  static get LATLNG_TUBARAO_TESTE_PRIMEIRA_COLETA => const GeoPoint(-28.4640, -49.0343);
  static get LATLNG_TUBARAO_TESTE_SEGUNDA_COLETA => const GeoPoint(-28.4635, -49.0236);
  static get LATLNG_TUBARAO_TESTE_SEGUNDA_ENTREGA => const GeoPoint(-28.4678, -49.0170);



  Future<Position> localizacaoAtual({LocationAccuracy? locationAccuracy}) async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: locationAccuracy?? LocationAccuracy.high);
  }
}
