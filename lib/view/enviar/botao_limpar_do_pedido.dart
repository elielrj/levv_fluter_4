import 'package:flutter/material.dart';
import 'package:levv4/api/criador_de_pedido.dart';
import 'package:levv4/api/imagem/image_levv.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';

class BotaoLimparDoPedido extends StatefulWidget {
  const BotaoLimparDoPedido({Key? key, required this.criadorDePedido}) : super(key: key);

  final CriadorDePedido criadorDePedido;

  @override
  State<BotaoLimparDoPedido> createState() => _BotaoLimparDoPedidoState();
}

class _BotaoLimparDoPedidoState extends State<BotaoLimparDoPedido> {
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
      onPressed: (){
        setState(() {
          widget.criadorDePedido.limparPedido();
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            widthFactor: 1,
            child: Image.asset(
              ImageLevv.ICON_TRASH,
              width: 20,
              height: 20,
            ),
          ),
          const Center(
            widthFactor: 2,
            child: Text(TextLevv.LIMPAR),
          ),
        ],
      ),
    );
  }
}

