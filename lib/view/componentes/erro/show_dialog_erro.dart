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


}