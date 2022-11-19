import 'package:flutter/material.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';

import '../../model/bo/pedido/pedido.dart';

class PedidoValor extends StatefulWidget {
  const PedidoValor(
      {Key? key,
        required this.controllerValor
        })
      : super(key: key);

  final Mask controllerValor;

  @override
  State<PedidoValor> createState() => _PedidoValorState();
}

class _PedidoValorState extends State<PedidoValor> {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("VALOR"),
        TextField(
          controller: widget.controllerValor.textEditingController,
          inputFormatters: [widget.controllerValor.formatter.getFormatter()],
          enabled: false,
          decoration: const InputDecoration(
              labelStyle: TextStyle(backgroundColor: Colors.white),
              labelText: "R\$ 0.00",
              prefixIcon: Icon(Icons.monetization_on),
              fillColor: Colors.white,
              filled: true),
        ),
      ],
    );
  }
}
