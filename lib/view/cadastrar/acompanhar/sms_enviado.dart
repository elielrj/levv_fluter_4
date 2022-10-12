import 'package:flutter/material.dart';

import '../../../api/texto/text_levv.dart';
import '../../../controller/cadastrar/acompanhar/acompanhar_controller.dart';
import 'botao_enviar_codigo_sms.dart';

class SmsEnviado extends StatelessWidget {
  SmsEnviado({Key? key, required this.acompanharController}) : super(key: key);

  AcompanharController acompanharController = AcompanharController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          TextField(
            controller: acompanharController.sms.textEditingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: acompanharController.telefone.formatter
                      .getFormatter()
                      .getUnmaskedText()
                      .isNotEmpty
                  ? "${acompanharController.telefone.formatter.getFormatter().getUnmaskedText().length} ${TextLevv.VARIOS_CARACTERES}"
                  : "${acompanharController.telefone.formatter.getFormatter().getUnmaskedText().length} ${TextLevv.UM_CARACTER}",
              labelText: TextLevv.CODIGO_SMS,
              labelStyle: const TextStyle(
                  backgroundColor: Colors.white, color: Colors.black),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.black12, width: 2)),
              prefixIcon: const Icon(
                Icons.sms_outlined,
                color: Colors.black,
              ),
              suffixIcon: acompanharController.sms.formatter
                      .getFormatter()
                      .getUnmaskedText()
                      .isEmpty
                  ? Container(width: 0)
                  : IconButton(
                      onPressed: () {
                        //setState(() {
                        acompanharController.sms.textEditingController.clear();
                        // });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
              fillColor: Colors.white,
              filled: true,
            ),
            inputFormatters: [
              acompanharController.sms.formatter.getFormatter()
            ],
            maxLength: 7,
            style: const TextStyle(fontSize: 14),
          ),
          BotaoEnviarCodigoSms(acompanharController: acompanharController),
        ],
      ),
    );
  }
}
