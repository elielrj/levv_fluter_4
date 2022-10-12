import 'package:flutter/material.dart';
import 'package:levv4/view/cadastrar/acompanhar/sms_enviado.dart';
import 'package:levv4/view/cadastrar/acompanhar/sms_nao_enviado.dart';

import '../../../controller/cadastrar/acompanhar/acompanhar_controller.dart';

import '../../../api/cor/colors_levv.dart';
import '../../componentes/logo/widget_logo_levv.dart';

class TelaCadastrarAcompanhador extends StatefulWidget {
  const TelaCadastrarAcompanhador({Key? key}) : super(key: key);

  @override
  State<TelaCadastrarAcompanhador> createState() =>
      _TelaCadastrarAcompanhadorState();
}

class _TelaCadastrarAcompanhadorState extends State<TelaCadastrarAcompanhador> {
  final AcompanharController acompanharController = AcompanharController();

  @override
  void initState() {
    super.initState();

    acompanharController.telefone.textEditingController
        .addListener(() => setState(() {}));
    acompanharController.sms.textEditingController
        .addListener(() => setState(() {}));
    acompanharController.addListener(() => setState(() {}));
  }

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
                logoLevv(bottom: 32),
                !acompanharController.smsEnviado
                    ? SmsNaoEnviado(acompanharController: acompanharController)
                    : Container(width: 0),
                acompanharController.smsEnviado
                    ? SmsEnviado(acompanharController: acompanharController)
                    : Container(width: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
