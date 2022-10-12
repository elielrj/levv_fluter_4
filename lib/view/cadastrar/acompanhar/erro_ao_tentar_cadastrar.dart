import 'package:flutter/material.dart';

class ErroAoTentarCadastrar extends StatelessWidget {
  ErroAoTentarCadastrar({Key? key, required this.mensagem}) : super(key: key);

  String mensagem;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Erro ao tentar cadastrar! Entre em contato com o SAC!",
          textAlign: TextAlign.center),
      titlePadding: const EdgeInsets.all(20),
      titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
      content: Text(mensagem),
    );
  }
}
