import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'formatter.dart';

class FormatterSms implements Formatter {
  final MaskTextInputFormatter _maskTextInputFormatter =
      MaskTextInputFormatter(mask: "### ###");

  @override
  MaskTextInputFormatter getMaskTextInputFormatter() {
    return _maskTextInputFormatter;
  }

  @override
  bool isValid() {
    if (_maskTextInputFormatter.getUnmaskedText().length == 6) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String getHint() {
    return "000 000";
  }

  @override
  TextInputType getTextInputType() {
    return TextInputType.number;
  }
}
