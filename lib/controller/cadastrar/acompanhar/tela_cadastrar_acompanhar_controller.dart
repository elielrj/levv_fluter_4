import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_codigo_de_erro_do_firebase_auth.dart';

import '../../../api/codigo_do_pais/codigo_do_pais.dart';
import '../../../api/mascara/formatter_phone.dart';
import '../../../api/mascara/formatter_sms.dart';
import '../../../api/mascara/mask.dart';
import '../../../model/bo/acompanhar/acompanhar.dart';
import '../../../model/bo/usuario/usuario.dart';
import '../../../model/dao/usuario/usuario_dao.dart';

class TelaCadastrarAcompanharController extends ChangeNotifier
    with CodigoDeErroDoFirebaseAuth {
 // final CodigoDoPais codigoDoPais = CodigoDoPais();
 // final telefone = Mask(formatter: FormatterPhone());
//  final sms = Mask(formatter: FormatterSms());
//  Usuario? usuario;
  //bool _smsEnviado = false;
  //String _verificationIdToken = "";
 // int? _resendToken;

  //bool get smsEnviado => _smsEnviado;

  //String get verificationIdToken => _verificationIdToken;
/*
  mudarStatusDeSmsParaEnviado() {
    _smsEnviado = true;
    notifyListeners();
  }*/
/*
  atualizarVerificationIdToken({required String novoVerificationIdToken}) {
    if (novoVerificationIdToken != "" && novoVerificationIdToken != null) {
      _verificationIdToken = novoVerificationIdToken;
      notifyListeners();
    }
  }*/
/*
  atualizarreSendToken(int? resendToken) {
    if (resendToken != null) {
      _resendToken = resendToken;
      notifyListeners();
    }
  }*/


/*
  /// método para criar objeto Usuario e em seguida, logar com
  /// a credencial e ir para a tela Home
  ///
  Future<void> signInWithCredential(
      {required PhoneAuthCredential credential}) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
  }*/
/*
  Future<void> inserirUsuarioNoBancoDeDados() async {
    final usuarioDAO = UsuarioDAO();
    await usuarioDAO.criar(usuario!);
  }

  void criarObjetoUsuario() {
    usuario = Usuario(
      celular: codigoDoPais.codigoDoPais.defaultCountryCode.phoneCode +
          telefone.formatter.getMaskTextInputFormatter().getUnmaskedText(),
      perfil: Acompanhar(),vejam s
    );
  }*/
/*

  ///Concatenar o Número de telefone com o código do país
  String _telefone() {
    return codigoDoPais.codigoDoPais.defaultCountryCode.phoneCode +
        telefone.formatter.getMaskTextInputFormatter().getMaskedText();
  }*/
/*
  ///2
  bool numeroDeCelularEstaValido() {
    return telefone.formatter.isValid();
  }

  bool existeUmUsuarioCorrente() {
    return FirebaseAuth.instance.currentUser != null;
  }
  */
/*
  ///Cria um Usuario com código SMS manualmente
  ///2.3
  Future<void> criarUsuarioComCodigoSMS() async {
    //criar credencial
    final credential = phoneCredentialWithCodeSent();

    await _logaComCredencialECriaUsuarioNoBanco(credential);
  }*/
/*
  ///Chamado após clicar no botão p/ enviar o código do SMS
  ///
  PhoneAuthCredential phoneCredentialWithCodeSent() {
    ///Método static do Firebase Auth para criar credencial
    ///
    return PhoneAuthProvider.credential(
      verificationId: verificationIdToken,
      smsCode: sms.formatter.getMaskTextInputFormatter().getUnmaskedText(),
    );
  }*/
/*
  ///Faz consulta ao banco, caso já esteve cadastrado,
  ///retorna um objeto usuário
  ///
  Future<void> _buscaUsuarioSeJaEsteveCadastrado() async {
    try {
      final usuarioDAO = UsuarioDAO();
      usuario = await usuarioDAO.buscar();
    } catch (erro) {
      print(
          'acompanhar Controller--> método _buscaUsuarioSeJaEsteveCadastrado()\n'
          'erro ao verificar se  usuário estava cadastrado: ${erro.toString()}\n'
          'ou usuário não esta cadastrado.');
    }
  }
  */
/*
  ///2.3
  Future<void> _logaComCredencialECriaUsuarioNoBanco(
      PhoneAuthCredential credential) async {
    // 01 - logar com credencial
    await signInWithCredential(credential: credential);

    //02 - verifica se o Nr cel já possuí cadastro!
    await _buscaUsuarioSeJaEsteveCadastrado();

    //03 - somente insere no banco, caso não haja cadastro anterior
    await cadastrarUsuarioNoBanco();
  }*/
/*
  Future<void> cadastrarUsuarioNoBanco() async {
    if (usuario == null) {
      //crial objeto Usuario Acompanhar
      criarObjetoUsuario();

      //inserir Usuario no DB
      await inserirUsuarioNoBancoDeDados();
    }
  }

  Future<bool> verificarSeExisteUsuarioNoBanco() async {
    final usuarioDAO = UsuarioDAO();

    var user = await usuarioDAO.buscar();

    if (user is Usuario) {
      usuario = user;
      return true;
    } else {
      return false;
    }
  }*/
}
