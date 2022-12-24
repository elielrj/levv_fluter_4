import 'package:flutter/material.dart';
import 'package:levv4/api/criador_de_pedido.dart';
import 'package:levv4/api/imagem/image_levv.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';

class BotaoEnviarDoPedido extends StatefulWidget {
  const BotaoEnviarDoPedido({Key? key, required this.criadorDePedido})
      : super(key: key);

  final CriadorDePedido criadorDePedido;

  @override
  State<BotaoEnviarDoPedido> createState() => _BotaoEnviarDoPedidoState();
}

class _BotaoEnviarDoPedidoState extends State<BotaoEnviarDoPedido> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        textStyle: const TextStyle(color: Colors.black, fontSize: 18),
        padding: const EdgeInsets.all(0),
        minimumSize: const Size(180, 65),
        elevation: 2,
        foregroundColor: Colors.black,
        alignment: Alignment.center,
      ),
      onPressed: () async {
        widget.criadorDePedido.pedidoEstaCompleto()
            ? await widget.criadorDePedido.enviarPedido()
            : _exibirMensagemDeCampoVazio();
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
            child: Text(TextLevv.ENVIAR),
          ),
        ],
      ),
    );
  }

  _exibirMensagemDeCampoVazio() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(TextLevv.ERRO),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text(TextLevv.ERRO_PEDIDO_INCOMPLETO),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(TextLevv.OK))
            ],
          );
        });
  }
}
