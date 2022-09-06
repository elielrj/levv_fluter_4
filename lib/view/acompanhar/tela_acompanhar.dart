import 'package:flutter/material.dart';

import '../../model/bo/usuario/usuario.dart';
import '../../model/frontend/colors_levv.dart';

class TelaAcompanhar extends StatefulWidget {
  const TelaAcompanhar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaAcompanhar> createState() => _TelaAcompanharState();
}

class _TelaAcompanharState extends State<TelaAcompanhar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsLevv.FUNDO,
        appBar: AppBar(
          title: const Text("Acompanhar um produto"),
        ),
        body: Container(child:Text("Tela Acompanhar")));
  }
}
