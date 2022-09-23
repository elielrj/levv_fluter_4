import 'package:flutter/material.dart';

import '../../model/bo/pedido/pedido.dart';
import '../../model/frontend/text_levv.dart';

class PedidoPeso extends StatefulWidget {
  const PedidoPeso({Key? key, required this.pedido}) : super(key: key);

  final Pedido pedido;

  @override
  State<PedidoPeso> createState() => _PedidoPesoState();
}

class _PedidoPesoState extends State<PedidoPeso> {
  List<int> valoresDosPesos = [1, 5, 10, 15, 20, 25];
  List<String> textosDosPesos = [
    "Até 1Kg",
    "Até 5Kg",
    "Até 10Kg",
    "Até 15Kg",
    "Até 20Kg",
    "Até 25Kg"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            TextLevv.PESO,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
              width: 90,
              child: Card(
                child: DropdownButton(
                  underline: Container(
                    color: Colors.brown,
                  ),
                  isExpanded: true,
                  value: widget.pedido.peso,
                  items: [
                    for (int index = 0; index < valoresDosPesos.length; index++)
                      DropdownMenuItem(
                        value: valoresDosPesos[index],
                        child: Text(textosDosPesos[index],
                            textAlign: TextAlign.center),
                      ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      widget.pedido.peso = int.parse(value.toString());
                    });
                  },
                ),
              ))
        ],
      ),
    );
  }
}
