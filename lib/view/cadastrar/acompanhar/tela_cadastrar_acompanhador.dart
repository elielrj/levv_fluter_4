import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levv4/model/backend/firebase/auth/error_firebase_auth.dart';
import 'package:levv4/view/home/tela_home.dart';

import '../../../model/backend/firebase/auth/firebase_auth.dart';
import '../../../model/bo/usuario/perfil/acompanhar/acompanhar.dart';
import '../../../model/bo/usuario/usuario.dart';
import '../../../model/dao/usuario/usuario_dao.dart';
import '../../../model/frontend/colors_levv.dart';
import '../../../model/frontend/image_levv.dart';
import '../../../model/frontend/text_levv.dart';

class TelaCadastrarAcompanhador extends StatefulWidget {
  const TelaCadastrarAcompanhador({Key? key}) : super(key: key);

  @override
  State<TelaCadastrarAcompanhador> createState() =>
      _TelaCadastrarAcompanhadorState();
}

class _TelaCadastrarAcompanhadorState extends State<TelaCadastrarAcompanhador>
    with ErrorFirebaseAuth {
  final _controllerPhoneNumber = TextEditingController();
  final autenticacao = Autenticacao(FirebaseAuth.instance);
  var _classUser;

  final _smsController = TextEditingController();
  bool smsEnviado = false;

  @override
  void initState() {
    super.initState();
    _controllerPhoneNumber.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _smsController;
    });

    return Scaffold(
      backgroundColor: ColorsLevv.FUNDO,
      body: Container(
        padding: const EdgeInsets.all(70),
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
            TextField(
              controller: _controllerPhoneNumber,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                counterText: _controllerPhoneNumber.text.length <= 1
                    ? "${_controllerPhoneNumber.text.length} ${TextLevv.UM_CARACTER}"
                    : "${_controllerPhoneNumber.text.length} ${TextLevv.VARIOS_CARACTERES}",
                labelText: TextLevv.CELULAR,
                labelStyle: const TextStyle(
                    backgroundColor: Colors.white, color: Colors.black),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.black12, width: 2)),
                prefixIcon: const Icon(
                  Icons.phone_iphone,
                  color: Colors.black,
                ),
                suffixIcon: _controllerPhoneNumber.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                        onPressed: () => _controllerPhoneNumber.clear(),
                        icon: const Icon(Icons.close, color: Colors.red),
                      ),
                fillColor: Colors.white,
                filled: true,
              ),
              maxLength: 11,
              style: const TextStyle(fontSize: 18),
            ),
            smsEnviado
                ? Container(
                    child: _widgetTextFieldToSms(),
                  )
                : Container(
                    width: 0,
                  ),
            TextButton(
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
                if (_controllerPhoneNumber.text.isNotEmpty &&
                    _controllerPhoneNumber.text.length == 11) {
                  //if (await _createUserWithEmailAndPassword()) {
                  setState(() {
                    smsEnviado = true;
                  });
                  _verifyPhoneNumber();
                  /*
                  if () {
                    _navigatorToHomeScreen();
                  } else {
                    _displayErrorWaringWhenRegistering();
                  }
                } else {
                  _displayEmptyFieldWaring();*/
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetTextFieldToSms() => Container(
        width: 200,
        child: TextField(
          controller: _smsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: _smsController.text.isNotEmpty
                ? "${_smsController.text.length} ${TextLevv.VARIOS_CARACTERES}"
                : "${_smsController.text.length} ${TextLevv.UM_CARACTER}",
            labelText: TextLevv.CODIGO_SMS,
            labelStyle: const TextStyle(
                backgroundColor: Colors.white, color: Colors.black),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12, width: 2)),
            prefixIcon: const Icon(
              Icons.sms_outlined,
              color: Colors.black,
            ),
            suffixIcon: _smsController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    onPressed: () => _smsController.clear(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
            fillColor: Colors.white,
            filled: true,
          ),
          maxLength: 6,
          style: const TextStyle(fontSize: 14),
        ),
      );

  Future<bool> _createUserWithEmailAndPassword() async {
    String celular = _controllerPhoneNumber.text.toString();
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
    await usuarioDAO.create(_classUser);

    //todo remove
    print("filtro user criado");
  }

  //1 - primeiro
  _verifyPhoneNumber() async {
    await autenticacao.auth.verifyPhoneNumber(
      phoneNumber: //_controllerPhoneNumber.text.toString(),
      //"+55 ${_controllerPhoneNumber.text.toString()}",
      //
      '+55 48 9 8830-2492',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        code(e);
      },
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = "123456";
        _smsController.text = smsCode;
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: _smsController.text.toString());
        await _signInWithCredential(credential);
        setState(() {
          _smsController.text = verificationId;
        });
        _navigatorToHomeScreen();
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _smsController.text = verificationId;
        });
        print("codeAutoRetrievalTimeout: $verificationId");
      },
    );
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
