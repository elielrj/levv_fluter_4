import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:levv4/view/home/tela_home.dart';
import '../../../model/bo/usuario/perfil/acompanhar/acompanhar.dart';
import '../../../model/bo/usuario/usuario.dart';
import '../../../model/dao/usuario/usuario_dao.dart';

import '../../../model/dao/usuario/acompanhar_dao.dart';
import '../../../view/cadastrar/acompanhar/phone_number_levv.dart';

class AcompanharController {
  final AcompanharDAO acompnharDAO = AcompanharDAO();

  Usuario? _usuario;

  bool smsEnviado = false;
  String verificationIdToken = "";

  Future<void> criarUsuario(
      BuildContext context, PhoneNumberLevv phoneNumberLevv) async {
    if (_numeroDeCelularEstaValido(phoneNumberLevv)) {
      await _verifyPhoneNumber(phoneNumberLevv);
    } else {
      _numeroDeCelularInvalido(context);
    }
  }

  bool _numeroDeCelularEstaValido(PhoneNumberLevv phoneNumberLevv) {
    return phoneNumberLevv.maskPhoneNumber.formatter
            .getFormatter()
            .getUnmaskedText()
            .isNotEmpty &&
        phoneNumberLevv.maskPhoneNumber.formatter
                .getFormatter()
                .getUnmaskedText()
                .length ==
            11;
  }

  _numeroDeCelularInvalido(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Não é possível cadastrar! Números inválidos",
                textAlign: TextAlign.center),
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
          );
        });
  }

  //1 - primeiro
  _verifyPhoneNumber(PhoneNumberLevv phoneNumberLevv) async {
    await acompnharDAO.autenticacao.auth.verifyPhoneNumber(
      phoneNumber: phoneNumberLevv.apiCodigoTelefoneDoPais
              .codigoDoTelefoneDoPais.defaultCountryCode.phoneCode +
          phoneNumberLevv.maskPhoneNumber.formatter
              .getFormatter()
              .getMaskedText(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await acompnharDAO.autenticacao.auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        acompnharDAO.autenticacao.codigoDeErro(e);
      },
      codeSent: (String verificationId, int? resendToken) async {
        //setState(() {
        smsEnviado = true;
        //});

        verificationIdToken = verificationId;
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        //setState(() {
        smsEnviado = true;
        //});
        verificationIdToken = verificationId;
      },
    );
  }

  _createUser(String celular) {
    _usuario = Usuario(celular: celular, perfil: Acompanhar());
  }

  Future<void> _createUserDAO() async {
    final usuarioDAO = UsuarioDAO();
    await usuarioDAO.criar(_usuario!);
  }

  Future<void> phoneCredentialWithCodeSent(
      String verificationId, int? resendToken, BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: resendToken.toString());

    await _signInWithCredential(credential, context);

    if (_usuario != null) {
      _navegarParaTelaHome(context);
    }
  }

  Future<void> _signInWithCredential(
      PhoneAuthCredential credential, BuildContext context) async {
    await acompnharDAO.autenticacao.auth
        .signInWithCredential(credential)
        .then((userCredetial) async {
      _createUser(userCredetial.user!.phoneNumber.toString());
      await _createUserDAO();
    }).onError((error, stackTrace) {
      print("codeSente: erro ao locar: ${error.toString()}");
      _displayErrorWaringWhenRegistering(error.toString(), context);
    });
  }

  _displayErrorWaringWhenRegistering(String erro, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
                "Erro ao tentar cadastrar! Entre em contato com o SAC!",
                textAlign: TextAlign.center),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
            content: Text(erro),
          );
        });
  }

  _displayEmptyFieldWaring(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Dados inválidos!", textAlign: TextAlign.center),
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          );
        });
  }

  _navegarParaTelaHome(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaHome(
                  usuario: _usuario!,
                )));
  }
}
