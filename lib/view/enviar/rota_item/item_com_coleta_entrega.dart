import 'package:flutter/material.dart';
import 'package:levv4/view/enviar/rota_item/item_endereco.dart';
import '../../../model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import '../../../api/texto/text_levv.dart';

class ItemComColetaEntrega extends StatefulWidget {
  ItemComColetaEntrega(
      {Key? key, required this.itemDoPedido, required this.limparControllers})
      : super(key: key);

  ItemDoPedido itemDoPedido;
  bool limparControllers;

  @override
  State<ItemComColetaEntrega> createState() => _ItemComColetaEntregaState();
}

class _ItemComColetaEntregaState extends State<ItemComColetaEntrega> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          /// Campo Etiqueta c/ Nr de cada item
          Text(
            "Item: ${widget.itemDoPedido.ordem.toString()}",
            style: const TextStyle(
              fontSize: 10,
              backgroundColor: Colors.white70,
            ),
          ),

          /// Campo Coleta
          ItemEndereco(
              itemDoPedido: widget.itemDoPedido,
              limparControllers: widget.limparControllers,
              labelText: TextLevv.ENDERECO_COLETA),

          /// Campo Entrega
          ItemEndereco(
              itemDoPedido: widget.itemDoPedido,
              limparControllers: widget.limparControllers,
              labelText: TextLevv.ENDERECO_ENTREGA),
        ],
      ),
    );
  }
}
