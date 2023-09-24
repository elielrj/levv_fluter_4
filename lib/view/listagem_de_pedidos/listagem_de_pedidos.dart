import 'package:flutter/material.dart';
import 'package:levv4/biblioteca/cor/colors_levv.dart';
import 'package:levv4/biblioteca/numerador_de_pedido/numerador_de_pedido.dart';
import 'package:levv4/controller/menu_botoes_controller/menu_botoes_controller.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';
import 'package:levv4/biblioteca/texto/text_levv.dart';
import 'package:levv4/view/localizar/mapa.dart';
import 'package:levv4/view/localizar/tela_mapa.dart';

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
  final numeradorDePedido = NumeradorDePedido();

  @override
  void initState() {
    super.initState();
    widget.usuario.addListener(() => setState(() {}));
    widget.menuBotoesController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FUNDO_200_BUTTON_SELECTED,
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.usuario.listaDePedidos == null
              ? Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                "Não há \npedidos\npara seu usuário!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontStyle: FontStyle.italic),
              ),
            ],
          )
              : Card(
            margin: const EdgeInsets.all(4),
            elevation: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.menuBotoesController
                        .pedidosSelecionados(widget.usuario)
                        .isEmpty
                        ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Não há \npedidos "
                              "${widget.menuBotoesController
                              .listaDeNomeDosBotoes[widget.menuBotoesController
                              .botaoSelecionado()].toLowerCase()}\n"
                              "para seu usuário!",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    )
                        : Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (Pedido pedido in widget
                            .menuBotoesController
                            .pedidosSelecionados(widget.usuario))
                          Column(
                            children: [
                              _ItemComDetalhesDoPedido(
                                pedido: pedido,
                                menuBotoesController:
                                widget.menuBotoesController,
                                usuario: widget.usuario,
                              ),
                              SizedBox(
                                  height: 8,
                                  child: Container(
                                    color: FUNDO_200_BUTTON_SELECTED,
                                  ))
                            ],
                          )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ItemComDetalhesDoPedido extends StatefulWidget {
  const _ItemComDetalhesDoPedido({Key? key,
    required this.pedido,
    required this.menuBotoesController,
    required this.usuario})
      : super(key: key);

  final Pedido pedido;
  final MenuBotoesController menuBotoesController;
  final Usuario usuario;

  @override
  State<_ItemComDetalhesDoPedido> createState() =>
      _ItemComDetalhesDoPedidoState();
}

class _ItemComDetalhesDoPedidoState extends State<_ItemComDetalhesDoPedido> {
  final numeradorDePedido = NumeradorDePedido();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          /// 1 resumo do pedido
          Card(
              elevation: 4,
              child: Row(
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
                        numeradorDePedido.converterEmMd5(widget.pedido.numero!),
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
                        "${widget.pedido.calcularDistancia()
                            .toString()
                            .replaceAll(".", ",")} Km",
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
                        "R\$ ${widget.pedido.valor!
                            .toStringAsFixed(2)
                            .toString()
                            .replaceAll('.', ',')}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ],
              )),

          /// 2 - Coleta do pedido
          Card(
              elevation: 4,
              child: Row(
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
                        widget.pedido.itensDoPedido![0].coleta.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              )),

          ///3 - Entrega do pedido
          Card(
              elevation: 4,
              child: Row(
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
                        widget
                            .pedido
                            .itensDoPedido![
                        widget.pedido.itensDoPedido!.length - 1]
                            .entrega
                            .toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              )),

          /// botão acompanhar
          if (widget.menuBotoesController.listaDeStatusDosBotoes[0])
            Card(
                elevation: 4,
                child: Row(
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
                                    TelaMapa(
                                        pedido: widget.pedido,
                                        usuario: widget.usuario)));
                      },
                    ),
                  ],
                )),

          /// botão Finalizados
          if (widget.menuBotoesController.listaDeStatusDosBotoes[1])
            Card(
                elevation: 4,
                child: Row(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Mapa()));
                      },
                    ),
                  ],
                )),

          /// botão pendentes
          if (widget.menuBotoesController.listaDeStatusDosBotoes[2])
            Card(
                elevation: 4,
                child: Row(
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
                          await pedidoDAO.deletar(widget.pedido);

                          _navegarParaTelaEnviar();
                        } catch (error) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(TextLevv.ERRO),
                                  titlePadding: const EdgeInsets.all(20),
                                  titleTextStyle: const TextStyle(
                                      fontSize: 20, color: Colors.red),
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
                )),
        ],
      ),
    );
  }

  void _navegarParaTelaEnviar() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TelaMapa(
                  pedido: widget.pedido,
                  usuario: widget.usuario,
                )));
  }
}
