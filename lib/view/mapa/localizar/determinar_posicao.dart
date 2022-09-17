import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

mixin DeterminarPosicao{
  Future<Position> determinarPosicao() async {
    bool serviceEnabled;
    
    LocationPermission permission;
    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    
    if(!serviceEnabled){
      return Future.error("Serviço de localização está desavilitado!");
    }
    
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Permissão para usar a localização foi negada!");
      }
    }
    
    if(permission == LocationPermission.deniedForever){
      return Future.error("A permissão está permanentemente negada, precisamos de sua autorização para utilizar!");
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}