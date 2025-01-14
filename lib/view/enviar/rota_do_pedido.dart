import 'package:flutter/material.dart';
import 'package:levv4/biblioteca/criador_de_pedido.dart';
import 'package:levv4/biblioteca/texto/text_levv.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/pedido_old/item_do_pedido.dart';
import 'package:levv4/view/enviar/item_da_rota_do_pedido.dart';

class RotaDoPedido extends StatefulWidget {
  const RotaDoPedido({
    Key? key,
    required this.criadorDePedido,
  }) : super(key: key);

  final CriadorDePedido criadorDePedido;

  @override
  State<RotaDoPedido> createState() => _RotaDoPedidoState();
}

class _RotaDoPedidoState extends State<RotaDoPedido> {
  @override
  void initState() {
    super.initState();
    widget.criadorDePedido.addListener(() => setState(() {}));


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
                index < widget.criadorDePedido.itensDoPedido.length;
                index++)
              _item(index),
          ],
        )
      ],
    );
  }

  Widget _item(int index) =>

      /// item do pedido_old
      Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Column(
                children: [
                  /// Campo Etiqueta c/ Nr de cada item
                  Text(
                    "Item: ${widget.criadorDePedido.itensDoPedido[index].ordem.toString()}",
                    style: const TextStyle(
                      fontSize: 10,
                      backgroundColor: Colors.white70,
                    ),
                  ),

                  /// Campo Coleta
                  ItemDaRotaDoPedido(
                      itemDoPedido: widget.criadorDePedido.itensDoPedido[index],
                      labelText: TextLevv.ENDERECO_COLETA,
                      criadorDePedido: widget.criadorDePedido),

                  /// Campo Entrega
                  ItemDaRotaDoPedido(
                      itemDoPedido: widget.criadorDePedido.itensDoPedido[index],
                      labelText: TextLevv.ENDERECO_ENTREGA,
                      criadorDePedido: widget.criadorDePedido),
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
      );

  Widget _removerItem(int index) => IconButton(
        icon: const Icon(Icons.remove),
        color: Colors.red,
        onPressed: () {
          if (widget.criadorDePedido.itensDoPedido.length > 1) {
            setState(() {
              widget.criadorDePedido.itensDoPedido.removeAt(index);

              print("indice add: $index");

              int reordenar = 0;

              widget.criadorDePedido.itensDoPedido.forEach((itemDoPedido) {
                itemDoPedido.ordem = ++reordenar;
              });
            });
            widget.criadorDePedido.calcularValorDoPedido();
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
          if (widget.criadorDePedido.itensDoPedido.length < 10) {
            setState(() {
              ItemDoPedido itemDoPedido = ItemDoPedido(
                  ordem: (widget.criadorDePedido.itensDoPedido.length + 1),
                  coleta: Endereco(),
                  entrega: Endereco());

              widget.criadorDePedido.itensDoPedido
                  .insert(index + 1, itemDoPedido);
              print("indice add: $index");

              int reordenar = 0;

              widget.criadorDePedido.itensDoPedido.forEach((itemDoPedido) {
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

  _erroAoAdicionarItem() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro ao adicionar item do pedido_old"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text(
                "Não é possível adicionar mais de 10 itens no pedido_old"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"))
            ],
          );
        });
  }

  _erroAoRemoverItem() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro ao excluir item do pedido_old"),
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
}
