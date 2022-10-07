import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import 'package:levv4/api/texto/text_levv.dart';
import '../../model/bo/endereco/endereco.dart';
import '../mapa/localizar/localizar.dart';
import '../mapa/mapa.dart';
import 'open_map_widget.dart';

class ItemAddress extends StatefulWidget {
  ItemAddress(
      {Key? key,
      required this.labelText,
      required this.itemDoPedido,
      required this.limparControllers
        })
      : super(key: key);

  final ItemDoPedido itemDoPedido;
  final String labelText;
  bool limparControllers;

  @override
  State<ItemAddress> createState() => _ItemAddressState();
}

class _ItemAddressState extends State<ItemAddress> {
  final TextEditingController _controller = TextEditingController();
  bool _isShowMap = false;

  @override
  void initState() {
    _controller.addListener(() {
      if(widget.labelText == TextLevv.ENDERECO_ENTREGA){
        widget.itemDoPedido.coleta;
      }else{
        widget.itemDoPedido.entrega;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.limparControllers) {
        _controller.clear();
        widget.limparControllers = false;
      }
    });

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    labelStyle: const TextStyle(
                        backgroundColor: Colors.white, color: Colors.blue),
                    labelText: widget.labelText,
                    prefixIcon: const Icon(
                      Icons.account_box,
                      color: Colors.black38,
                    ),
                    suffixIcon: _controller.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            onPressed: () => _controller.clear(),
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
                onPressed: () => _buscarLocalizacao(),
              ),
              IconButton(
                icon: const Icon(
                  Icons.map,
                  size: 20,
                ),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    _isShowMap = !_isShowMap;
                  });
                },
              )
            ])
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _isShowMap
                  ? openMapWidget(widget.itemDoPedido, false)
                  : Container(
                      width: 0,
                    ),
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

  Future<void> _buscarLocalizacao() async {

    try {
      final localizar = Localizar();


      Position position = await localizar.determinarPosicao();

      Endereco? endereco = await localizar.converterPositionEmEndereco(
          position);


      if (widget.labelText == TextLevv.ENDERECO_ENTREGA) {
        setState(() {
          widget.itemDoPedido.entrega = endereco;
          _controller.text = widget.itemDoPedido.entrega.toString();
        });
      } else {
        setState(() {
          widget.itemDoPedido.coleta = endereco;
          _controller.text = widget.itemDoPedido.coleta.toString();
        });
      }
    }catch(error){
      print('erro: ${error.toString()}');
      _erro();
    }
  }

  _erro(){
    _erro(){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Erro"),
              titlePadding: const EdgeInsets.all(20),
              titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
              content: const Text(
                  "Não é possível buscar local do endereço!"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok"))
              ],
            );
          });
    }
  }

  Future<Endereco> _buscarEndereco(String address) async {
    Localizar localizar = Localizar();
    return await localizar.converterEnderecoEmLatitudeLongitude(address);
  }
}
