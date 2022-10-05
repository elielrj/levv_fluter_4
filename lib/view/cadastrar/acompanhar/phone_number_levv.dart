import 'package:flutter/material.dart';

import '../../../api/codigo_do_pais/api_coutry_phone_code.dart';
import '../../../api/texto/text_levv.dart';

class PhoneNumberLevv extends StatefulWidget {
  const PhoneNumberLevv({Key? key,
    this.controllerMaskPhoneNumber,
    required this.apiCoutryPhoneCode})
      : super(key: key);

  final controllerMaskPhoneNumber;
  final  ApiCoutryPhoneCode apiCoutryPhoneCode;

  @override
  State<PhoneNumberLevv> createState() => _PhoneNumberLevvState();
}

class _PhoneNumberLevvState extends State<PhoneNumberLevv> {


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: widget.apiCoutryPhoneCode.get()),
        SizedBox(
          width: 280,
          child: TextField(
            controller: widget.controllerMaskPhoneNumber.textEditingController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                counterText: widget.controllerMaskPhoneNumber.formatter
                            .getUnmaskedText()
                            .length <=
                        1
                    ? "${widget.controllerMaskPhoneNumber.formatter.getUnmaskedText().length} ${TextLevv.UM_CARACTER}"
                    : "${widget.controllerMaskPhoneNumber.formatter.getUnmaskedText().length} ${TextLevv.VARIOS_CARACTERES}",
                labelText: TextLevv.CELULAR,
                labelStyle: const TextStyle(
                    backgroundColor: Colors.white, color: Colors.black),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.black12, width: 2)),
                prefixIcon: const Icon(
                  Icons.phone_iphone,
                  color: Colors.black,
                ),
                suffixIcon: widget.controllerMaskPhoneNumber
                        .textEditingController.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                        onPressed: () => widget
                            .controllerMaskPhoneNumber.textEditingController
                            .clear(),
                        icon: const Icon(Icons.close, color: Colors.red),
                      ),
                fillColor: Colors.white,
                filled: true,
                hintText: widget.controllerMaskPhoneNumber.hint),
            inputFormatters: [widget.controllerMaskPhoneNumber.formatter],
            maxLength: 20,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
