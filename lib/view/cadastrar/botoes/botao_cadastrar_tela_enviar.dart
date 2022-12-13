import 'package:flutter/material.dart';
import 'package:levv4/api/imagem/image_levv.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/controller/cadastrar/enviar/tela_cadastrar_enviar_controller.dart';
import 'package:levv4/view/cadastrar/enviar/tela_cadastrar_enviar.dart';


class BotaoCadastrarTelaEnviar extends StatefulWidget {
   const BotaoCadastrarTelaEnviar({Key? key}) : super(key: key);

  @override
  State<BotaoCadastrarTelaEnviar> createState() => _BotaoCadastrarTelaEnviarState();
}

class _BotaoCadastrarTelaEnviarState extends State<BotaoCadastrarTelaEnviar> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        textStyle: const TextStyle(color: Colors.black, fontSize: 18),
        padding: const EdgeInsets.all(8),
        minimumSize: const Size(190, 65),
        elevation: 2,
        foregroundColor: Colors.black,
        alignment: Alignment.center,
      ),
      onPressed: () {
        //vazio
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            widthFactor: 1,
            child: Image.asset(
              ImageLevv.REGISTER,
              width: 20,
              height: 20,
            ),
          ),
          const Center(
            widthFactor: 2,
            child: Text(TextLevv.CADASTRAR),
          ),
        ],
      ),
    );
  }
}

