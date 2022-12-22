import 'package:flutter/material.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/view/enviar/tela_enviar.dart';
import 'package:levv4/view/localizar/mapa.dart';

import '../../../../../model/bo/pedido/pedido.dart';

class ListaComDetalhesDosPedidos extends StatefulWidget {
  const ListaComDetalhesDosPedidos(
      {Key? key,
      required this.usuario,
      required this.pedidos,
      required this.listaDeStatusDosBotoes})
      : super(key: key);

  final Usuario usuario;
  final List<Pedido> pedidos;
  final List<bool> listaDeStatusDosBotoes;

  @override
  State<ListaComDetalhesDosPedidos> createState() =>
      _ListaComDetalhesDosPedidosState();
}

class _ListaComDetalhesDosPedidosState
    extends State<ListaComDetalhesDosPedidos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (Pedido pedido in widget.pedidos)
            _linhaDetalheDeUmPedido(pedido: pedido)
        ],
      ),
    );
  }

  _linhaDetalheDeUmPedido({required Pedido pedido}) => Column(
        children: [
          _numeroComValorDoPedido(pedido: pedido),
          _localDeColetaDoPedido(pedido: pedido),
          _localDeEntregaDoPedido(pedido: pedido),
          _distanciaDoPedidoEmQuilometros(pedido: pedido),
          if (widget.listaDeStatusDosBotoes[0])
            _botaoAcompanhar(pedido: pedido),
          if (widget.listaDeStatusDosBotoes[1])
            _botaoFinalizados(pedido: pedido),
          if (widget.listaDeStatusDosBotoes[2]) _botaoPendentes(pedido: pedido),
        ],
      );

  Widget _numeroComValorDoPedido({required Pedido pedido}) => Row(
        children: [
          Text("Número do Pedido\n${pedido.numero}"),
          Text("Valor\n${pedido.valor}"),
        ],
      );

  Widget _localDeColetaDoPedido({required Pedido pedido}) => Row(
        children: [
          Text(
              "${TextLevv.COLETA}\n${pedido.itensDoPedido![0].coleta.toString()}"),
        ],
      );

  Widget _localDeEntregaDoPedido({required Pedido pedido}) => Row(
        children: [
          Text(
              "${TextLevv.ENTREGA}\n${pedido.itensDoPedido![pedido.itensDoPedido!.length - 1].entrega}"),
        ],
      );

  Widget _distanciaDoPedidoEmQuilometros({required Pedido pedido}) => Row(
        children: [
          Text(
              "${TextLevv.DISTANCIA}\n${pedido.calcularDistancia().toString().replaceAll(".", ",")}")
        ],
      );

  Widget _botaoAcompanhar({required Pedido pedido}) => TextButton(
        child: const Text(TextLevv.ACOMPANHAR),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Mapa(

                      )));
        },
      );

  Widget _botaoFinalizados({required Pedido pedido}) => TextButton(
        child: const Text(TextLevv.VISUALIZAR),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Mapa(

                      )));
        },
      );

  Widget _botaoPendentes({required Pedido pedido}) => TextButton(
        child: const Text(TextLevv.EDIT),
        onPressed: () async {
          final pedidoDAO = PedidoDAO();

          try {
            await pedidoDAO.deletar(pedido);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TelaEnviar(usuario: widget.usuario)));
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
      );
}
