import 'package:flutter/material.dart';
import 'package:levv4/controller/entregar/tela_entregar_controller.dart';
import 'package:levv4/model/bo/pedido_old/pedido_old.dart';

import '../../model/bo/usuario/usuario.dart';
import '../../model/dao/pedido/pedido_dao.dart';
import '../../biblioteca/cor/colors_levv.dart';
import '../listagem_de_pedidos/listagem_de_pedidos.dart';
import '../componentes/menu_dos_botoes/menu_dos_botoes.dart';

class TelaEntregar extends StatefulWidget {
  const TelaEntregar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaEntregar> createState() => _TelaEntregarState();
}

class _TelaEntregarState extends State<TelaEntregar> {
  final TelaEntregarController _controller = TelaEntregarController();

  @override
  void initState() {
    super.initState();
    widget.usuario.listaDePedidos?.clear();
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FUNDO_400,
        appBar: AppBar(
          title: const Text("Entregar um pedido_old"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  MenuDosBotoes(
                      menuBotoesController:
                          _controller.menuDosBotoesController),
                  FutureBuilder<List<PedidoOld>>(
                      future: _buscarListaDePedidosNaCidadeAtualDoEntregador(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            break;
                          case ConnectionState.waiting:
                            break;
                          case ConnectionState.active:
                            break;
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              print("Erro ao carregar os dados.");
                            } else {
                              _controller.adicionarPedidos(
                                  listaDePedidos: snapshot.data!,
                                  usuario: widget.usuario);

                              print(
                                  "sucess ao carregar dados! ${snapshot.data!.length}");
                            }
                            break;
                        }

                        return ListagemDePedidos(
                          menuBotoesController:
                              _controller.menuDosBotoesController,
                          usuario: widget.usuario,
                        );
                      }),
                ])),
          ),
        ));
  }

  Future<List<PedidoOld>> _buscarListaDePedidosNaCidadeAtualDoEntregador() async {
    List<PedidoOld> pedidos = [];
    try {
      _controller.endereco ?? await _controller.enderecoAtual();

      if (_controller.endereco != null) {
        final pedidoDAO = PedidoDAO();

        pedidos = await pedidoDAO.buscarPedidosPorCidade(
            _controller.endereco!.cidade!,
            usuario: widget.usuario);
      } else {
        print("Erro ao buscar endereço!");
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Erro"),
                titlePadding: const EdgeInsets.all(20),
                titleTextStyle:
                    const TextStyle(fontSize: 20, color: Colors.red),
                content: const Text(
                    'Não foi possível buscar obter sua localização para obter pedidos disponíveis!\nTente novamente!'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Ok")),
                ],
              );
            });
      }
    } catch (erro) {
      print("Erro ao buscar pedido_old para listar--> ${erro.toString()}");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Erro"),
              titlePadding: const EdgeInsets.all(20),
              titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
              content: const Text(
                  'Não foi possível buscar seus pedido_old!\nTente novamente!'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok")),
              ],
            );
          });
    }
    return pedidos;
  }
}
