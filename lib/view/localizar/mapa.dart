import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:levv4/api/cor/colors_levv.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/controller/enviar/item_da_rota_do_pedido_controller.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
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
      required this.isTrafficEnabled,
      this.labelText,
      this.itemDaRotaDoPedidoController})
      : super(key: key);

  final ItemDoPedido? itemDoPedido;
  final Pedido? pedido;
  final bool isMyLocationEnabled;
  final bool isTrafficEnabled;
  final String? labelText;

  final ItemDaRotaDoPedidoController? itemDaRotaDoPedidoController;

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
      child: Stack(
        children: [
          GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _cameraPosition,
              onMapCreated: _onMapCreated,
              markers: marcadores,
              polygons: listaDePoligonos,
              myLocationEnabled: widget.isMyLocationEnabled,
              onLongPress: (maker) => _adicionarMarcador(maker),
              zoomControlsEnabled: true,
              trafficEnabled: widget.isTrafficEnabled),
          widget.itemDaRotaDoPedidoController!.isShowMap
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shadowColor: Colors.black,
                        elevation: 3,
                        backgroundColor:
                            ColorsLevv.FUNDO_500_BUTTON_NOT_SELECTED),
                    onPressed: () => _selecionarlocalNoMapa(),
                    child: const Text("Selecionar Local",
                        style: TextStyle(color: Colors.black, fontSize: 12)),
                  ),
                )
              : Container(width: 0)
        ],
      ),
    );
  }

  Future<LatLng> _selecionarGeoLocalizacaoDoMaker() async {
    return marcadores.first.position;
  }

  Future<Endereco> _converterPositionEmObjetoEndereco(LatLng latLng) async {
    return await localizar.converterLatitudeLongitudeEmEndereco(
        latitude: latLng.latitude, longitude: latLng.longitude);
  }

  _adicionarMarcador(LatLng newMaker) {
    limparMarcadores();

    carregarMarcador(tituloDoMarcador: 'Local', marcadoDeLatLng: newMaker);

    _movimentarCamera(newMaker);

    setState(() {
      marcadores;
    });
  }

  _exibirMensagemDeErro() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text("Selecione um local no mapa!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok")),
            ],
          );
        });
  }

  void _selecionarlocalNoMapa() {
    {
      if (marcadores.isNotEmpty) {
        try {
          if (widget.labelText == TextLevv.ENDERECO_ENTREGA) {
            _enderecoDeEntrega();
          } else {
            _enderecoDeColeta();
          }

          widget.itemDaRotaDoPedidoController!.fecharMapa();
        } catch (erro) {
          print("erro:-> ${erro.toString()}");
        }
      } else {
        _exibirMensagemDeErro();
      }
    }
  }

  Future<void> _enderecoDeEntrega() async {
    widget.itemDoPedido!.entrega = await _converterPositionEmObjetoEndereco(
        await _selecionarGeoLocalizacaoDoMaker());
    setState(() {
      widget.itemDaRotaDoPedidoController!.textEditingController.text = widget.itemDoPedido!.entrega.toString();
    });

    print("Teste MAPA--> ${widget.itemDoPedido?.entrega.toString()}");
  }

  Future<void> _enderecoDeColeta() async {
    widget.itemDoPedido!.coleta = await _converterPositionEmObjetoEndereco(
        await _selecionarGeoLocalizacaoDoMaker());

    setState(() {
      widget.itemDaRotaDoPedidoController!.textEditingController.text = widget.itemDoPedido!.coleta.toString();
    });

    print("Teste MAPA--> ${widget.itemDoPedido?.coleta.toString()}");
  }
}
