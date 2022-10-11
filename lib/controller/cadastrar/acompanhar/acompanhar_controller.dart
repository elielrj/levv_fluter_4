import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:levv4/view/home/tela_home.dart';
import '../../../api/codigo_do_pais/api_codigo_telefone_pais.dart';
import '../../../api/mascara/formatter_phone.dart';
import '../../../api/mascara/formatter_sms.dart';
import '../../../api/mascara/mask.dart';
import '../../../model/bo/usuario/perfil/acompanhar/acompanhar.dart';
import '../../../model/bo/usuario/usuario.dart';
import '../../../model/dao/usuario/usuario_dao.dart';

import '../../../model/dao/usuario/acompanhar_dao.dart';

class AcompanharController {
  final AcompanharDAO acompnharDAO = AcompanharDAO();

  Usuario? usuario;


  String verificationIdToken = "";

  final ApiCodigoTelefoneDoPais apiCodigoTelefoneDoPais = ApiCodigoTelefoneDoPais();

  final maskPhoneNumber = Mask(formatter: FormatterPhone());
  final controllerSmsMask = Mask(formatter: FormatterSms());


  bool numeroDeCelularEstaValido() {
    return maskPhoneNumber.formatter
        .getFormatter()
        .getUnmaskedText()
        .isNotEmpty &&
        maskPhoneNumber.formatter
            .getFormatter()
            .getUnmaskedText()
            .length ==
            11;
  }

  Future<void> createUserDAO() async {
    final usuarioDAO = UsuarioDAO();
    await usuarioDAO.criar(usuario!);
  }

  createUser(String celular) {
    usuario = Usuario(celular: celular, perfil: Acompanhar());
  }

  navegarParaTelaHome(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaHome(
              usuario: usuario!,
            )));
  }
}
