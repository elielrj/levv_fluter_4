import 'package:flutter/material.dart';

import '../../model/bo/usuario/usuario.dart';

class TelaAcompanhar extends StatefulWidget {
  const TelaAcompanhar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaAcompanhar> createState() => _TelaAcompanharState();
}

class _TelaAcompanharState extends State<TelaAcompanhar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.green,);
  }
}
