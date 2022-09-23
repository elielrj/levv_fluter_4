import 'package:flutter/material.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/view/componentes/erro/show_dialog_erro.dart';

import '../../model/bo/endereco/endereco.dart';
import '../../model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import '../../model/frontend/text_levv.dart';
import 'item_with_collect_delivery.dart';

class PedidoRota extends StatefulWidget {
  PedidoRota({Key? key, required this.pedido, required this.limparControllers})
      : super(key: key);

  final Pedido pedido;
  bool limparControllers;

  @override
  State<PedidoRota> createState() => _PedidoRotaState();
}

class _PedidoRotaState extends State<PedidoRota> with ShowDialogErro {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(TextLevv.ROTA),
        //item do pedido
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int index = 0;
                index < widget.pedido.itensDoPedido!.length;
                index++)
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ItemWithCollectAndDelivery(
                      itemDoPedido: widget.pedido.itensDoPedido![index],
                      limparControllers: widget.limparControllers,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //add item do pedido
                        _adicionarItem(index),
                        //remove item do pedido
                        _removerItem(index),
                      ],
                    )
                  ],
                ),
              ),
          ],
        )
      ],
    );
  }

  Widget _removerItem(int index) => IconButton(
        icon: const Icon(Icons.remove),
        color: Colors.red,
        onPressed: () {
          if (widget.pedido.itensDoPedido!.length > 1) {
            setState(() {
              widget.pedido.itensDoPedido!.removeAt(index);

              print("indice add: $index");

              int reordenar = 0;

              widget.pedido.itensDoPedido!.forEach((itemDoPedido) {
                itemDoPedido.ordem = ++reordenar;
              });
            });
          } else {
            erroAoRemoverItem(context);
          }
        },
        padding: const EdgeInsets.only(left: 8, right: 8),
        iconSize: 25,
      );

  Widget _adicionarItem(int index) => IconButton(
        icon: const Icon(Icons.add),
        color: Colors.white,
        onPressed: () {
          if (widget.pedido.itensDoPedido!.length < 10) {
            setState(() {
              ItemDoPedido itemDoPedido = ItemDoPedido(
                  ordem: (widget.pedido.itensDoPedido!.length + 1),
                  coleta: Endereco(),
                  entrega: Endereco());

              widget.pedido.itensDoPedido!.insert(index + 1, itemDoPedido);
              print("indice add: $index");

              int reordenar = 0;

              widget.pedido.itensDoPedido!.forEach((itemDoPedido) {
                itemDoPedido.ordem = ++reordenar;
              });
            });
          } else {
            erroAoAdicionarItem(context);
          }
        },
        padding: const EdgeInsets.only(left: 8, right: 8),
        iconSize: 25,
      );
}
