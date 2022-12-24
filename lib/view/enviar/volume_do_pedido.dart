import 'package:flutter/material.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/api/criador_de_pedido.dart';

class VolumeDoPedido extends StatelessWidget {
  const VolumeDoPedido({Key? key, required this.criadorDePedido})
      : super(key: key);

  final CriadorDePedido criadorDePedido;

  @override
  Widget build(BuildContext context) {
    List<String> listaTamanhoDeVolumes = ["20 x 20", "40 x 40", "60 x 60"];
    List<int> listaDeValoresDosTamanhosDosVolumes = [20, 40, 60];

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(TextLevv.VOLUME, style: TextStyle(fontSize: 16)),
        SizedBox(
          width: 90,
          child: Card(
            child: DropdownButton(
              underline: Container(
                color: Colors.brown,
              ),
              isExpanded: true,
              value: criadorDePedido.volumeDoPedido(),
              items: [
                for (int index = 0;
                    index < listaTamanhoDeVolumes.length;
                    index++)
                  DropdownMenuItem(
                    value: listaDeValoresDosTamanhosDosVolumes[index],
                    child: Text(
                      listaTamanhoDeVolumes[index],
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
              onChanged: (value) =>
                  criadorDePedido.novoPesoDoPedido(int.parse(value.toString())),
            ),
          ),
        ),
      ],
    );
  }
}
