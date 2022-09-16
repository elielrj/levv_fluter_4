import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';

import 'package:levv4/view/mapa/marcadores.dart';
import 'package:levv4/view/mapa/poligonos.dart';
import 'package:levv4/view/mapa/polylines.dart';

import '../../model/bo/pedido/pedido.dart';
import 'localizar.dart';

class Mapa extends StatefulWidget {
  const Mapa({Key? key, this.itemDoPedido, this.pedido}) : super(key: key);

  final ItemDoPedido? itemDoPedido;
  final Pedido? pedido;

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> with Marcadores, Poligonos, Polylines {
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
    if(widget.pedido != null) {
      carregarMarcadores(itensDoPedido: widget.pedido!.itensDoPedido!);
    }
    if(widget.itemDoPedido != null){
      //carregarMarcadores(itensDoPedido: [widget.itemDoPedido!]);
    }
    _buscarLocalizacaoAtual();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
    );
  }
}
