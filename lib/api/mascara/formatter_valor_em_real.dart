import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'formatter.dart';

class FormatterValorEmReal implements Formatter {

  final MaskTextInputFormatter _maskTextInputFormatter = MaskTextInputFormatter(mask: "# ###,##");



  @override
  MaskTextInputFormatter getMaskTextInputFormatter() {
    return _maskTextInputFormatter;
  }

  @override
  bool isValid() {
    return true;
  }

  @override
  String getHint() {
    return "0,00";
  }

  @override
  TextInputType getTextInputType() {
   return TextInputType.number;
  }
}
