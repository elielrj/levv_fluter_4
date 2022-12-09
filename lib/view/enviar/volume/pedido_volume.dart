import 'package:flutter/material.dart';

import '../../../model/bo/pedido/pedido.dart';
import '../../../api/texto/text_levv.dart';

class PedidoVolume extends StatefulWidget {
  const PedidoVolume({Key? key, required this.pedido}) : super(key: key);

  final Pedido pedido;

  @override
  State<PedidoVolume> createState() => _PedidoVolumeState();
}

class _PedidoVolumeState extends State<PedidoVolume> {


  List<String> listaTamanhoDeVolumes = ["20 x 20","40 x 40","60 x 60"];
  List<int> listaDeValoresDosTamanhosDosVolumes = [20,40,60];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
            TextLevv.VOLUME,
            style: TextStyle(
                fontSize: 16
            )),
        SizedBox(
          width: 90,
          child: Card(
            child: DropdownButton(
              underline: Container(
                color: Colors.brown,
              ),
              isExpanded: true,
              value: widget.pedido.volume,
              items:  [
                for(int index = 0; index < listaTamanhoDeVolumes.length; index++)
                DropdownMenuItem(
                  value: listaDeValoresDosTamanhosDosVolumes[index],
                  child: Text(
                    listaTamanhoDeVolumes[index],
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  widget.pedido.volume = int.parse(value.toString());
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
