import 'package:flutter/material.dart';
import 'package:levv4/api/cor/colors_levv.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/view/componentes/botoes/menu_dos_botoes.dart';
import 'lista_com_detahes_dos_pedidos.dart';

class ListagemDePedidos extends StatefulWidget {
  ListagemDePedidos(
      {Key? key,
      required this.menuDosBotoes,
      required this.usuario,
      required this.pedidos})
      : super(key: key);

  final MenuDosBotoes menuDosBotoes;
  final Usuario usuario;
  final List<Pedido> pedidos;

  @override
  State<ListagemDePedidos> createState() => _ListagemDePedidosState();
}

class _ListagemDePedidosState extends State<ListagemDePedidos> {
  @override
  void initState() {
    super.initState();
    widget.usuario.addListener(() => setState(() {}));
    widget.menuDosBotoes.listaDeStatusDosBotoes
        .addListener(() => setState(() {}));
    widget.pedidos;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsLevv.FUNDO_200_BUTTON_SELECTED,
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.pedidos.isNotEmpty
              ? Card(
                  margin: const EdgeInsets.all(4),
                  elevation: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (widget.menuDosBotoes.listaDeStatusDosBotoes
                          .listaDeStatusDosBotoes[0])
                        _listarPedidos(_listarPedidosAtivos()),
                      if (widget.menuDosBotoes.listaDeStatusDosBotoes
                          .listaDeStatusDosBotoes[1])
                        _listarPedidos(_listarPedidosFinalizados()),
                      if (widget.menuDosBotoes.listaDeStatusDosBotoes
                          .listaDeStatusDosBotoes[2])
                        _listarPedidos(_listarPedidosPendentes()),
                    ],
                  ),
                )
              : _listaVazia()
        ],
      ),
    );
  }

  Widget _listarPedidos(List<Pedido> pedidos) => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          pedidos.isEmpty
              ? _listaVazia()
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (Pedido pedido in pedidos)
                      ItemComDetalhesDoPedido(
                        pedido: pedido,
                        menuDosBotoes: widget.menuDosBotoes,
                        usuario: widget.usuario,
                      ),
                  ],
                )
        ],
      );

  List<Pedido> _listarPedidosAtivos() {
    List<Pedido> ativos = [];

    for (Pedido pedido in widget.pedidos) {
      if (!pedido.pedidoFoiEntregue! &&
          !pedido.pedidoFoiPago! &&
          !pedido.pedidoEstaDisponivelParaEntrega!) {
        ativos.add(pedido);
      }
    }

    return ativos;
  }

  List<Pedido> _listarPedidosFinalizados() {
    List<Pedido> finalizados = [];

    for (Pedido pedido in widget.pedidos) {
      if (pedido.pedidoFoiEntregue! &&
          pedido.pedidoFoiPago! &&
          !pedido.pedidoEstaDisponivelParaEntrega!) {
        finalizados.add(pedido);
      }
    }

    return finalizados;
  }

  List<Pedido> _listarPedidosPendentes() {
    List<Pedido> pendentes = [];

    for (Pedido pedido in widget.pedidos) {
      if (!pedido.pedidoFoiEntregue! &&
          !pedido.pedidoFoiPago! &&
          pedido.pedidoEstaDisponivelParaEntrega!) {
        pendentes.add(pedido);
      }
    }

    return pendentes;
  }

  Widget _listaVazia() => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "Não há pedidos para seu usuário!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontStyle: FontStyle.italic),
          ),
        ],
      );
}
