import 'package:flutter/material.dart';

import '../../model/bo/meio_de_transporte/a_pe.dart';
import '../../model/bo/meio_de_transporte/bike.dart';
import '../../model/bo/meio_de_transporte/carro.dart';
import '../../model/bo/meio_de_transporte/moto.dart';
import '../../model/bo/pedido/pedido.dart';
import '../../api/texto/text_levv.dart';


class PedidoVeiculo extends StatefulWidget {
  const PedidoVeiculo({Key? key, required this.pedido}) : super(key: key);

  final Pedido pedido;

  @override
  State<PedidoVeiculo> createState() => _PedidoVeiculoState();
}

class _PedidoVeiculoState extends State<PedidoVeiculo> {


  List<int> valoresDosVeiculos = [
    APe.VALUE,
    Bike.VALUE,
    Moto.VALUE,
    Carro.VALUE
  ];
  List<String> textDosVeiculos = ["A pé", "Bike", "Moto", "Carro"];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(TextLevv.MEIO_DE_TRANSPORTE,
            style: TextStyle(fontSize: 16)),
        SizedBox(
          width: 120,
          child: Card(
            child: DropdownButton(
              underline: Container(
                color: Colors.brown,
              ),
              isExpanded: true,
              value: widget.pedido.transporte,
              items: [
                for (int index = 0;
                index < valoresDosVeiculos.length;
                index++)
                  DropdownMenuItem(
                    value: valoresDosVeiculos[index],
                    child: Text(textDosVeiculos[index],
                        textAlign: TextAlign.center),
                  ),
              ],
              onChanged: (value) {
                setState(() {
                  widget.pedido.transporte =
                      int.parse(value.toString());
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
