import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../api/mascara/mask.dart';
/*
class MasksLevv {
  static Mask get dateMask => Mask(
      formatter: MaskTextInputFormatter(mask: "##/##/####"),
      hint: "31/12/2020",
      textInputType: TextInputType.phone,
      validator: (value) {
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
      });

  static Mask get phoneMaskInternation => Mask(
      formatter: MaskTextInputFormatter(mask: "+# ###-###-####"),
      hint: "+1 650 555 1212",
      textInputType: TextInputType.phone);

  static Mask get phoneMaskBrazil => Mask(
      formatter: MaskTextInputFormatter(mask: "(##) #####-####"),
      hint: "(00) 00000 0000",
      textInputType: TextInputType.phone);

  static Mask get smsMask => Mask(
      formatter: MaskTextInputFormatter(mask: "### ###"),
      hint: "000 000",
      textInputType: TextInputType.number);

  static Mask get cpfMask => Mask(
      formatter: MaskTextInputFormatter(mask: "###.###.###-##"),
      hint: "000.000.000-00",
      textInputType: TextInputType.number);

  static Mask get cepMask => Mask(
      formatter: MaskTextInputFormatter(mask: "#####-###"),
      hint: "00000-000",
      textInputType: TextInputType.number);

  static Mask get moedaRealMask => Mask(
      formatter: MaskTextInputFormatter(mask: "# ###,##"),
      hint: "0,00",
      textInputType: TextInputType.number);

}
*/