import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Mask {

  final TextEditingController textEditingController = TextEditingController();
  final MaskTextInputFormatter formatter;
  final FormFieldValidator<String>? validator;
  final String hint;
  final TextInputType textInputType;

  Mask(
      {required this.formatter,
        this.validator,
        required this.hint,
        required this.textInputType});
}