import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'formatter.dart';

class Mask  {

  final TextEditingController textEditingController = TextEditingController();
  final Formatter formatter;

  Mask({required this.formatter});
}