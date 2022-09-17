

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';

mixin ConverterEnderecos {
  Future<Endereco> converterEnderecoEmLatitudeLongitude(String address) async {
    List<Location> locations = await locationFromAddress(address);

    return await converterLatitudeLongitudeEmEndereco(
        latitude: locations[0].latitude, longitude: locations[0].longitude);
  }

  Future<Endereco> converterLatitudeLongitudeEmEndereco(
      {required double latitude, required double longitude}) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    return Endereco(
        logradouro: placemarks[0].thoroughfare,
        estado: placemarks[0].locality,
        geolocalizacao: GeoPoint(latitude, longitude),
        complemento: null,
        cep: placemarks[0].postalCode,
        cidade: placemarks[0].administrativeArea,
        bairro: placemarks[0].subLocality,
        numero: placemarks[0].subThoroughfare,
        pais: placemarks[0].country);
  }
}
