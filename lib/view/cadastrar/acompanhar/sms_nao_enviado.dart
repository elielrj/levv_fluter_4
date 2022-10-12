import 'package:flutter/material.dart';

import '../../../api/texto/text_levv.dart';
import '../../../controller/cadastrar/acompanhar/acompanhar_controller.dart';
import '../../componentes/counter_text/mixin_counter_text.dart';
import 'botao_cadastrar_acompanhador.dart';

class SmsNaoEnviado extends StatelessWidget with CounterText {
  SmsNaoEnviado({Key? key, required this.acompanharController})
      : super(key: key);

  AcompanharController acompanharController = AcompanharController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: acompanharController
                      .apiCodigoTelefoneDoPais.codigoDoPais),
              const SizedBox(width: 8),
              SizedBox(
                width: 280,
                child: Column(
                  children: [
                    const SizedBox(height: 18),
                    TextField(
                      controller:
                          acompanharController.telefone.textEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          counterText:
                              counterText(acompanharController.telefone),
                          labelText: TextLevv.CELULAR,
                          labelStyle: const TextStyle(
                              backgroundColor: Colors.white,
                              color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black12, width: 2)),
                          prefixIcon: const Icon(
                            Icons.phone_iphone,
                            color: Colors.black,
                          ),
                          suffixIcon: acompanharController
                                  .telefone.textEditingController.text.isEmpty
                              ? Container(width: 0)
                              : IconButton(
                                  onPressed: () {
                                    acompanharController
                                        .telefone.textEditingController
                                        .clear();
                                  },
                                  icon: const Icon(Icons.close,
                                      color: Colors.red),
                                ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: acompanharController.telefone.formatter
                              .getHint()),
                      inputFormatters: [
                        acompanharController.telefone.formatter.getFormatter()
                      ],
                      maxLength: 20,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),

          BotaoCadastrarAcompanhador(
              acompanharController: acompanharController),
        ],
      ),
    );
  }
}
