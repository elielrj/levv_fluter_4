import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'formatter.dart';

class FormatterPhone implements Formatter {

  final MaskTextInputFormatter formatter = MaskTextInputFormatter(mask: "(##) #####-####");

  static String HINT = "(00) 00000 0000";

  final TextInputType textInputType = TextInputType.phone;

  FormFieldValidator<String>? validator = (value) {//todo
  };

  @override
  MaskTextInputFormatter getFormatter() {
    return formatter;
  }

  @override
  bool isValid(TextEditingController textEditingController) {
    // TODO: implement getHint
    throw UnimplementedError();
  }

  @override
  String getHint() {
    return HINT;
  }

  @override
  TextInputType getTextInputType() {
   return textInputType;
  }
}
