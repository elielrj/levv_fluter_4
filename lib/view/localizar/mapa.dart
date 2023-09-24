import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:levv4/biblioteca/texto/text_levv.dart';
import 'package:levv4/view/localizar/marcadores.dart';
import 'package:levv4/view/localizar/poligonos.dart';
import 'package:levv4/view/localizar/polylines.dart';
import 'localizar/localizar.dart';

class Mapa extends StatefulWidget {
  const Mapa({Key? key}) : super(key: key);

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> with Marcadores, Poligonos, Polylines {
  final Completer<GoogleMapController> _controller = Completer();

  final localizar = Localizar();



  CameraPosition _cameraPosition = CameraPosition(
    target: Localizar.LATLNG_TUBARAO,
    zoom: 13,
  );

  _reposicionarCamera({LatLng? latLng}) {
    _cameraPosition = CameraPosition(
      target: latLng ?? Localizar.LATLNG_TUBARAO,
      zoom: 13,
    );
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _movimentarCamera(LatLng value) async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: value, zoom: 16),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        onMapCreated: _onMapCreated,
        markers: marcadores,
        polygons: listaDePoligonos,
        myLocationEnabled: true,
        onLongPress: (maker) => _adicionarMarcador(maker),
        zoomControlsEnabled: true,
        trafficEnabled: false);
  }

  _adicionarMarcador(LatLng newMaker) {
    limparMarcadores();

    carregarMarcador(tituloDoMarcador: TextLevv.TITULO_DO_MARCADOR, marcadoDeLatLng: newMaker);

    _movimentarCamera(newMaker);

    setState(() => marcadores);
  }
}
