import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class Formatter {
  MaskTextInputFormatter getFormatter();

  bool isValid(TextEditingController textEditingController);

  String getHint();

  TextInputType getTextInputType();
}
