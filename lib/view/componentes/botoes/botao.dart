import 'package:flutter/material.dart';

import '../../../api/cor/colors_levv.dart';

class Botao extends StatefulWidget {
  Botao(
      {Key? key,
      required this.status,
      required this.botao,
      required this.iconImage})
      : super(key: key);

  bool status;
  String botao;
  String iconImage;

  @override
  State<Botao> createState() => _BotaoState();
}

class _BotaoState extends State<Botao> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(25)),
            backgroundColor: MaterialStateProperty.all(widget.status
                ? ColorsLevv.FUNDO_500_BUTTON_NOT_SELECTED
                : ColorsLevv.FUNDO_200_BUTTON_SELECTED)),
        onPressed: () {
          setState(() {
            widget.status = true;
          });
        },
        child: Row(
          children: [
            Image.asset(
              widget.iconImage,
              width: 20,
              height: 20,
              color: Colors.white,
            ),
            Text(
              widget.botao,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ));
  }
}
