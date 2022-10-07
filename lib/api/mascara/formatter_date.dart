import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'formatter.dart';

class FormatterDate implements Formatter {

  final MaskTextInputFormatter formatter = MaskTextInputFormatter(mask: "##/##/####");

  static String HINT = "31/12/2020";

  final TextInputType textInputType = TextInputType.datetime;

  FormFieldValidator<String>? validator = (value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final components = value.split("/");
    if (components.length == 3) {
      final day = int.tryParse(components[0]);
      final month = int.tryParse(components[1]);
      final year = int.tryParse(components[2]);
      if (day != null && month != null && year != null) {
        final date = DateTime(year, month, day);
        if (date.year == year && date.month == month && date.day == day) {
          return null;
        }
      }
    }
    return "wrong date";
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
