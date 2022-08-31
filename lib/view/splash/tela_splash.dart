import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levv4/model/backend/firebase/auth/document_name_current_user.dart';
import 'package:levv4/view/cadastrar/acompanhar/tela_cadastrar_acompanhador.dart';
import '../../model/backend/firebase/auth/firebase_auth.dart';
import '../../model/dao/usuario/usuario_dao.dart';
import '../home/tela_home.dart';

import '../../model/frontend/colors_levv.dart';
import '../../model/frontend/image_levv.dart';
import '../../model/frontend/text_levv.dart';

class TelaSplash extends StatefulWidget {
  const TelaSplash({Key? key}) : super(key: key);

  @override
  State<TelaSplash> createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> with DocumentNameCurrentUser {
  var _classUser;
  final autenticacao = Autenticacao(FirebaseAuth.instance);
  final _userDAO = UsuarioDAO();

  @override
  void initState() {
    super.initState();
    _startCircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsLevv.FUNDO,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Image.asset(
                  ImageLevv.LOGO_DO_APP_LEVV,
                  width: 90,
                ),
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
      if (autenticacao.auth.currentUser != null) {
        await _searchUser();
        if (_classUser != null) {
          _navigatorToHomeScreen();
        } else {
          _displayErrorToUser();
        }
      } else {
        _navigatorToRegistrationScreen();
      }
    });
  }

  _displayErrorToUser() {
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

  _searchUser() async {
    String documentName = name(autenticacao.auth.currentUser!);
    _classUser = await _userDAO.searchByReference(documentName);
  }

  _navigatorToHomeScreen()  {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaHome(
                  usuario:  _classUser,
                )));
  }

  _navigatorToRegistrationScreen() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const TelaCadastrarAcompanhador()));
  }
}
