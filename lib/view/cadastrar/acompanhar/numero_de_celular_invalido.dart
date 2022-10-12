import 'package:flutter/material.dart';

class NumeroDeCelularInvalido extends StatelessWidget {
  const NumeroDeCelularInvalido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("Não é possível cadastrar! Números inválidos",
          textAlign: TextAlign.center),
      titlePadding: EdgeInsets.all(20),
      titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
    );
  }
}
