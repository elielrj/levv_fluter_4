import 'package:flutter/material.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';

import '../../../model/bo/endereco/endereco.dart';
import '../../../model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import '../../../api/texto/text_levv.dart';
import '../rota_item/item_com_coleta_entrega.dart';

class PedidoRota extends StatefulWidget {
  PedidoRota(
      {Key? key,
      required this.pedido,
      required this.limparControllers})
      : super(key: key);

  final Pedido pedido;
  bool limparControllers;


  @override
  State<PedidoRota> createState() => _PedidoRotaState();
}

class _PedidoRotaState extends State<PedidoRota>  {



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
                    ItemComColetaEntrega(
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
            _erroAoRemoverItem(context);
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
            _erroAoAdicionarItem(context);
          }
        },
        padding: const EdgeInsets.only(left: 8, right: 8),
        iconSize: 25,
      );

  _erroAoRemoverItem(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro ao excluir item do pedido"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text("Não é possível excluir o último item!\n"
                "É necessário ter pelo menos 1 item!\n"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"))
            ],
          );
        });
  }

  _erroAoAdicionarItem(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro ao adicionar item do pedido"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text(
                "Não é possível adicionar mais de 10 itens no pedido"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"))
            ],
          );
        });
  }
}
