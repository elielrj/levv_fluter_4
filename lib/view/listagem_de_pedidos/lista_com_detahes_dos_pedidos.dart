import 'package:flutter/material.dart';
import 'package:levv4/api/numerador_de_pedido/numerador_de_pedido.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/view/componentes/botoes/menu_dos_botoes.dart';
import 'package:levv4/view/localizar/mapa.dart';
import 'package:levv4/view/localizar/tela_mapa.dart';

import '../../../model/bo/pedido/pedido.dart';

class ItemComDetalhesDoPedido extends StatefulWidget {
  const ItemComDetalhesDoPedido(
      {Key? key,
      required this.pedido,
      required this.menuDosBotoes,
      required this.usuario})
      : super(key: key);

  final Pedido pedido;
  final MenuDosBotoes menuDosBotoes;
  final Usuario usuario;

  @override
  State<ItemComDetalhesDoPedido> createState() =>
      _ItemComDetalhesDoPedidoState();
}

class _ItemComDetalhesDoPedidoState extends State<ItemComDetalhesDoPedido> {
  final numeradorDePedido = NumeradorDePedido();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
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
          if (widget.menuDosBotoes.listaDeStatusDosBotoes.listaDeStatusDosBotoes[0])
            Card(elevation: 4, child: _botaoAcompanhar(pedido: pedido)),
          if (widget.menuDosBotoes.listaDeStatusDosBotoes.listaDeStatusDosBotoes[1])
            Card(elevation: 4, child: _botaoFinalizados(pedido: pedido)),
          if (widget.menuDosBotoes.listaDeStatusDosBotoes.listaDeStatusDosBotoes[2])
            Card(elevation: 4, child: _botaoPendentes(pedido: pedido)),
        ],
      );

  Widget _resumoDoPedido({required Pedido pedido}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Número do Pedido\n${numeradorDePedido.converterEmMd5(pedido.numero!)}",
            textAlign: TextAlign.center,
          ),
          Text(
            "${TextLevv.DISTANCIA}\n${pedido.calcularDistancia().toString().replaceAll(".", ",")} Km",
            textAlign: TextAlign.center,
          ),
          Text(
            "Valor\nR\$ ${pedido.valor!.toStringAsFixed(2).toString().replaceAll('.', ',')}",
            textAlign: TextAlign.center,
          ),
        ],
      );

  Widget _localDeColetaDoPedido({required Pedido pedido}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "${TextLevv.COLETA}\n${pedido.itensDoPedido![0].coleta.toString()}",
            textAlign: TextAlign.center,
          ),
        ],
      );

  Widget _localDeEntregaDoPedido({required Pedido pedido}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
              "${TextLevv.ENTREGA}\n${pedido.itensDoPedido![pedido.itensDoPedido!.length - 1].entrega}",
              textAlign: TextAlign.center),
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
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TelaMapa(pedido: pedido, usuario: widget.usuario)));
            },
          ),
        ],
      );

  Widget _botaoFinalizados({required Pedido pedido}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            child: const Text(TextLevv.VISUALIZAR),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Mapa()));
            },
          ),
        ],
      );

  Widget _botaoPendentes({required Pedido pedido}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            child: const Text(TextLevv.EDIT),
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
