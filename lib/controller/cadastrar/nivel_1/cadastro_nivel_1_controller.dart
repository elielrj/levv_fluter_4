import 'package:flutter/material.dart';
import 'package:levv4/api/texto/text_levv.dart';

import 'package:levv4/api/validador_cnpj_cpf/validador_cnpj_cpf.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../api/mascara/formatter_cpf.dart';
import '../../../api/mascara/formatter_date.dart';
import '../../../api/mascara/mask.dart';
import '../../../model/bo/arquivo/arquivo.dart';

class CadastroNivel1Controller {
  ///CONTROLLES
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerSobrenome = TextEditingController();
  Mask controllerMaskCpf = Mask(formatter: FormatterCpf());

  Mask controllerMaskNascimento = Mask(formatter: FormatterDate());

  Arquivo documentoDeIdentificacao =
      Arquivo(descricao: TextLevv.DOCUMENTO_IDENTIFICACAO);

  void limparCampos() {
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
    print(
        "Tela cadastrar enviar controller --> documento--> ${documentoDeIdentificacao.file.toString()}");
    return documentoDeIdentificacao.file != null;
  }
}
