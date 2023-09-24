import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'formatter.dart';

 class FormatterCep  implements Formatter {
  final MaskTextInputFormatter _maskTextInputFormatter =
      MaskTextInputFormatter(mask: "#####-###");


  @override
  MaskTextInputFormatter getMaskTextInputFormatter() {
    return _maskTextInputFormatter;
  }

  @override
  bool isValid() {
    if (_maskTextInputFormatter.getUnmaskedText().length == 8) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String getHint() {
    return "00000-000";
  }

  @override
  TextInputType getTextInputType() {
    return TextInputType.number;
  }
}
