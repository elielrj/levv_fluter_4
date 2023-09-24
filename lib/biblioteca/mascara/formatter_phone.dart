import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'formatter.dart';

 class FormatterPhone implements Formatter {
  final MaskTextInputFormatter _maskTextInputFormatter =
      MaskTextInputFormatter(mask: "(##) #####-####");

  @override
  MaskTextInputFormatter getMaskTextInputFormatter() {
    return _maskTextInputFormatter;
  }

  @override
  bool isValid() {
    if (_maskTextInputFormatter.getUnmaskedText().length == 11) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String getHint() {
    return "(00) 00000 0000";
  }

  @override
  TextInputType getTextInputType() {
    return TextInputType.phone;
  }
}
