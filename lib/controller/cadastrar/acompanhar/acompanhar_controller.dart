import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../api/codigo_do_pais/codigo_do_pais.dart';
import '../../../api/mascara/formatter_phone.dart';
import '../../../api/mascara/formatter_sms.dart';
import '../../../api/mascara/mask.dart';
import '../../../model/bo/usuario/perfil/acompanhar/acompanhar.dart';
import '../../../model/bo/usuario/usuario.dart';
import '../../../model/dao/usuario/usuario_dao.dart';

import '../../../model/dao/usuario/acompanhar_dao.dart';

class AcompanharController extends ChangeNotifier {
  final AcompanharDAO acompanharDAO = AcompanharDAO();
  final CodigoDoPais apiCodigoTelefoneDoPais = CodigoDoPais();
  final telefone = Mask(formatter: FormatterPhone());
  final sms = Mask(formatter: FormatterSms());
  Usuario? usuario;
  bool _smsEnviado = false;
  String _verificationIdToken = "";
  int? _resendToken;

  bool get smsEnviado => _smsEnviado;

  String get verificationIdToken => _verificationIdToken;

  mudarStatusDeSmsParaEnviado() {
    _smsEnviado = !smsEnviado;
    notifyListeners();
  }

  atualizarVerificationIdToken({required String novoVerificationIdToken}) {
    _verificationIdToken = novoVerificationIdToken;
    notifyListeners();
  }

  atualizarreSendToken(int? resendToken) {
    if (resendToken != null) {
      _resendToken = resendToken;
      notifyListeners();
    }
  }

  ///Chamado após clicar no botão p/ enviar o código do SMS
  ///
  PhoneAuthCredential phoneCredentialWithCodeSent() {
    ///Método static do Firebase Auth para criar credencial
    ///
    return PhoneAuthProvider.credential(
      verificationId: verificationIdToken,
      smsCode: sms.formatter.getFormatter().getUnmaskedText(),
    );
  }

  /// método para criar objeto Usuario e em seguida, logar com
  /// a credencial e ir para a tela Home
  ///
  Future<void> signInWithCredential(
      {required PhoneAuthCredential credential}) async {
    await acompanharDAO.autenticacao.auth.signInWithCredential(credential);
  }

  Future<void> inserirUsuarioNoBancoDeDados() async {
    final usuarioDAO = UsuarioDAO();
    await usuarioDAO.criar(usuario!);
  }

  void criarObjetoUsuario() {
    usuario = Usuario(
      celular: apiCodigoTelefoneDoPais.codigoDoPais.defaultCountryCode.phoneCode + telefone.formatter.getFormatter().getUnmaskedText(),
      perfil: Acompanhar(),
    );
  }

  Future<void> verifyPhoneNumber() async {
    await acompanharDAO.autenticacao.auth.verifyPhoneNumber(
      /// 1 - Telefone
      phoneNumber: _telefone(),

      ///2 - Caso o SMS seja reconhecido automáticamente
      verificationCompleted: (PhoneAuthCredential credential) async {
        //logar com credencial
        await signInWithCredential(credential: credential);

        //crial objeto Usuario Acompanhar
        criarObjetoUsuario();

        //inserir Usuario no DB
        await inserirUsuarioNoBancoDeDados();

        //todo notificar para mudar de tela

        print('is verificationCompleted!');
      },

      ///3 - Caso o SMS não seja reconhecido automáticamente
      verificationFailed: (FirebaseAuthException e) {
        acompanharDAO.autenticacao.codigoDeErro(e);
      },

      ///4 - Caso o SMS seja digitado manualmente????
      codeSent: (String verificationId, int? resendToken) async {
        mudarStatusDeSmsParaEnviado();
        atualizarVerificationIdToken(novoVerificationIdToken: verificationId);
        atualizarreSendToken(resendToken);
      },

      ///5 - Tempo de espera para recebimento do SMS no aparelho
      timeout: const Duration(seconds: 60),

      ///6 - Caso o SMS seja digitado manualmente???
      codeAutoRetrievalTimeout: (String verificationId) {
        mudarStatusDeSmsParaEnviado();
        atualizarVerificationIdToken(novoVerificationIdToken: verificationId);
      },
    );
  }

  ///Concatenar o Número de telefone com o código do país
  String _telefone() {
    return apiCodigoTelefoneDoPais.codigoDoPais.defaultCountryCode.phoneCode +
        telefone.formatter.getFormatter().getMaskedText();
  }

  ///2
  bool numeroDeCelularEstaValido() {
    return telefone.formatter.getFormatter().getUnmaskedText().isNotEmpty &&
        telefone.formatter.getFormatter().getUnmaskedText().length == 11;
  }

  existeUmUsuarioCorrente() {
    if (acompanharDAO.autenticacao.auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
