import 'package:flutter/material.dart';
import 'package:levv4/biblioteca/mascara/mask.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'formatter.dart';

 class FormatterDate implements Formatter {
  final MaskTextInputFormatter _maskTextInputFormatter =
      MaskTextInputFormatter(mask: "##/##/####");

  @override
  MaskTextInputFormatter getMaskTextInputFormatter() {
    return _maskTextInputFormatter;
  }

  @override
  bool isValid() {
    try {
      DateTime.parse(_maskTextInputFormatter.getUnmaskedText().toString());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  String getHint() {
    return "31/12/2020";
  }

  @override
  TextInputType getTextInputType() {
    return TextInputType.datetime;
  }
}
