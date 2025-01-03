import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:levv4/biblioteca/criador_de_pedido.dart';
import 'package:levv4/biblioteca/texto/text_levv.dart';
import 'package:levv4/controller/enviar/item_da_rota_do_pedido_controller.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/pedido_old/item_do_pedido.dart';
import 'package:levv4/view/enviar/mapa_do_item_do_pedido.dart';
import 'package:levv4/view/localizar/localizar/localizar.dart';

class ItemDaRotaDoPedido extends StatefulWidget {
  const ItemDaRotaDoPedido({
    Key? key,
    required this.itemDoPedido,
    required this.labelText,
    required this.criadorDePedido,
  }) : super(key: key);

  final ItemDoPedido itemDoPedido;
  final String labelText;
  final CriadorDePedido criadorDePedido;

  @override
  State<ItemDaRotaDoPedido> createState() => _ItemDaRotaDoPedidoState();
}

class _ItemDaRotaDoPedidoState extends State<ItemDaRotaDoPedido> {
  final itemDaRotaDoPedidoController = ItemDaRotaDoPedidoController();

  @override
  void initState() {
    super.initState();
    itemDaRotaDoPedidoController.addListener(() => setState(() {}));

    widget.itemDoPedido.addListener(() => setState(() {
          itemDaRotaDoPedidoController.textEditingController.clear();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: itemDaRotaDoPedidoController.textEditingController,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    labelStyle: const TextStyle(
                        backgroundColor: Colors.white, color: Colors.blue),
                    labelText: widget.labelText,
                    prefixIcon: const Icon(
                      Icons.account_box,
                      color: Colors.black38,
                    ),
                    suffixIcon: itemDaRotaDoPedidoController
                            .textEditingController.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            onPressed: () => _limpar(),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.redAccent,
                            )),
                    fillColor: Colors.white,
                    filled: true),
                onChanged: (text) => _buscarSugestaoDeEndereco(text),
              ),
            ),
            Column(children: [
              IconButton(
                icon: const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                ),
                color: Colors.black,
                onPressed: () async {
                  await _buscarLocalizacao(
                      widget.labelText,
                      widget.itemDoPedido,
                      itemDaRotaDoPedidoController.textEditingController);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.map,
                  size: 20,
                ),
                color: Colors.black,
                onPressed: () {
                  setState(() => itemDaRotaDoPedidoController
                      .trocarStatusDeVisualizacaoDeMapa());
                },
              )
            ])
          ],
        ),
        Row(
          children: [
            Expanded(
              child: itemDaRotaDoPedidoController.isShowMap
                  ? Column(
                      children: [
                        Container(
                            color: Colors.white,
                            //width: double.infinity,
                            height: 300,
                            child: MapaDoItemDoPedido(
                                itemDoPedido: widget.itemDoPedido,
                                labelText: widget.labelText,
                                itemDaRotaDoPedidoController:
                                    itemDaRotaDoPedidoController,
                                criadorDePedido: widget.criadorDePedido))
                      ],
                    )
                  : Container(width: 0),
            )
          ],
        )
      ],
    );
  }

  _buscarSugestaoDeEndereco(String texto) {
    //todo buscar sugestão
    print('aqui');
  }

  Future<void> _buscarLocalizacao(String labelText, ItemDoPedido itemDoPedido,
      TextEditingController _controller) async {
    try {
      final localizar = Localizar();

      Position position = await localizar.determinarPosicao();

      Endereco? endereco =
          await localizar.converterPositionEmEndereco(position);

      if (labelText == TextLevv.ENDERECO_ENTREGA) {
        setState(() {
          itemDoPedido.entrega = endereco;
          _controller.text = itemDoPedido.entrega.toString();
        });
      } else {
        setState(() {
          itemDoPedido.coleta = endereco;
          _controller.text = itemDoPedido.coleta.toString();
        });
      }

      widget.criadorDePedido.calcularValorDoPedido();
    } catch (error) {
      print('erro: ${error.toString()}');
      _erro();
    }
  }

  _erro() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text("Não é possível buscar local do endereço!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"))
            ],
          );
        });
  }

  void _limpar() {
    itemDaRotaDoPedidoController.textEditingController.clear();

    if (widget.labelText == TextLevv.ENDERECO_COLETA) {
      widget.itemDoPedido.coleta!.limpar();
    } else if (widget.labelText == TextLevv.ENDERECO_ENTREGA) {
      widget.itemDoPedido.entrega!.limpar();
    }

    widget.criadorDePedido.controllerValorPedido.textEditingController.clear();
  }
}
