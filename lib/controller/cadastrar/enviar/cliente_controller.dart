import 'package:flutter/material.dart';

import '../../../api/mascara/formatter_cpf.dart';
import '../../../api/mascara/formatter_date.dart';
import '../../../api/mascara/mask.dart';
import '../../../model/bo/arquivo/arquivo.dart';

class ClienteController {
  final controllerNome = TextEditingController();
  final controllerSobrenome = TextEditingController();
  final controllerMaskCpf = Mask(formatter: FormatterCpf());
  final controllerMaskNascimento = Mask(formatter: FormatterDate());
  final documentoDeIdentificacao = Arquivo();

  bool documento = false;

  limparCampos() {
    controllerNome.clear();
    controllerSobrenome.clear();
    controllerMaskCpf.textEditingController.clear();
    controllerMaskNascimento.textEditingController.clear();

    documento = false;
  }

  bool camposEstaoValidos() {
    if (controllerNome.text.isNotEmpty &&
        controllerSobrenome.text.isNotEmpty &&
        controllerMaskCpf.textEditingController.text.isNotEmpty &&
        controllerMaskNascimento.textEditingController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
