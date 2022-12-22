import 'package:flutter/material.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/view/enviar/item_da_rota_do_pedido.dart';

class RotaDoPedido extends StatefulWidget {
  const RotaDoPedido({Key? key, required this.pedido}) : super(key: key);

  final Pedido pedido;

  @override
  State<RotaDoPedido> createState() => _RotaDoPedidoState();
}

class _RotaDoPedidoState extends State<RotaDoPedido> {
  @override
  void initState() {
    super.initState();
  }

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
                    /// item do pedido
                    Card(
                      child: Column(
                        children: [
                          /// Campo Etiqueta c/ Nr de cada item
                          Text(
                            "Item: ${widget.pedido.itensDoPedido![index].ordem.toString()}",
                            style: const TextStyle(
                              fontSize: 10,
                              backgroundColor: Colors.white70,
                            ),
                          ),

                          /// Campo Coleta
                          ItemDaRotaDoPedido(
                            itemDoPedido: widget.pedido.itensDoPedido![index],
                            labelText: TextLevv.ENDERECO_COLETA,
                            pedido: widget.pedido,
                          ),

                          /// Campo Entrega
                          ItemDaRotaDoPedido(
                              itemDoPedido: widget.pedido.itensDoPedido![index],
                              labelText: TextLevv.ENDERECO_ENTREGA,
                              pedido: widget.pedido),
                        ],
                      ),
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
            widget.pedido.calcularValor();
          } else {
            _erroAoRemoverItem();
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
            _erroAoAdicionarItem();
          }
        },
        padding: const EdgeInsets.only(left: 8, right: 8),
        iconSize: 25,
      );

  _erroAoRemoverItem() {
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

  _erroAoAdicionarItem() {
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
