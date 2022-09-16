import 'package:flutter/material.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';

import '../../../cadastrar/acompanhar/tela_cadastrar_acompanhador.dart';
import '../../../home/tela_home.dart';


mixin Navegar{

  navegarParaTelaHome(
      {required Usuario usuario,
        required BuildContext context}) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TelaHome(
                  usuario: usuario,
                )));
  }

  navegarParaTelaCadastrarAcompanhador({required BuildContext context}){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const TelaCadastrarAcompanhador()));
  }
}