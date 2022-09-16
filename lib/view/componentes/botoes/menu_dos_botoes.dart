import 'package:flutter/material.dart';

import '../../../model/frontend/colors_levv.dart';
import '../../../model/frontend/image_levv.dart';

class MenuDosBotoes extends StatefulWidget {
  const MenuDosBotoes({Key? key, required this.listaDeStatusDosBotoes}) : super(key: key);

  final List<bool> listaDeStatusDosBotoes;

  @override
  State<MenuDosBotoes> createState() => _MenuDosBotoesState();
}

class _MenuDosBotoesState extends State<MenuDosBotoes> {

  final List<String> listaDeNomeDosIcones = [
    ImageLevv.ICON_ACTIVE,
    ImageLevv.ICON_FINISHED,
    ImageLevv.ICON_PENDING
  ];

  final List<String> listaDeNomeDosBotoes = [
    "Ativos",
    "Finalizados",
    "Pendentes"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int index = 0; index < 3; index++)
              TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(25)),
                      backgroundColor: MaterialStateProperty.all(
                          widget.listaDeStatusDosBotoes[index]
                              ? ColorsLevv
                              .FUNDO_500_BUTTON_NOT_SELECTED
                              : ColorsLevv
                              .FUNDO_200_BUTTON_SELECTED)),
                  onPressed: () {
                    setState(() {
                      for (int vetor = 0;
                      vetor < widget.listaDeStatusDosBotoes.length;
                      vetor++) {
                        widget.listaDeStatusDosBotoes[index] = true;
                        if (vetor != index) {
                          widget.listaDeStatusDosBotoes[vetor] = false;
                        }
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        listaDeNomeDosIcones[index],
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        listaDeNomeDosBotoes[index],
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  )),


          ],
        ));
  }
}
