import 'package:flutter/material.dart';

import '../../../api/codigo_do_pais/api_codigo_telefone_pais.dart';
import '../../../api/mascara/mask.dart';
import '../../../api/texto/text_levv.dart';
import '../../componentes/counter_text/counter_text.dart';
import '../../../api/mascara/formatter_phone.dart';
import '../../../api/mascara/formatter_sms.dart';

class PhoneNumberLevv extends StatelessWidget {
   PhoneNumberLevv({Key? key}) : super(key: key);

  final ApiCodigoTelefoneDoPais apiCodigoTelefoneDoPais =
  ApiCodigoTelefoneDoPais();

  final maskPhoneNumber = Mask(formatter: FormatterPhone());
  final controllerSmsMask = Mask(formatter: FormatterSms());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: apiCodigoTelefoneDoPais.codigoDoTelefoneDoPais),
        const SizedBox(width: 8),
        SizedBox(
          width: 280,
          child: Column(
            children: [
              const SizedBox(height: 18),
              TextField(
                controller: maskPhoneNumber.textEditingController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    counterText: CounterText(mask: maskPhoneNumber).contar(),
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
                    suffixIcon: maskPhoneNumber
                        .textEditingController.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                      onPressed: () {
                        maskPhoneNumber.textEditingController.clear();
                      },
                      icon: const Icon(Icons.close, color: Colors.red),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: maskPhoneNumber.formatter.getHint()),
                inputFormatters: [maskPhoneNumber.formatter.getFormatter()],
                maxLength: 20,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

