import 'package:flutter/material.dart';
import 'package:levv4/api/numerador_de_pedido/numerador_de_pedido.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/view/componentes/menu_dos_botoes/menu_dos_botoes.dart';
import 'package:levv4/view/localizar/mapa.dart';
import 'package:levv4/view/localizar/tela_mapa.dart';

import '../../../model/bo/pedido/pedido.dart';

class ItemComDetalhesDoPedido extends StatefulWidget {
  const ItemComDetalhesDoPedido(
      {Key? key,
      required this.pedido,
      required this.listaDeStatusDosBotoes,
      required this.usuario})
      : super(key: key);

  final Pedido pedido;
  final List<bool> listaDeStatusDosBotoes;
  final Usuario usuario;

  @override
  State<ItemComDetalhesDoPedido> createState() =>
      _ItemComDetalhesDoPedidoState();
}

class _ItemComDetalhesDoPedidoState extends State<ItemComDetalhesDoPedido> {
  final numeradorDePedido = NumeradorDePedido();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      child: _linhaDetalheDeUmPedido(pedido: widget.pedido),
    );
  }

  _linhaDetalheDeUmPedido({required Pedido pedido}) => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(elevation: 4, child: _resumoDoPedido(pedido: pedido)),
          Card(elevation: 4, child: _localDeColetaDoPedido(pedido: pedido)),
          Card(elevation: 4, child: _localDeEntregaDoPedido(pedido: pedido)),
          if (widget.listaDeStatusDosBotoes[0])
            Card(elevation: 4, child: _botaoAcompanhar(pedido: pedido)),
          if (widget.listaDeStatusDosBotoes[1])
            Card(elevation: 4, child: _botaoFinalizados(pedido: pedido)),
          if (widget.listaDeStatusDosBotoes[2])
            Card(elevation: 4, child: _botaoPendentes(pedido: pedido)),
        ],
      );

  Widget _resumoDoPedido({required Pedido pedido}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Número do Pedido",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                numeradorDePedido.converterEmMd5(pedido.numero!),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                TextLevv.DISTANCIA,
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "${pedido.calcularDistancia().toString().replaceAll(".", ",")} Km",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Valor",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "R\$ ${pedido.valor!.toStringAsFixed(2).toString().replaceAll('.', ',')}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10),
              )
            ],
          ),
        ],
      );

  Widget _localDeColetaDoPedido({required Pedido pedido}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                TextLevv.COLETA,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              Text(
                pedido.itensDoPedido![0].coleta.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      );

  Widget _localDeEntregaDoPedido({required Pedido pedido}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                TextLevv.ENTREGA,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              Text(
                pedido.itensDoPedido![pedido.itensDoPedido!.length - 1].entrega
                    .toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      );

  Widget _botaoAcompanhar({required Pedido pedido}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            child: const Text(
              TextLevv.ACOMPANHAR,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TelaMapa(pedido: pedido, usuario: widget.usuario)));
            },
          ),
        ],
      );

  Widget _botaoFinalizados({required Pedido pedido}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            child: const Text(
              TextLevv.VISUALIZAR,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Mapa()));
            },
          ),
        ],
      );

  Widget _botaoPendentes({required Pedido pedido}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            child: const Text(
              TextLevv.EDIT,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
            onPressed: () async {
              final pedidoDAO = PedidoDAO();

              try {
                await pedidoDAO.deletar(pedido);

                _navegarParaTelaEnviar();
              } catch (error) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(TextLevv.ERRO),
                        titlePadding: const EdgeInsets.all(20),
                        titleTextStyle:
                            const TextStyle(fontSize: 20, color: Colors.red),
                        content: const Text(
                          TextLevv.UNABLE_TO_DELETE_ORDER,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(TextLevv.CLOSE)),
                        ],
                      );
                    });
              }
            },
          ),
        ],
      );

  void _navegarParaTelaEnviar() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaMapa(
                  pedido: widget.pedido,
                  usuario: widget.usuario,
                )));
  }
}
