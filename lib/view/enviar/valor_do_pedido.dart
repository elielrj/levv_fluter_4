import 'package:flutter/material.dart';
import 'package:levv4/api/criador_de_pedido.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/api/texto/text_levv.dart';

class ValorDoPedido extends StatefulWidget {
  const ValorDoPedido({Key? key, required this.criadorDePedido})
      : super(key: key);

  final CriadorDePedido criadorDePedido;

  @override
  State<ValorDoPedido> createState() => _ValorDoPedidoState();
}

class _ValorDoPedidoState extends State<ValorDoPedido> {
  @override
  void initState() {
    super.initState();
    widget.criadorDePedido.controllerValorPedido.textEditingController
        .addListener(() => setState(() => {}));

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(TextLevv.VALOR),
        TextField(
          controller: widget
              .criadorDePedido.controllerValorPedido.textEditingController,
          inputFormatters: [
            widget.criadorDePedido.controllerValorPedido.formatter
                .getMaskTextInputFormatter()
          ],
          enabled: false,
          decoration: InputDecoration(
              labelStyle: const TextStyle(backgroundColor: Colors.white),
              labelText: widget.criadorDePedido.controllerValorPedido.formatter.getHint(),
              prefixIcon: const Icon(Icons.monetization_on),
              fillColor: Colors.white,
              filled: true),
        ),
      ],
    );
  }
}
