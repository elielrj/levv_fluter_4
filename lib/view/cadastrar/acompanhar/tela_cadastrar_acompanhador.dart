import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../controller/cadastrar/acompanhar/acompanhar_controller.dart';

import '../../../api/cor/colors_levv.dart';
import '../../../api/imagem/image_levv.dart';
import '../../../api/texto/text_levv.dart';
import '../../../model/bo/usuario/perfil/acompanhar/acompanhar.dart';
import '../../../model/bo/usuario/usuario.dart';
import '../../componentes/logo/widget_logo_levv.dart';
import '../../home/tela_home.dart';

class TelaCadastrarAcompanhador extends StatefulWidget {
  const TelaCadastrarAcompanhador({Key? key}) : super(key: key);

  @override
  State<TelaCadastrarAcompanhador> createState() =>
      _TelaCadastrarAcompanhadorState();
}

class _TelaCadastrarAcompanhadorState extends State<TelaCadastrarAcompanhador> {
  final AcompanharController acompanharController = AcompanharController();

  bool smsEnviado = false;

  @override
  void initState() {
    super.initState();
    acompanharController.maskPhoneNumber.textEditingController .addListener(() => setState(() {}));
    acompanharController.controllerSmsMask.textEditingController .addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsLevv.FUNDO_400,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _logo(),
                !smsEnviado
                    ? _smsNaoEnviado()
                    : Container(width: 0),
                smsEnviado
                    ? _smsEnviado()
                    : Container(width: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() => Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: logoLevv(),
      );

  _smsNaoEnviado() => Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: acompanharController
                        .apiCodigoTelefoneDoPais.codigoDoTelefoneDoPais),
                const SizedBox(width: 8),
                SizedBox(
                  width: 280,
                  child: Column(
                    children: [
                      const SizedBox(height: 18),
                      TextField(
                        controller: acompanharController
                            .maskPhoneNumber.textEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            counterText: acompanharController
                                    .maskPhoneNumber.formatter
                                    .getFormatter()
                                    .getUnmaskedText()
                                    .isNotEmpty
                                ? "${acompanharController.maskPhoneNumber.formatter.getFormatter().getUnmaskedText().length} ${TextLevv.VARIOS_CARACTERES}"
                                : "${acompanharController.maskPhoneNumber.formatter.getFormatter().getUnmaskedText().length} ${TextLevv.UM_CARACTER}",
                            labelText: TextLevv.CELULAR,
                            labelStyle: const TextStyle(
                                backgroundColor: Colors.white,
                                color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black12, width: 2)),
                            prefixIcon: const Icon(
                              Icons.phone_iphone,
                              color: Colors.black,
                            ),
                            suffixIcon: acompanharController.maskPhoneNumber
                                    .textEditingController.text.isEmpty
                                ? Container(width: 0)
                                : IconButton(
                                    onPressed: () {
                                      acompanharController
                                          .maskPhoneNumber.textEditingController
                                          .clear();
                                    },
                                    icon: const Icon(Icons.close,
                                        color: Colors.red),
                                  ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: acompanharController
                                .maskPhoneNumber.formatter
                                .getHint()),
                        inputFormatters: [
                          acompanharController.maskPhoneNumber.formatter
                              .getFormatter()
                        ],
                        maxLength: 20,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _textButton(),
          ],
        ),
      );

  Widget _textButton() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.all(0),
          minimumSize: const Size(180, 65),
          elevation: 2,
          foregroundColor: Colors.black,
          alignment: Alignment.center,
        ),
        onPressed: () async => await criarUsuario(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageLevv.REGISTER,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 20),
            const Text(TextLevv.CADASTRAR)
          ],
        ),
      );

  _smsEnviado() => Container(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            TextField(
              controller:
                  acompanharController.controllerSmsMask.textEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counterText: acompanharController.maskPhoneNumber.formatter
                        .getFormatter()
                        .getUnmaskedText()
                        .isNotEmpty
                    ? "${acompanharController.maskPhoneNumber.formatter.getFormatter().getUnmaskedText().length} ${TextLevv.VARIOS_CARACTERES}"
                    : "${acompanharController.maskPhoneNumber.formatter.getFormatter().getUnmaskedText().length} ${TextLevv.UM_CARACTER}",
                labelText: TextLevv.CODIGO_SMS,
                labelStyle: const TextStyle(
                    backgroundColor: Colors.white, color: Colors.black),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.black12, width: 2)),
                prefixIcon: const Icon(
                  Icons.sms_outlined,
                  color: Colors.black,
                ),
                suffixIcon: acompanharController.controllerSmsMask.formatter
                        .getFormatter()
                        .getUnmaskedText()
                        .isEmpty
                    ? Container(width: 0)
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            acompanharController
                                .controllerSmsMask.textEditingController
                                .clear();
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                fillColor: Colors.white,
                filled: true,
              ),
              inputFormatters: [
                acompanharController.controllerSmsMask.formatter.getFormatter()
              ],
              maxLength: 7,
              style: const TextStyle(fontSize: 14),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                textStyle: const TextStyle(color: Colors.black, fontSize: 18),
                padding: const EdgeInsets.only(top: 8),
                minimumSize: const Size(180, 65),
                elevation: 2,
                foregroundColor: Colors.black,
                alignment: Alignment.center,
              ),
              onPressed: () async {
                await phoneCredentialWithCodeSent(
                    acompanharController.verificationIdToken,
                    int.parse(acompanharController.controllerSmsMask.formatter
                        .getFormatter()
                        .getUnmaskedText()));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageLevv.REGISTER,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 20),
                  const Text("Enviar Código")
                ],
              ),
            ),
          ],
        ),
      );


  Future<void> criarUsuario(
      ) async {
    if (acompanharController.numeroDeCelularEstaValido()) {
      await _verifyPhoneNumber();
    } else {
      _numeroDeCelularInvalido(context);
    }
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
  _verifyPhoneNumber() async {
    await acompanharController.acompnharDAO.autenticacao.auth.verifyPhoneNumber(
      phoneNumber: acompanharController.apiCodigoTelefoneDoPais
          .codigoDoTelefoneDoPais.defaultCountryCode.phoneCode +
          acompanharController.maskPhoneNumber.formatter
              .getFormatter()
              .getMaskedText(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await acompanharController.acompnharDAO.autenticacao.auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        acompanharController.acompnharDAO.autenticacao.codigoDeErro(e);
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
        smsEnviado = true;
        acompanharController.verificationIdToken = verificationId;
        });


      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
        smsEnviado = true;
        acompanharController.verificationIdToken = verificationId;
        });

      },
    );
  }





  Future<void> phoneCredentialWithCodeSent(
      String verificationId, int? resendToken) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: resendToken.toString());

    await _signInWithCredential(credential);

    if (acompanharController.usuario != null) {
      acompanharController.navegarParaTelaHome(context);
    }
  }

  Future<void> _signInWithCredential(
      PhoneAuthCredential credential) async {
    await acompanharController.acompnharDAO.autenticacao.auth
        .signInWithCredential(credential)
        .then((userCredetial) async {
      acompanharController.createUser(userCredetial.user!.phoneNumber.toString());
      await acompanharController.createUserDAO();
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


}
