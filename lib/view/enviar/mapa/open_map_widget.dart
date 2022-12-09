import 'package:flutter/material.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';

import '../../localizar/mapa.dart';


Widget openMapWidget(ItemDoPedido itemDoPedido, bool isTrafficEnabled) => Container(
    color: Colors.white,
    //width: double.infinity,
    height: 300,
    child: Mapa(
      itemDoPedido: itemDoPedido,
      isMyLocationEnabled: false,
      isTrafficEnabled: isTrafficEnabled,
    ));