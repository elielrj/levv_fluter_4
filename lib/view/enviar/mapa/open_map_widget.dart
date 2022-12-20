import 'package:flutter/material.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';

import '../../localizar/mapa.dart';

Widget openMapWidget(
    ItemDoPedido itemDoPedido, bool isTrafficEnabled, String labelText) {
  bool selecionarLocalizacao = false;
  return Column(
    children: [
      Container(
          color: Colors.white,
          //width: double.infinity,
          height: 300,
          child: Mapa(
            itemDoPedido: itemDoPedido,
            isMyLocationEnabled: false,
            isTrafficEnabled: isTrafficEnabled,
            labelText: labelText,
            selecionarLocalizacao: selecionarLocalizacao,
          )),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(

                padding: const EdgeInsets.all(32),
                shadowColor: Colors.black,
                elevation: 3,
                backgroundColor: Colors.grey.shade200),
            onPressed: () async {
              selecionarLocalizacao = true;
            },
            child: const Text("Selecionar Local",

                style: TextStyle(color: Colors.black,fontSize: 16)),
          ),
        ],
      )
    ],
  );
}
