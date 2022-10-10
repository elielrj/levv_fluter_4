import 'package:flutter/material.dart';
import 'package:levv4/view/cadastrar/acompanhar/phone_number_levv.dart';
import '../../../controller/cadastrar/acompanhar/acompanhar_controller.dart';

import '../../../api/cor/colors_levv.dart';
import '../../../api/imagem/image_levv.dart';
import '../../../api/texto/text_levv.dart';
import '../../componentes/counter_text/counter_text.dart';
import '../../componentes/logo/widget_logo_levv.dart';

class TelaCadastrarAcompanhador extends StatefulWidget {
  const TelaCadastrarAcompanhador({Key? key}) : super(key: key);

  @override
  State<TelaCadastrarAcompanhador> createState() =>
      _TelaCadastrarAcompanhadorState();
}

class _TelaCadastrarAcompanhadorState extends State<TelaCadastrarAcompanhador> {
  final AcompanharController acompanharController = AcompanharController();
  final PhoneNumberLevv phoneNumberLevv = PhoneNumberLevv();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsLevv.FUNDO_400,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _logo(),
                !acompanharController.smsEnviado
                    ? _smsNaoEnviado()
                    : Container(width: 0),
                acompanharController.smsEnviado
                    ? _smsEnviado()
                    : Container(width: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() => Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: logoLevv(),
      );

  Widget _textButton() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.all(0),
          minimumSize: const Size(180, 65),
          elevation: 2,
          foregroundColor: Colors.black,
          alignment: Alignment.center,
        ),
        onPressed: () async =>
            await acompanharController.criarUsuario(context, phoneNumberLevv),
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
            const Text(TextLevv.CADASTRAR)
          ],
        ),
      );

  _smsNaoEnviado() => Container(
        child: Column(
          children: [
            phoneNumberLevv,
            _textButton(),
          ],
        ),
      );

  _smsEnviado() => Container(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            TextField(
              controller:
                  phoneNumberLevv.controllerSmsMask.textEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counterText:
                    CounterText(mask: phoneNumberLevv.controllerSmsMask)
                        .contar(),
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
                suffixIcon: phoneNumberLevv.controllerSmsMask.formatter
                        .getFormatter()
                        .getUnmaskedText()
                        .isEmpty
                    ? Container(width: 0)
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            phoneNumberLevv
                                .controllerSmsMask.textEditingController
                                .clear();
                          });
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
                phoneNumberLevv.controllerSmsMask.formatter.getFormatter()
              ],
              maxLength: 7,
              style: const TextStyle(fontSize: 14),
            ),
            TextButton(
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
                await acompanharController.phoneCredentialWithCodeSent(
                    acompanharController.verificationIdToken,
                    int.parse(phoneNumberLevv.controllerSmsMask.formatter
                        .getFormatter()
                        .getUnmaskedText()),
                    context);
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
                  const Text("Enviar Código")
                ],
              ),
            ),
          ],
        ),
      );
}
