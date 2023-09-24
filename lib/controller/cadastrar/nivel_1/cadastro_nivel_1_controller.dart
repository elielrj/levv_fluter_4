import 'package:flutter/material.dart';
import 'package:levv4/biblioteca/texto/text_levv.dart';

import 'package:levv4/biblioteca/validador_cnpj_cpf/validador_cnpj_cpf.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../biblioteca/mascara/formatter_cpf.dart';
import '../../../biblioteca/mascara/formatter_date.dart';
import '../../../biblioteca/mascara/mask.dart';
import '../../../model/bo/arquivo/arquivo.dart';

class CadastroNivel1Controller {
  ///CONTROLLES
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerSobrenome = TextEditingController();
  Mask controllerMaskCpf = Mask(formatter: FormatterCpf());

  Mask controllerMaskNascimento = Mask(formatter: FormatterDate());

  Arquivo documentoDeIdentificacao =
      Arquivo(descricao: TextLevv.DOCUMENTO_IDENTIFICACAO);
  Color colorDocumentoDeIdentificacao = Colors.red;

  void limparCampos() {
    controllerNome.clear();
    controllerSobrenome.clear();
    controllerMaskCpf.textEditingController.clear();
    controllerMaskCpf.formatter.getMaskTextInputFormatter().clear();
    controllerMaskNascimento.textEditingController.clear();
    controllerMaskNascimento.formatter.getMaskTextInputFormatter().clear();
    documentoDeIdentificacao.file = null;
colorDocumentoDeIdentificacao = Colors.red;
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
    return documentoDeIdentificacao.file != null;
  }
}
