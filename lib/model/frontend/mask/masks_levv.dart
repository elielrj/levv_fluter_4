import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'mask.dart';

class MasksLevv{


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
      }
  );

  static Mask get phoneMaskInternation => Mask(
      formatter: MaskTextInputFormatter(mask: "+## ## # #### ####"),
      hint: "+0 000 00 0000",
      textInputType: TextInputType.phone);

  static Mask get phoneMaskBrazil => Mask(
      formatter: MaskTextInputFormatter(mask: "+## ## # #### ####"),
      hint: "+00 00 0 0000 0000",
      textInputType: TextInputType.phone);


}