import 'package:flutter/material.dart';

import '../../../api/mascara/mask.dart';
import '../../../api/texto/text_levv.dart';

class CounterText extends StatelessWidget {
  const CounterText({Key? key, required this.mask}) : super(key: key);

  final Mask mask;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,
    );
  }

  contar() {
    //mask.formatter.getFormatter().getUnmaskedText().characters.length;
    return mask.formatter.getFormatter().getUnmaskedText().isNotEmpty
        ? "${mask.formatter.getFormatter().getUnmaskedText().length} ${TextLevv.VARIOS_CARACTERES}"
        : "${mask.formatter.getFormatter().getUnmaskedText().length} ${TextLevv.UM_CARACTER}";
  }
}
