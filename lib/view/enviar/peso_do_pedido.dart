import 'package:flutter/material.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';

class PesoDoPedido extends StatelessWidget {
  const PesoDoPedido({Key? key, required this.pedido}) : super(key: key);

  final Pedido pedido;

  @override
  Widget build(BuildContext context) {
    final List<int> valoresDosPesos = [1, 5, 10, 15, 20, 25];
    final List<String> textosDosPesos = [
      "Até 1Kg",
      "Até 5Kg",
      "Até 10Kg",
      "Até 15Kg",
      "Até 20Kg",
      "Até 25Kg"
    ];

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
                  value: pedido.peso,
                  items: [
                    for (int index = 0; index < valoresDosPesos.length; index++)
                      DropdownMenuItem(
                        value: valoresDosPesos[index],
                        child: Text(textosDosPesos[index],
                            textAlign: TextAlign.center),
                      ),
                  ],
                  onChanged: (value) {
                    pedido.peso = int.parse(value.toString());
                  },
                ),
              ))
        ],
      ),
    );
  }
}
