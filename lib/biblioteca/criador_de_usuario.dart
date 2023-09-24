import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:levv4/biblioteca/firebase_autenticacao/mixin_codigo_de_erro_do_firebase_auth.dart';
import 'package:levv4/biblioteca/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/bo/acompanhar/acompanhar.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';

class CriadorDeUsuario extends ChangeNotifier with NomeDoDocumentoDoUsuarioCorrente, CodigoDeErroDoFirebaseAuth {
  String _verificationIdToken = "";
  bool _smsEnviado = false;
  int? resendToken;
  String get verificationIdToken => _verificationIdToken;
  bool get smsEnviado => _smsEnviado;
  var usuario;




  Future<void> criarUsuarioAcompanharPedido(
      String celular, String sms) async {
    /// Cria Usuário no FirebaseAuth
    ///
    await _criarCredencialManualmente(sms);

    usuario = await _criarUsuarioNoBancoDeDados();
  }

  ///Cria um Usuario com código SMS manualmente
  ///
  Future<void> _criarCredencialManualmente(String sms) async {
    //criar credencial
    final credential = _phoneCredentialWithCodeSent(sms);

    await _logaComCredencial(credential);
  }

  ///Chamado após clicar no botão p/ enviar o código do SMS
  ///
  PhoneAuthCredential _phoneCredentialWithCodeSent(String sms) {
    ///Método static do Firebase Auth para criar credencial
    ///
    return PhoneAuthProvider.credential(
        verificationId: _verificationIdToken, smsCode: sms);
  }

  ///
  Future<void> _logaComCredencial(PhoneAuthCredential credential) async {
    // 01 - logar com credencial
    await _signInWithCredential(credential: credential);
  }

  /// método para criar objeto Usuario e em seguida, logar com
  /// a credencial e ir para a tela Home
  ///
  Future<void> _signInWithCredential(
      {required PhoneAuthCredential credential}) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<Usuario> _criarUsuarioNoBancoDeDados() async {

    var usuario = await _buscaUsuarioNoBancoDeDados();

    if(usuario == null) {
      usuario = Usuario(
          celular: nomeDoDocumentoDoUsuarioCorrente(), perfil: Acompanhar());
      final UsuarioDAO usuarioDAO = UsuarioDAO();
      await usuarioDAO.criar(usuario);
    }
    return usuario;
  }

  Future<Usuario?> _buscaUsuarioNoBancoDeDados() async {
    final UsuarioDAO usuarioDAO = UsuarioDAO();
    return await usuarioDAO.buscar();
  }


  ///1.3
  Future<void> verifyPhoneNumber(String telefone) async {



    await FirebaseAuth.instance.verifyPhoneNumber(
      /// 1 - Telefone
      phoneNumber: telefone,

      ///2 - Caso o SMS seja reconhecido automáticamente
      verificationCompleted: (PhoneAuthCredential credential) async {

        await _signInWithCredential(credential: credential);

        usuario = await _criarUsuarioNoBancoDeDados();

        print('is verificationCompleted!');
      },

      ///3 - Caso o SMS não seja reconhecido automáticamente
      verificationFailed: (FirebaseAuthException e) {
        codigoDeErro(e);
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

  void mudarStatusDeSmsParaEnviado() {
    _smsEnviado = true;
    notifyListeners();
  }

  void atualizarVerificationIdToken({required String novoVerificationIdToken}) {
    if (novoVerificationIdToken != "" && novoVerificationIdToken != null) {
      _verificationIdToken = novoVerificationIdToken;
      notifyListeners();
    }
  }

  void atualizarreSendToken(int? novoResendToken) {
    if (novoResendToken != null) {
      resendToken = novoResendToken;
      notifyListeners();
    }
  }
}
