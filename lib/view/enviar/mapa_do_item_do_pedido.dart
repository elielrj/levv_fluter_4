import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:levv4/api/cor/colors_levv.dart';
import 'package:levv4/api/criador_de_pedido.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/controller/enviar/item_da_rota_do_pedido_controller.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/view/localizar/localizar/localizar.dart';
import 'package:levv4/view/localizar/marcadores.dart';

class MapaDoItemDoPedido extends StatefulWidget with Marcadores {
  MapaDoItemDoPedido({
    Key? key,
    required this.itemDoPedido,
    required this.labelText,
    required this.itemDaRotaDoPedidoController,
    required this.criadorDePedido
  }) : super(key: key);

  final ItemDoPedido itemDoPedido;
  final String labelText;
  final ItemDaRotaDoPedidoController itemDaRotaDoPedidoController;
final CriadorDePedido criadorDePedido;

  @override
  State<MapaDoItemDoPedido> createState() => _MapaDoItemDoPedidoState();
}

class _MapaDoItemDoPedidoState extends State<MapaDoItemDoPedido> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _cameraPosition = CameraPosition(
    target: Localizar.LATLNG_TUBARAO,
    zoom: 13,
  );

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          _mapa(),
          _botaoDoMapa(),
        ],
      ),
    );
  }

  Widget _mapa() => GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _cameraPosition,
      onMapCreated: _onMapCreated,
      markers: widget.marcadores,
      myLocationEnabled: true,
      onLongPress: (maker) => _adicionarMarcador(maker),
      zoomControlsEnabled: true,
      trafficEnabled: false);

  Widget _botaoDoMapa() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              shadowColor: Colors.black,
              elevation: 3,
              backgroundColor: ColorsLevv.FUNDO_500_BUTTON_NOT_SELECTED),
          onPressed: () => _selecionarlocalNoMapa(),
          child: const Text(TextLevv.BOTAO_SELECIONAR_LOCAL,
              style: TextStyle(color: Colors.black, fontSize: 12)),
        ),
      );

  _adicionarMarcador(LatLng newMaker) {
    widget.limparMarcadores();

    widget.carregarMarcador(
        tituloDoMarcador: TextLevv.TITULO_DO_MARCADOR,
        marcadoDeLatLng: newMaker);

    _movimentarCamera(newMaker);

    setState(() => widget.marcadores);
  }

  _movimentarCamera(LatLng value) async {
    GoogleMapController googleMapController = await _controller.future;

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: value, zoom: 16),
    ));
  }

  void _selecionarlocalNoMapa() {
    {
      if (widget.marcadores.isNotEmpty) {
        try {
          if (widget.labelText == TextLevv.ENDERECO_ENTREGA) {
            _enderecoDeEntrega();
          } else {
            _enderecoDeColeta();
          }

          //widget.pedido.notifyListeners();
          widget.criadorDePedido.calcularValorDoPedido();

        } catch (erro) {
          print("erro:-> ${erro.toString()}");
        }
      } else {
        _exibirMensagemDeErro();
      }
    }
  }

  Future<void> _enderecoDeEntrega() async {
    widget.itemDoPedido.entrega = await _buscarObejetoEndereco();

    setState(() {
      widget.itemDaRotaDoPedidoController.textEditingController.text =
          widget.itemDoPedido.entrega.toString();
    });

    widget.itemDaRotaDoPedidoController.fecharMapa();

    print("Teste MAPA--> ${widget.itemDoPedido.entrega.toString()}");
  }

  Future<void> _enderecoDeColeta() async {
    widget.itemDoPedido.coleta = await _buscarObejetoEndereco();

    setState(() {
      widget.itemDaRotaDoPedidoController.textEditingController.text =
          widget.itemDoPedido.coleta.toString();
    });

    widget.itemDaRotaDoPedidoController.fecharMapa();

    print("Teste MAPA--> ${widget.itemDoPedido.coleta.toString()}");
  }

  Future<Endereco?> _buscarObejetoEndereco() async {
    final localizar = Localizar();
    return await localizar
        .converterLatLngEmEndereco(widget.marcadores.first.position);
  }

  _exibirMensagemDeErro() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(TextLevv.ERRO),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text(TextLevv.ERRO_SELECIONE_LOCAL_MAPA),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok")),
            ],
          );
        });
  }
}
