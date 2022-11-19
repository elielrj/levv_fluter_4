import 'dart:async';

import 'package:flutter/material.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/view/home/tela_home.dart';
import '../../api/cor/colors_levv.dart';

import '../../api/texto/text_levv.dart';
import '../../model/dao/usuario/usuario_dao.dart';
import '../cadastrar/acompanhar/tela_cadastrar_acompanhador.dart';

import '../componentes/logo/widget_logo_levv.dart';

class TelaSplash extends StatefulWidget {
  const TelaSplash({Key? key}) : super(key: key);

  @override
  State<TelaSplash> createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  late final Usuario _user;

  @override
  void initState() {
    super.initState();
    _startCircularProgressIndicator();
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

  _startCircularProgressIndicator() async {
    Timer(const Duration(seconds: 3), () async {
      await _chooseNextScreen();
    });
  }

  Future<void> _chooseNextScreen() async {
    if (_thereIsFirebaseUserLoggedIn()) {
      try {
        await _fetchUser();
        _navigateToHomeScreen();
      } catch (error) {
        _errorToFetchUser();
      }
    } else {
      _navigateToScreenAcompanhador();
    }
  }

  _errorToFetchUser() {
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

  _navigateToScreenAcompanhador() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const TelaCadastrarAcompanhador()));
  }

  _navigateToHomeScreen() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaHome(
                  usuario: _user,
                )));
  }

  Future<void> _fetchUser() async {
    final usuarioDAO = UsuarioDAO();

    _user = await usuarioDAO.buscarUmUsuarioPeloNomeDoDocumento(
        usuarioDAO.autenticacao.nomeDoDocumentoDoUsuarioCorrente(
            usuarioDAO.autenticacao.auth.currentUser!));
  }

  bool _thereIsFirebaseUserLoggedIn() {
    final usuarioDAO = UsuarioDAO();
    return usuarioDAO.autenticacao.auth.currentUser != null ? true : false;
  }
}