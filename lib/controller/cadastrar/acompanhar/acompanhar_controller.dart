import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:levv4/view/home/tela_home.dart';
import '../../../api/codigo_do_pais/codigo_do_pais.dart';
import '../../../api/mascara/formatter_phone.dart';
import '../../../api/mascara/formatter_sms.dart';
import '../../../api/mascara/mask.dart';
import '../../../model/bo/usuario/perfil/acompanhar/acompanhar.dart';
import '../../../model/bo/usuario/usuario.dart';
import '../../../model/dao/usuario/usuario_dao.dart';

import '../../../model/dao/usuario/acompanhar_dao.dart';
import '../../../view/cadastrar/acompanhar/erro_ao_tentar_cadastrar.dart';
import '../../../view/cadastrar/acompanhar/mixin_criar_usuario_e_logar.dart';
import '../../../view/cadastrar/acompanhar/numero_de_celular_invalido.dart';
import '../../../view/cadastrar/acompanhar/verify_phone_number.dart';

class AcompanharController extends ChangeNotifier with CriarUsuarioELogar {
  final AcompanharDAO acompanharDAO = AcompanharDAO();

  Usuario? usuario;
  bool _smsEnviado = false;

  bool get smsEnviado => _smsEnviado;

  mudarStatusDeSmsParaEnviado(){
    _smsEnviado = !smsEnviado;
    notifyListeners();
  }

  String _verificationIdToken = "";

  String get verificationIdToken => _verificationIdToken;

  atualizarVerificationIdToken({required String novoVerificationIdToken}){
    _verificationIdToken = novoVerificationIdToken;
    notifyListeners();
  }

  int? _resendToken;


  atualizarreSendToken(int? resendToken){
    if(resendToken != null){
      _resendToken = resendToken;
      notifyListeners();
    }
  }


  final CodigoDoPais apiCodigoTelefoneDoPais =
      CodigoDoPais();

  final telefone = Mask(formatter: FormatterPhone());
  final sms = Mask(formatter: FormatterSms());

  bool numeroDeCelularEstaValido() {
    return telefone.formatter.getFormatter().getUnmaskedText().isNotEmpty &&
        telefone.formatter.getFormatter().getUnmaskedText().length == 11;
  }

  Future<void> createUserDAO() async {
    final usuarioDAO = UsuarioDAO();
    await usuarioDAO.criar(usuario!);
  }

  _navegarParaTelaHome(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaHome(
                  usuario: usuario!,
                )));
  }

  Future<void> phoneCredentialWithCodeSent(BuildContext context) async {
    ///Método static do Firebase Auth para criar credencial
    ///
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdToken,
      smsCode: _resendToken.toString()?? "",
    );


    await _signInWithCredential(credential);

    if (usuario != null) {
      _navegarParaTelaHome(context);
    }
  }

  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    try {
      await criar(
        acompanharDAO: acompanharDAO,
        credential: credential,
        usuario: usuario,
      );
    } catch (erro) {
      ErroAoTentarCadastrar(mensagem: erro.toString());
    }
  }

  Future<void> criarUsuario() async {
    if (numeroDeCelularEstaValido()) {
      final VerifyPhoneNumber verifyPhoneNumber =
          VerifyPhoneNumber(controller: this );
      await verifyPhoneNumber.verifyPhoneNumber();
    } else {
      const NumeroDeCelularInvalido();
    }
  }

/*
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
  }*/
/*
  //1 - primeiro
  _verifyPhoneNumber() async {
    await acompnharDAO.autenticacao.auth.verifyPhoneNumber(
      phoneNumber: apiCodigoTelefoneDoPais
              .codigoDoTelefoneDoPais.defaultCountryCode.phoneCode +
          telefone.formatter.getFormatter().getMaskedText(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await acompnharDAO.autenticacao.auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        acompnharDAO.autenticacao.codigoDeErro(e);
      },
      codeSent: (String verificationId, int? resendToken) async {
        // setState(() {
        smsEnviado = true;
        verificationIdToken = verificationId;
        // });
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        //setState(() {
        smsEnviado = true;
        verificationIdToken = verificationId;
        // });
      },
    );
  }*/

/*
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
  }*/
}
