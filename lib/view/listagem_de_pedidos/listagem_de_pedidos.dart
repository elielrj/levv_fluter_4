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
    widget.usuario.addListener(() => setState(() {}));
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
                                      "${widget.menuBotoesController.listaDeNomeDosBotoes[widget.menuBotoesController.botaoSelecionado()].toLowerCase()}\n"
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
                                          ItemComDetalhesDoPedido(
                                            pedido: pedido,
                                            listaDeStatusDosBotoes: widget
                                                .menuBotoesController
                                                .listaDeStatusDosBotoes,
                                            usuario: widget.usuario,
                                          ),
                                          SizedBox(
                                              height: 8,
                                              child: Container(
                                                color: ColorsLevv
                                                    .FUNDO_200_BUTTON_SELECTED,
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
