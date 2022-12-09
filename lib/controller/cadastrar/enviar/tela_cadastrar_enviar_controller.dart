import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levv4/api/validador_cnpj_cpf/validador_cnpj_cpf.dart';
import 'package:levv4/model/bo/enviar/enviar.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../api/mascara/formatter_cpf.dart';
import '../../../api/mascara/formatter_date.dart';
import '../../../api/mascara/mask.dart';
import '../../../model/bo/arquivo/arquivo.dart';

class TelaCadastrarEnviarController {
  ///CONTROLLES
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerSobrenome = TextEditingController();
  Mask controllerMaskCpf = Mask(formatter: FormatterCpf());

  Mask controllerMaskNascimento = Mask(formatter: FormatterDate());

  Arquivo documentoDeIdentificacao =
      Arquivo(descricao: "Documento de Identificação");

  limparCampos() {
    controllerNome.clear();
    controllerSobrenome.clear();
    controllerMaskCpf.textEditingController.clear();
    controllerMaskNascimento.textEditingController.clear();
    documentoDeIdentificacao.file = null;
  }

  bool validador() {
    return validarNome() &
        validarSobrenome() &
        validarCpf() &
        validarDataNascimento() &
        validarDocumentoDeIdentificacao();
  }

  bool validarNome() {
    return controllerNome.text.isNotEmpty;
  }

  bool validarSobrenome() {
    return controllerSobrenome.text.isNotEmpty;
  }

  bool validarCpf() {
    return controllerMaskCpf.formatter.isValid();
  }

  bool validarDataNascimento() {
    return controllerMaskNascimento.formatter.isValid();
  }

  bool validarDocumentoDeIdentificacao() {
    print("Tela cadastrar enviar controller --> documento--> ${documentoDeIdentificacao.file.toString()}");
    return documentoDeIdentificacao.file != null;
  }

  Enviar montarObjetoEnviar() => Enviar(
        nome: controllerNome.text,
        sobrenome: controllerSobrenome.text,
        cpf: controllerMaskCpf.textEditingController.text.toString(),
        nascimento: DateFormat('dd/MM/yyyy')
            .parse(controllerMaskNascimento.textEditingController.text)
            .toLocal(),
        documentoDeIdentificacao: documentoDeIdentificacao,
      );

  Future<void> atualizarCadastrarDoUsuarioComPerfilDeEnviar(
      Usuario usuario) async {
    //Atuaizar Usuario e criar perfil atual
    final usuarioDAO = UsuarioDAO();
    await usuarioDAO.atualizar(usuario);
  }
}
