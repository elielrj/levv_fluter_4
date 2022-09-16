import 'package:flutter/material.dart';
import 'package:levv4/view/mapa/localizar.dart';
import 'package:levv4/view/mapa/mapa.dart';
import '../../model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import '../../model/frontend/text_levv.dart';

class ItemComColetaEntrega extends StatefulWidget {
  ItemComColetaEntrega(
      {Key? key,
        required this.itemDoPedido,
        required this.limparControllers})
      : super(key: key);

  ItemDoPedido itemDoPedido;
  bool limparControllers;

  @override
  State<ItemComColetaEntrega> createState() => _ItemComColetaEntregaState();
}

class _ItemComColetaEntregaState extends State<ItemComColetaEntrega> {
  final _controllerColeta = TextEditingController();
  final _controllerEntrega = TextEditingController();
  bool mapaParaEnderecodeColeta = false;
  bool mapaParaEnderecodeEntrega = false;

  @override
  void initState() {
    super.initState();
    //todo resolver atualização
    if (widget.limparControllers) {
      _controllerEntrega.clear();
      _controllerColeta.clear();
      widget.limparControllers = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            "Item: ${widget.itemDoPedido.ordem.toString()}",
            style: const TextStyle(
              fontSize: 10,
              backgroundColor: Colors.white70,
            ),
          ),
          //endereço colea
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controllerColeta,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      labelStyle: const TextStyle(
                          backgroundColor: Colors.white, color: Colors.blue),
                      labelText: TextLevv.ENDERECO_COLETA,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                      ),
                      suffixIcon: _controllerColeta.text.isEmpty
                          ? Container(
                              width: 0,
                            )
                          : IconButton(
                              onPressed: () => _controllerColeta.clear(),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.redAccent,
                              )),
                      fillColor: Colors.white,
                      filled: true),
                  onChanged: (texto) => _buscarSugestaoDeEndereco(texto),
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
                      mapaParaEnderecodeColeta = !mapaParaEnderecodeColeta;
                    });
                  },
                )
              ])
            ],
          ),
          //exibir mapa
          _exibirMapaDeColeta(),
          //endereço de entrega
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controllerEntrega,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      labelStyle: const TextStyle(
                          backgroundColor: Colors.white, color: Colors.green),
                      labelText: TextLevv.ENDERECO_ENTREGA,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                      ),
                      suffixIcon: _controllerEntrega.text.isEmpty
                          ? Container(
                              width: 0,
                            )
                          : IconButton(
                              onPressed: () => _controllerEntrega.clear(),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                      fillColor: Colors.white,
                      filled: true),
                  onChanged: (texto) => _buscarSugestaoDeEndereco(texto),
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
                      mapaParaEnderecodeEntrega = !mapaParaEnderecodeEntrega;
                    });
                  },
                )
              ])
            ],
          ),
          //exibir mapa
          _exibirMapaDeEntrega(),
        ],
      ),
    );
  }

  _buscarLocalizacao() async {
    final localizar = Localizar();
    //await localizar.localizacaoAtual();
  }

  _exibirMapaDeColeta() => mapaParaEnderecodeColeta
      ? _exibirMapa()
      : Container(
          width: 0,
        );

  _exibirMapaDeEntrega() => mapaParaEnderecodeEntrega
      ? _exibirMapa()
      : Container(
          width: 0,
        );

  Widget _exibirMapa() => Container(
      color: Colors.white,
      width: double.infinity,
      height: 300,
      child: Mapa(
        itemDoPedido: widget.itemDoPedido,
      ));

  _buscarSugestaoDeEndereco(String texto) {
    //todo buscar sugestão
  }
}
