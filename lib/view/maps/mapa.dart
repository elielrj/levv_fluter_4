import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:levv4/view/maps/camera.dart';
import 'package:levv4/view/maps/marcadores.dart';
import 'package:levv4/view/maps/poligonos.dart';
import 'package:levv4/view/maps/polylines.dart';

class Mapa extends StatefulWidget {
  const Mapa({Key? key}) : super(key: key);

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa>
    with Marcadores, Poligonos, Polylines, Camera {
  Completer<GoogleMapController> _controller = Completer();

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _movimentarCamera(LatLng value) async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: value, zoom: 16),
    ));
  }

  _initialCameraPosition() {
    return const CameraPosition(
      //todo buscar localização atual
      target: LatLng(-28.467, -49.0075),
      zoom: 13,
    );
  }

  @override
  void initState() {
    super.initState();
    //todo carregar Makers
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
          initialCameraPosition: _initialCameraPosition(),
          onMapCreated: _onMapCreated,
          markers: marcadores,
          polygons: listaDePoligonos,
        ),
      ),
    );
  }
}
