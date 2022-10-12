import 'package:flutter/material.dart';
import 'package:levv4/api/texto/text_levv.dart';

import '../../../api/imagem/image_levv.dart';
import '../../../controller/cadastrar/acompanhar/acompanhar_controller.dart';

class BotaoEnviarCodigoSms extends StatelessWidget {
  BotaoEnviarCodigoSms({Key? key, required this.acompanharController})
      : super(key: key);

  AcompanharController acompanharController = AcompanharController();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        textStyle: const TextStyle(color: Colors.black, fontSize: 18),
        padding: const EdgeInsets.only(top: 8),
        minimumSize: const Size(180, 65),
        elevation: 2,
        foregroundColor: Colors.black,
        alignment: Alignment.center,
      ),
      onPressed: () async {
        await acompanharController.phoneCredentialWithCodeSent(context);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageLevv.REGISTER,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 20),
          const Text(TextLevv.ENVIAR_CODIGO_SMS)
        ],
      ),
    );
  }
}
