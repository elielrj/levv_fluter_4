import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:levv4/view/enviar/item_address.dart';
import 'package:levv4/view/enviar/widget_item_label.dart';
import 'package:levv4/view/mapa/localizar/localizar.dart';
import 'package:levv4/view/mapa/mapa.dart';
import '../../model/bo/endereco/endereco.dart';
import '../../model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import '../../model/frontend/text_levv.dart';
import 'open_map_widget.dart';

class ItemWithCollectAndDelivery extends StatefulWidget {
  ItemWithCollectAndDelivery(
      {Key? key, required this.itemDoPedido, required this.limparControllers})
      : super(key: key);

  ItemDoPedido itemDoPedido;
  bool limparControllers;

  @override
  State<ItemWithCollectAndDelivery> createState() =>
      _ItemWithCollectAndDeliveryState();
}

class _ItemWithCollectAndDeliveryState
    extends State<ItemWithCollectAndDelivery> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          widgetItemLabel(widget.itemDoPedido.ordem.toString()),
          ItemAddress(
              itemDoPedido: widget.itemDoPedido,
              limparControllers: widget.limparControllers,
              labelText: TextLevv.ENDERECO_COLETA),
          ItemAddress(
              itemDoPedido: widget.itemDoPedido,
              limparControllers: widget.limparControllers,
              labelText: TextLevv.ENDERECO_ENTREGA),
        ],
      ),
    );
  }
}
