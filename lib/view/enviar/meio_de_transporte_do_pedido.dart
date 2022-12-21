import 'package:flutter/material.dart';
import 'package:levv4/api/texto/text_levv.dart';

import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';
import 'package:levv4/model/bo/meio_de_transporte/carro.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';

class MeioDeTransporteDoPedido extends StatelessWidget {
  const MeioDeTransporteDoPedido({Key? key, required this.pedido})
      : super(key: key);

  final Pedido pedido;

  @override
  Widget build(BuildContext context) {
    List<int> valoresDosVeiculos = [
      APe.VALUE,
      Bike.VALUE,
      Moto.VALUE,
      Carro.VALUE
    ];

    List<String> textDosVeiculos = ["A pé", "Bike", "Moto", "Carro"];
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(TextLevv.MEIO_DE_TRANSPORTE, style: TextStyle(fontSize: 16)),
        SizedBox(
          width: 120,
          child: Card(
            child: DropdownButton(
              underline: Container(
                color: Colors.brown,
              ),
              isExpanded: true,
              value: pedido.transporte,
              items: [
                for (int index = 0; index < valoresDosVeiculos.length; index++)
                  DropdownMenuItem(
                    value: valoresDosVeiculos[index],
                    child: Text(textDosVeiculos[index],
                        textAlign: TextAlign.center),
                  ),
              ],
              onChanged: (value) {
                pedido.transporte = int.parse(value.toString());
              },
            ),
          ),
        )
      ],
    );
  }
}
