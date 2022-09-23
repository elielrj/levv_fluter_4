import 'package:flutter/material.dart';

import '../../model/bo/pedido/pedido.dart';
import 'mapa.dart';

class TelaMapa extends StatefulWidget {
  const TelaMapa({Key? key, required this.pedido}) : super(key: key);

  final Pedido pedido;

  @override
  State<TelaMapa> createState() => _TelaMapaState();
}

class _TelaMapaState extends State<TelaMapa> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acompanhar Locaização de pedido"),
      ),
      body: Stack(alignment: Alignment.center, children: [
        Container(
          padding: const EdgeInsets.all(16),
//width: double.infinity - 100,
          height: 200,
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white,
              elevation: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    child: Row(
                      children: [
                        Text("Número ${widget.pedido.numero}"),
                        Text("Valor R\$ ${widget.pedido.valor}"),
                      ],
                    ),
                  ),
                  for (var item in widget.pedido.itensDoPedido!)
                    Column(
                      children: [
                        Card(
                            color: Colors.white,
                            elevation: 2,
                            child: Text(
                                "Local de Coleta ${item.coleta.toString()}")),
                        Card(
                            color: Colors.white,
                            elevation: 2,
                            child: Text(
                                "Local de entrega ${item.entrega.toString()}")),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
        Mapa(pedido: widget.pedido,isMyLocationEnabled: true),
      ]),
    );
  }
}
