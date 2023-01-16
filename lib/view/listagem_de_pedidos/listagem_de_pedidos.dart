import 'package:flutter/material.dart';
import 'package:levv4/api/cor/colors_levv.dart';
import 'package:levv4/controller/menu_botoes_controller/menu_botoes_controller.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'lista_com_detahes_dos_pedidos.dart';

class ListagemDePedidos extends StatefulWidget {
  const ListagemDePedidos(
      {Key? key, required this.menuBotoesController, required this.usuario})
      : super(key: key);

  final MenuBotoesController menuBotoesController;
  final Usuario usuario;

  @override
  State<ListagemDePedidos> createState() => _ListagemDePedidosState();
}

class _ListagemDePedidosState extends State<ListagemDePedidos> {
  @override
  void initState() {
    super.initState();
    widget.usuario.addListener(() => setState(() {
          widget.usuario.listaDePedidos;
        }));
    widget.menuBotoesController.addListener(() => setState(() {}));
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
          widget.usuario.listaDePedidos != null
              ? _cardComTodosOsPedidos()
              : _listaVazia()
        ],
      ),
    );
  }

  Widget _cardComTodosOsPedidos() => Card(
        margin: const EdgeInsets.all(4),
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            widget.menuBotoesController.listaDeStatusDosBotoes[0] == true
                ? _listarPedidos(_listarPedidosAtivos())
                : widget.menuBotoesController.listaDeStatusDosBotoes[1] == true
                    ? _listarPedidos(_listarPedidosFinalizados())
                    : widget.menuBotoesController.listaDeStatusDosBotoes[2] ==
                            true
                        ? _listarPedidos(_listarPedidosPendentes())
                        : Container(width: 0)
          ],
        ),
      );

  Widget _listarPedidos(List<Pedido> pedidos) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        pedidos.isEmpty
            ? widget.menuBotoesController.listaDeStatusDosBotoes[0] == true
                ? _listaVazia(itemDoMenuSelecionado: "Ativos ")
                : widget.menuBotoesController.listaDeStatusDosBotoes[1] == true
                    ? _listaVazia(itemDoMenuSelecionado: "Finalizados ")
                    : widget.menuBotoesController.listaDeStatusDosBotoes[2] ==
                            true
                        ? _listaVazia(itemDoMenuSelecionado: "Pendentes ")
                        : Container(width: 0)
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (Pedido pedido in pedidos)
                    Column(
                      children: [
                        ItemComDetalhesDoPedido(
                          pedido: pedido,
                          listaDeStatusDosBotoes: widget
                              .menuBotoesController.listaDeStatusDosBotoes,
                          usuario: widget.usuario,
                        ),
                        SizedBox(
                            height: 8,
                            child: Container(
                              color: ColorsLevv.FUNDO_200_BUTTON_SELECTED,
                            ))
                      ],
                    )
                ],
              )
      ],
    );
  }

  List<Pedido> _listarPedidosAtivos() {
    List<Pedido> ativos = [];

    for (Pedido pedido in widget.usuario.listaDePedidos!) {
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

    for (Pedido pedido in widget.usuario.listaDePedidos!) {
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

    for (Pedido pedido in widget.usuario.listaDePedidos!) {
      if (!pedido.pedidoFoiEntregue! &&
          !pedido.pedidoFoiPago! &&
          pedido.pedidoEstaDisponivelParaEntrega!) {
        pendentes.add(pedido);
      }
    }

    return pendentes;
  }

  Widget _listaVazia({itemDoMenuSelecionado = ''}) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Não há \npedidos ${itemDoMenuSelecionado.toString().toLowerCase()}\npara seu usuário!",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black, fontSize: 24, fontStyle: FontStyle.italic),
          ),
        ],
      );
}
