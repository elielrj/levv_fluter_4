import 'package:firebase_auth/firebase_auth.dart';
import 'package:levv4/controller/cadastrar/acompanhar/acompanhar_controller.dart';
import 'mixin_criar_usuario_e_logar.dart';

class VerifyPhoneNumber with CriarUsuarioELogar {
  VerifyPhoneNumber({required this.controller});

  final AcompanharController controller;

  Future<void> verifyPhoneNumber() async {
    await controller.acompanharDAO.autenticacao.auth.verifyPhoneNumber(
      /// 1 - Telefone
      phoneNumber: _telefone(),

      ///2 - Caso o SMS seja reconhecido automáticamente
      verificationCompleted: (PhoneAuthCredential credential) async {
        await criar(
          acompanharDAO: controller.acompanharDAO,
          credential: credential,
          usuario: controller.usuario,
        );
        controller.mudarStatusDeSmsParaEnviado();
      },

      ///3 - Caso o SMS não seja reconhecido automáticamente
      verificationFailed: (FirebaseAuthException e) {
        controller.acompanharDAO.autenticacao.codigoDeErro(e);
      },

      ///4 - Caso o SMS seja digitado manualmente????
      codeSent: (String verificationId, int? resendToken) async {
        controller.mudarStatusDeSmsParaEnviado();
        controller.atualizarVerificationIdToken(
            novoVerificationIdToken: verificationId);
        controller.atualizarreSendToken(resendToken);
      },

      ///5 - Tempo de espera para recebimento do SMS no aparelho
      timeout: const Duration(seconds: 60),

      ///6 - Caso o SMS seja digitado manualmente???
      codeAutoRetrievalTimeout: (String verificationId) {
        controller.mudarStatusDeSmsParaEnviado();
        controller.atualizarVerificationIdToken(
            novoVerificationIdToken: verificationId);
      },
    );
  }

  ///Concatenar o Número de telefone com o código do país
  String _telefone() {
    return controller
            .apiCodigoTelefoneDoPais.codigoDoPais.defaultCountryCode.phoneCode +
        controller.telefone.formatter.getFormatter().getMaskedText();
  }
}
