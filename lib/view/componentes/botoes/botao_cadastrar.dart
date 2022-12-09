import 'package:flutter/material.dart';import 'package:flutter/material.dart';

Widget TextButtonCustomizedCadastrar() => TextButton(
  style: TextButton.styleFrom(
    backgroundColor: Colors.white,
    textStyle:
    const TextStyle(color: Colors.black, fontSize: 18),
    padding: const EdgeInsets.all(8),
    minimumSize: const Size(190, 65),
    elevation: 2,
    foregroundColor: Colors.black,
    alignment: Alignment.center,
  ),
  onPressed: () {
  },
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Center(
        widthFactor: 1,
        child: Image.asset(
          "imagens/icon_register.png",
          width: 20,
          height: 20,
        ),
      ),
      const Center(
        widthFactor: 2,
        child: Text("Cadastrar"),
      ),
    ],
  ),
);
