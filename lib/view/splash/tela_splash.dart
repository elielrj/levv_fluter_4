import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';
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
              WidgetLogoLevv(bottom: 32),
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

  Future<void> _incializarCircularProgressIndicator() async =>
      Timer(const Duration(seconds: 3), () async {
        await _escolherProximaTela();
      });

  Future<void> _escolherProximaTela() async => _isUserFirebase()
      ? _navegarParaTelaHome(await _buscarUsuarioNoBancoDeDados())
      : _navegarParaTelaCadastroDeAcompanhador();

  bool _isUserFirebase() =>
      FirebaseAuth.instance.currentUser != null ? true : false;

  Future<Usuario> _buscarUsuarioNoBancoDeDados() async {
    final UsuarioDAO usuarioDAO = UsuarioDAO();
    var usuario = await usuarioDAO.buscar();
    return usuario ?? await _navegarParaTelaCadastroDeAcompanhador();
  }

  _navegarParaTelaHome(Usuario usuario) => Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => TelaHome(usuario: usuario)));

  _navegarParaTelaCadastroDeAcompanhador() => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const TelaCadastrarAcompanhador()));
}
