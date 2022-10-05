import 'package:flutter/material.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';

import '../model/bo/usuario/usuario.dart';
import '../view/cadastrar/acompanhar/tela_cadastrar_acompanhador.dart';
import '../view/home/tela_home.dart';

class UsuarioController {

  final UsuarioDAO _usuarioDAO = UsuarioDAO();
  late final Usuario _usuario;

  bool existeUsuarioFirebaseLogado() {
    return _usuarioDAO.autenticacao.auth.currentUser != null ? true : false;
  }

  Future<void> buscarUsuario() async {
    _usuario = await _usuarioDAO.buscarUmDocumentoPelaReferencia(_usuarioDAO.autenticacao
        .nomeDoDocumentoDoUsuarioCorrente(
            _usuarioDAO.autenticacao.auth.currentUser!));
  }

  Usuario get usuario => _usuario;

  navegarParaTelaHome({required BuildContext context}) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaHome(
                  usuario: _usuario,
                )));
  }

  navegarParaTelaCadastrarAcompanhador({required BuildContext context}) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const TelaCadastrarAcompanhador()));
  }
}
