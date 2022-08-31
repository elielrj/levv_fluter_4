import 'package:flutter/material.dart';

import '../../model/bo/usuario/usuario.dart';

class TelaEnviar extends StatefulWidget {
  const TelaEnviar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaEnviar> createState() => _TelaEnviarState();
}

class _TelaEnviarState extends State<TelaEnviar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.amber);
  }
}
