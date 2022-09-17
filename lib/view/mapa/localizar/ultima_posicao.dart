import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

mixin UltimaPosicao{
  Future<Position?> ultimaPosicao() async {
    return await Geolocator.getLastKnownPosition();
  }
}