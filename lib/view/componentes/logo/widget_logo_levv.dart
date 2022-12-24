import 'package:flutter/material.dart';

import '../../../api/imagem/image_levv.dart';

Widget WidgetLogoLevv({double width = 90, double bottom = 0}) {
  return Padding(
    padding: EdgeInsets.only(bottom: bottom),
    child: Image.asset(
      ImageLevv.LOGO_DO_APP_LEVV,
      width: width,
    ),
  );
}
