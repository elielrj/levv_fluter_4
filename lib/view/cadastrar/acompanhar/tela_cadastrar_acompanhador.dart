import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levv4/api/codigo_do_pais/api_codigo_telefone_pais.dart';
import 'package:levv4/view/cadastrar/acompanhar/phone_number_levv.dart';
import 'package:levv4/view/home/tela_home.dart';

import '../../../api/mascara/masks_levv.dart';
import '../../../api/firebase_auth/autenticacao.dart';
import '../../../model/bo/usuario/perfil/acompanhar/acompanhar.dart';
import '../../../model/bo/usuario/usuario.dart';
import '../../../model/dao/usuario/usuario_dao.dart';
import '../../../api/cor/colors_levv.dart';
import '../../../api/imagem/image_levv.dart';
import '../../../api/texto/text_levv.dart';
import '../../componentes/logo/widget_logo_levv.dart';

class TelaCadastrarAcompanhador extends StatefulWidget {
  const TelaCadastrarAcompanhador({Key? key}) : super(key: key);

  @override
  State<TelaCadastrarAcompanhador> createState() =>
      _TelaCadastrarAcompanhadorState();
}

class _TelaCadastrarAcompanhadorState extends State<TelaCadastrarAcompanhador>
     {
  final autenticacao = Autenticacao();
  var _classUser;

  final _controllerSmsMask = MasksLevv.smsMask;
  bool smsEnviado = false;
  String verificationIdToken = "";

  final _controllerMaskPhoneNumber = MasksLevv.phoneMaskBrazil;

  final ApiCodigoTelefoneDoPais _apiCoutryPhoneCode = ApiCodigoTelefoneDoPais();

  @override
  void initState() {
    super.initState();

    _controllerMaskPhoneNumber.textEditingController
        .addListener(() => setState(() {}));

    _controllerSmsMask.textEditingController.addListener(() => setState(() {}));
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: logoLevv(),
                ),
                !smsEnviado
                    ? Container(
                        child: Column(
                          children: [
                            PhoneNumberLevv(
                                controllerMaskPhoneNumber:
                                    _controllerMaskPhoneNumber,
                                apiCoutryPhoneCode: _apiCoutryPhoneCode),
                            _textButton(),
                          ],
                        ),
                      )
                    : Container(
                        width: 0,
                      ),
                smsEnviado
                    ? Container(
                        padding: const EdgeInsets.only(top: 32),
                        child: Column(
                          children: [
                            TextField(
                              controller:
                                  _controllerSmsMask.textEditingController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                counterText: _controllerSmsMask.formatter
                                        .getUnmaskedText()
                                        .isNotEmpty
                                    ? "${_controllerSmsMask.formatter.getUnmaskedText().length} ${TextLevv.VARIOS_CARACTERES}"
                                    : "${_controllerSmsMask.formatter.getUnmaskedText().length} ${TextLevv.UM_CARACTER}",
                                labelText: TextLevv.CODIGO_SMS,
                                labelStyle: const TextStyle(
                                    backgroundColor: Colors.white,
                                    color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.black12, width: 2)),
                                prefixIcon: const Icon(
                                  Icons.sms_outlined,
                                  color: Colors.black,
                                ),
                                suffixIcon: _controllerSmsMask.formatter
                                        .getUnmaskedText()
                                        .isEmpty
                                    ? Container(width: 0)
                                    : IconButton(
                                        onPressed: () => _controllerSmsMask
                                            .textEditingController
                                            .clear(),
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              inputFormatters: [_controllerSmsMask.formatter],
                              maxLength: 7,
                              style: const TextStyle(fontSize: 14),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                padding: const EdgeInsets.only(top: 8),
                                minimumSize: const Size(180, 65),
                                elevation: 2,
                                primary: Colors.black,
                                alignment: Alignment.center,
                              ),
                              onPressed: () async {
                                await _phoneCredentialWithCodeSent(
                                    verificationIdToken,
                                    int.parse(_controllerSmsMask.formatter
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
                                  const Text("Enviar SMS")
                                ],
                              ),
                            ),
                            const Text("aguarde!"),
                          ],
                        ),
                      )
                    : Container(
                        width: 0,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textButton() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.all(0),
          minimumSize: const Size(180, 65),
          elevation: 2,
          primary: Colors.black,
          alignment: Alignment.center,
        ),
        onPressed: () async {
          if (_controllerMaskPhoneNumber.formatter
                  .getUnmaskedText()
                  .isNotEmpty &&
              _controllerMaskPhoneNumber.formatter.getUnmaskedText().length ==
                  11) {
            //if (await _createUserWithEmailAndPassword()) {

            await _verifyPhoneNumber();
            /*
                      if () {
                        _navigatorToHomeScreen();
                      } else {
                        _displayErrorWaringWhenRegistering();
                      }
                    } else {
                      _displayEmptyFieldWaring();*/
          }else{
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
            const Text(TextLevv.CADASTRAR)
          ],
        ),
      );

  Future<bool> _createUserWithEmailAndPassword() async {
    String celular =
        _controllerMaskPhoneNumber.textEditingController.text.toString();
    celular = "elielrj@gmail.com";

    //todo remove
    print("filtro ...auenticando...");
    await autenticacao.auth
        .createUserWithEmailAndPassword(email: celular, password: "952420")
        .then((userCredential) async {
      _createUser(userCredential.user!.email.toString());

      await _createUserDAO();

      return true;
    });
    //todo remove
    print("filtro ..autenticado");
    return false;
  }

  _createUser(String celular) {
    _classUser = Usuario(celular: celular, perfil: Acompanhar());
  }

  Future<void> _createUserDAO() async {
    //todo remove
    print("filtro criando user");
    final usuarioDAO = UsuarioDAO();
    await usuarioDAO.criar(_classUser);

    //todo remove
    print("filtro user criado");
  }

  //1 - primeiro
  _verifyPhoneNumber() async {

    print("Phone Code: " + _apiCoutryPhoneCode.get().defaultCountryCode.phoneCode + _controllerMaskPhoneNumber.formatter.getMaskedText());

    await autenticacao.auth.verifyPhoneNumber(
      phoneNumber: _apiCoutryPhoneCode.get().defaultCountryCode.phoneCode + _controllerMaskPhoneNumber.formatter.getMaskedText(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        autenticacao.codigoDeErro(e);
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          smsEnviado = true;
        });

        verificationIdToken = verificationId;
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          smsEnviado = true;
        });
        verificationIdToken = verificationId;
      },
    );
  }

  Future<void> _phoneCredentialWithCodeSent(
      String verificationId, int? resendToken) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: resendToken.toString());

    await _signInWithCredential(credential);

    if (_classUser != null) {
      _navigatorToHomeScreen();
    }
  }

  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    await autenticacao.auth
        .signInWithCredential(credential)
        .then((userCredetial) async {
      print("codeSente: sucess ao logar!");
      _createUser(userCredetial.user!.phoneNumber.toString());
      await _createUserDAO();
    }).onError((error, stackTrace) {
      print("codeSente: erro ao locar: ${error.toString()}");
    });
  }

  _displayErrorWaringWhenRegistering() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Erro ao tentar cadastrar! Entre em contato com o SAC!",
                textAlign: TextAlign.center),
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
          );
        });
  }

  _displayEmptyFieldWaring() {
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

  _navigatorToHomeScreen() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaHome(
                  usuario: _classUser,
                )));
  }
}
