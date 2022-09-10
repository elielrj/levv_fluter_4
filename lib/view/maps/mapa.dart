import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:levv4/view/maps/camera.dart';
import 'package:levv4/view/maps/marcadores.dart';
import 'package:levv4/view/maps/poligonos.dart';
import 'package:levv4/view/maps/polylines.dart';

import 'localizar.dart';

class Mapa extends StatefulWidget {
  const Mapa({Key? key}) : super(key: key);

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa>
    with Marcadores, Poligonos, Polylines, Camera {
  Completer<GoogleMapController> _controller = Completer();

  LatLng localizacaoAtual = Localizar.LATLNG_TUBARAO;

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _movimentarCamera(LatLng value) async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: value, zoom: 16),
    ));
  }

  Future<void> _buscarLocalizacaoAtual() async {
    final localizar = Localizar();

    await localizar.localizacaoAtual().then((value) {
      localizacaoAtual = LatLng(value.latitude, value.longitude);
    });

    carregarMarcador(
        tituloDoMarcador: "Atual", marcadoDeLatLng: localizacaoAtual);

    setState(() {
      localizacaoAtual;
      marcadores;
    });
  }

  @override
  void initState() {
    super.initState();
    _buscarLocalizacaoAtual();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapas"),
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: localizacaoAtual,
            zoom: 13,
          ),
          onMapCreated: _onMapCreated,
          markers: marcadores,
          polygons: listaDePoligonos,
        ),
      ),
    );
  }
}
