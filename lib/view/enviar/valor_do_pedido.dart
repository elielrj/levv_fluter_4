import 'package:flutter/material.dart';
import 'package:levv4/api/mascara/formatter_valor_em_real.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';

class ValorDoPedido extends StatefulWidget {
  const ValorDoPedido({Key? key, required this.pedido}) : super(key: key);

  final Pedido pedido;

  @override
  State<ValorDoPedido> createState() => _ValorDoPedidoState();
}

class _ValorDoPedidoState extends State<ValorDoPedido> {
  final controller = Mask(formatter: FormatterValorEmReal());

  @override
  void initState() {
    super.initState();
    controller.textEditingController.addListener(() => setState(() {}));
   //widget.pedido.valor = double.parse(controller.formatter.getMaskTextInputFormatter().getMaskedText().replaceAll(',', '.'));

  //widget.pedido.addListener(() => _calcularNovoValorDoPedido());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(TextLevv.VALOR),
        TextField(
          controller: controller.textEditingController,
          inputFormatters: [controller.formatter.getMaskTextInputFormatter()],
          enabled: false,
          decoration: const InputDecoration(
              labelStyle: TextStyle(backgroundColor: Colors.white),
              labelText: "R\$ 0.00",
              prefixIcon: Icon(Icons.monetization_on),
              fillColor: Colors.white,
              filled: true),
        ),
      ],
    );
  }

  _calcularNovoValorDoPedido() {
    for (ItemDoPedido itemDoPedido in widget.pedido.itensDoPedido!) {
      if (itemDoPedido.coleta?.geolocalizacao == null ||
          itemDoPedido.entrega?.geolocalizacao == null) {
        return;
      }
    }

    widget.pedido.calcularValor();
    print("teste valor: ${widget.pedido.valor.toString()}");
  }
}
