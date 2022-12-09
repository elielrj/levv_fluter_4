import 'dart:async';

import 'package:flutter/material.dart';
import 'package:levv4/controller/splash/tela_splash_controller.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/view/home/tela_home.dart';
import '../../api/cor/colors_levv.dart';

import '../../api/texto/text_levv.dart';
import '../cadastrar/acompanhar/tela_cadastrar_acompanhador.dart';

import '../componentes/logo/widget_logo_levv.dart';

class TelaSplash extends StatefulWidget {
  const TelaSplash({Key? key}) : super(key: key);

  @override
  State<TelaSplash> createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  final _controller = TelaSplashController();

  @override
  void initState() {
    super.initState();
    _incializarCircularProgressIndicator();
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

  Future<void> _incializarCircularProgressIndicator() async {
    Timer(const Duration(seconds: 3), () async {
      await _escolherProximaTela();
    });
  }

  Future<void> _escolherProximaTela() async {
    if (_controller.usuarioFirebaseEstaLogado()) {
      try {
        Usuario? usuario = await _controller.buscarUsuario();

        if(usuario == null){
          _navegarParaTelaCadastroDeAcompanhador();
        }else{
          _navegarParaTelaHome(usuario);
        }

      } catch (error) {
        _erroAoBuscarUsuario();
        print('Tela Splash: erro --> ${error.toString()}');
      }
    } else {
      _navegarParaTelaCadastroDeAcompanhador();
    }
  }

  _erroAoBuscarUsuario() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title:
                Text(TextLevv.ERRO_BUSCAR_USUARIO, textAlign: TextAlign.center),
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: TextStyle(fontSize: 20, color: Colors.black26),
          );
        });
  }

  _navegarParaTelaCadastroDeAcompanhador() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const TelaCadastrarAcompanhador()));
  }

  _navegarParaTelaHome(Usuario usuario) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaHome(
                  usuario: usuario,
                )));
  }
}
