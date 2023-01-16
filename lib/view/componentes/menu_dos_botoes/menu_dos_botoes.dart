import 'package:flutter/material.dart';
import 'package:levv4/controller/menu_botoes_controller/menu_botoes_controller.dart';
import '../../../api/cor/colors_levv.dart';
import '../../../api/imagem/image_levv.dart';

class MenuDosBotoes extends StatefulWidget {
  const MenuDosBotoes({Key? key, required this.menuBotoesController})
      : super(key: key);

  final MenuBotoesController menuBotoesController;

  @override
  State<MenuDosBotoes> createState() => _MenuDosBotoesState();
}

class _MenuDosBotoesState extends State<MenuDosBotoes> {
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
                          const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(widget
                              .menuBotoesController
                              .listaDeStatusDosBotoes[index]
                          ? ColorsLevv.FUNDO_500_BUTTON_NOT_SELECTED
                          : ColorsLevv.FUNDO_200_BUTTON_SELECTED)),
                  onPressed: () => widget.menuBotoesController
                      .selecionarListaDePedidos(index),
                  child: Row(
                    children: [
                      Image.asset(
                        widget.menuBotoesController.listaDeNomeDosIcones[index],
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        widget.menuBotoesController.listaDeNomeDosBotoes[index],
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  )),
          ],
        ));
  }
}
