import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';

import 'package:levv4/view/localizar/marcadores.dart';
import 'package:levv4/view/localizar/poligonos.dart';
import 'package:levv4/view/localizar/polylines.dart';

import '../../model/bo/pedido/pedido.dart';
import 'localizar/localizar.dart';

class Mapa extends StatefulWidget {
  const Mapa(
      {Key? key,
      this.itemDoPedido,
      this.pedido,
      required this.isMyLocationEnabled,
      required this.isTrafficEnabled})
      : super(key: key);

  final ItemDoPedido? itemDoPedido;
  final Pedido? pedido;
  final bool isMyLocationEnabled;
  final bool isTrafficEnabled;

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
  void initState() {
    super.initState();

    // localizar.listenToLocationUpdates();

    if (widget.pedido != null) {
      carregarMarcadores(itensDoPedido: widget.pedido!.itensDoPedido!);
    }
    if (widget.itemDoPedido != null) {
      //carregarMarcadores(itensDoPedido: [widget.itemDoPedido!]);
    }
    //_buscarLocalizacaoAtual();
  }

  @override
  Widget build(BuildContext context) {
    bool isScrollGesturesEnabled = true;
    bool isTrafficEnabled = false;
    return Container(
      //width: double.infinity,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        onMapCreated: _onMapCreated,
        markers: marcadores,
        polygons: listaDePoligonos,
        myLocationEnabled: widget.isMyLocationEnabled,
        onLongPress: (maker) => _adicionarMarcador(maker),
        zoomControlsEnabled: true,
        trafficEnabled: widget.isTrafficEnabled,
      ),
    );
  }

  _adicionarMarcador(LatLng newMaker) {

    limparMarcadores();

    carregarMarcador(tituloDoMarcador: 'Local', marcadoDeLatLng: newMaker);

    _movimentarCamera(newMaker);

    setState(() {
      marcadores;
    });
  }
}
