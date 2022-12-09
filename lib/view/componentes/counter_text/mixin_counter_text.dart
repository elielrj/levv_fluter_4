import 'package:flutter/material.dart';

import '../../../api/mascara/mask.dart';
import '../../../api/texto/text_levv.dart';

mixin CounterText {
  String counterText(Mask mask) {
    return mask.formatter.getMaskTextInputFormatter().getUnmaskedText().isNotEmpty
        ? "${mask.formatter.getMaskTextInputFormatter().getUnmaskedText().length} ${TextLevv.VARIOS_CARACTERES}"
        : "${mask.formatter.getMaskTextInputFormatter().getUnmaskedText().length} ${TextLevv.UM_CARACTER}";
  }
}
