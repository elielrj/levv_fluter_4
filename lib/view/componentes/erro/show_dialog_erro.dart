import 'package:flutter/material.dart';

mixin ShowDialogErro{

  erroAoBuscarUsuario(BuildContext context){
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
                "Erro ao buscar o seu usuário! Entre em contato com o SAC!",
                textAlign: TextAlign.center),
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: TextStyle(fontSize: 20, color: Colors.black26),
          );
        });
  }

  erroAoBuscarLocalizacao(BuildContext context){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro"),
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
            content:
            const Text("Não foi possível obter localização!"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"))
            ],
          );
        });

  }


}