import 'package:flutter/material.dart';
import 'package:levv4/api/criador_de_pedido.dart';
import 'package:levv4/api/texto/text_levv.dart';

class PesoDoPedido extends StatelessWidget {
  const PesoDoPedido({Key? key, required this.criadorDePedido})
      : super(key: key);

  final CriadorDePedido criadorDePedido;

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
                  value: criadorDePedido.pesoDoPedido(),
                  items: [
                    for (int index = 0; index < valoresDosPesos.length; index++)
                      DropdownMenuItem(
                        value: valoresDosPesos[index],
                        child: Text(textosDosPesos[index],
                            textAlign: TextAlign.center),
                      ),
                  ],
                  onChanged: (value) {
                    criadorDePedido
                        .novoPesoDoPedido(int.parse(value.toString()));
                  },
                ),
              ))
        ],
      ),
    );
  }
}
