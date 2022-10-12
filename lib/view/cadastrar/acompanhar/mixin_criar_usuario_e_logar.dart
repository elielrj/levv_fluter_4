import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levv4/model/dao/usuario/acompanhar_dao.dart';

import '../../../model/bo/usuario/perfil/acompanhar/acompanhar.dart';
import '../../../model/bo/usuario/usuario.dart';

mixin CriarUsuarioELogar {
  ///Cria um usuário credencial do firebase e prepara
  ///um usuário do tipo Acompanhador
  ///
  Future<void> criar(
      {required AcompanharDAO acompanharDAO,
      required PhoneAuthCredential credential,
      required Usuario? usuario}) async {
    ///criar a credencial de acesso no Firebase
    await acompanharDAO.autenticacao.auth
        .signInWithCredential(credential)
        .then((credential) {
      ///Cria o Usuario do App para posteriormente a sua inserção
      /// no banco de dados
      usuario = _createUser(celular: credential.user!.phoneNumber.toString());
    });
  }

  Usuario _createUser({required String celular}) {
    return Usuario(celular: celular, perfil: Acompanhar());
  }
}
