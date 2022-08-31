import 'package:flutter/material.dart';

import '../../model/bo/usuario/usuario.dart';

class TelaEntregar extends StatefulWidget {
  const TelaEntregar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaEntregar> createState() => _TelaEntregarState();
}

class _TelaEntregarState extends State<TelaEntregar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.brown);
  }
}
