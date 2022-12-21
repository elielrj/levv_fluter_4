import 'package:flutter/material.dart';
import 'package:levv4/api/imagem/image_levv.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';

class BotaoEnviarDoPedido extends StatefulWidget {
  const BotaoEnviarDoPedido({Key? key, required this.pedido}) : super(key: key);

  final Pedido pedido;

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
        final pedidoDAO = PedidoDAO();

        for (ItemDoPedido itemDoPedido in widget.pedido.itensDoPedido!) {
          if (itemDoPedido.coleta.toString().isEmpty ||
              itemDoPedido.entrega.toString().isEmpty) {
            _exibirMensagemDeCampoVazio();
            return;
          }
        }
        if (widget.pedido.valor == 0) {
          _exibirMensagemDeValorZero();
          return;
        }

        await pedidoDAO.criar(widget.pedido);
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
            title: const Text("Erro"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text("Há endereço(s) vazio(s)!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"))
            ],
          );
        });
  }

  _exibirMensagemDeValorZero() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text("O valor do pedido está zerado!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"))
            ],
          );
        });
  }
}
