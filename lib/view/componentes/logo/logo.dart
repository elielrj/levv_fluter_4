import 'package:flutter/material.dart';

import '../../../model/frontend/image_levv.dart';

Widget logoLevv({double? value}) {

  value ??= 90;

  return  Image.asset(
    ImageLevv.LOGO_DO_APP_LEVV,
    width: value,
  );
}