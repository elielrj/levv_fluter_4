import 'package:flutter/material.dart';
import 'package:levv4/api/validador_cnpj_cpf/validador_cnpj_cpf.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'formatter.dart';

 class FormatterCpf implements Formatter {
  final MaskTextInputFormatter _maskTextInputFormatter =
      MaskTextInputFormatter(mask: "###.###.###-##");

  @override
  MaskTextInputFormatter getMaskTextInputFormatter() {
    return _maskTextInputFormatter;
  }

  @override
  bool isValid() {
    return ValidadorCnpjCpf.isValidCpf(
        _maskTextInputFormatter.getMaskedText().toString());
  }

  @override
  String getHint() {
    return "000.000.000-00";
  }

  @override
  TextInputType getTextInputType() {
    return TextInputType.number;
  }
}
