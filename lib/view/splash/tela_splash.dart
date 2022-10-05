import 'dart:async';

import 'package:flutter/material.dart';
import '../../api/cor/colors_levv.dart';

import '../../api/texto/text_levv.dart';
import '../componentes/erro/show_dialog_erro.dart';

import '../componentes/nevegacao/home/navegar_tela_home.dart';
import '../componentes/logo/widget_logo_levv.dart';

import '../../controller/usuario_controller.dart';

class TelaSplash extends StatefulWidget {
  const TelaSplash({Key? key}) : super(key: key);

  @override
  State<TelaSplash> createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> with Navegar, ShowDialogErro {
  final UsuarioController usuarioController = UsuarioController();

  @override
  void initState() {
    super.initState();
    _inicializarCircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsLevv.FUNDO_400,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: logoLevv(),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  TextLevv.NOME_DO_APP,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: ColorsLevv.TEXTO),
                ),
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _inicializarCircularProgressIndicator() async {
    Timer(const Duration(seconds: 3), () async {
      await _escolherProximaTela();
    });
  }

  Future<void> _escolherProximaTela() async {
    if (usuarioController.existeUsuarioFirebaseLogado()) {
      try {
        await usuarioController.buscarUsuario();
        usuarioController.navegarParaTelaHome(context: context);
      } catch (erro) {
        _erroAoBuscarUsuario();
      }
    } else {
      usuarioController.navegarParaTelaCadastrarAcompanhador(context: context);
    }
  }

  _erroAoBuscarUsuario() {
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
