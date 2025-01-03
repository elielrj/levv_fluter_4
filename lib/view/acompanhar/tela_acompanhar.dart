import 'dart:async';

import 'package:flutter/material.dart';
import 'package:levv4/controller/acompanhar/tela_acompanhar_controller.dart';
import 'package:levv4/model/bo/pedido_old/pedido_old.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../biblioteca/cor/colors_levv.dart';
import '../listagem_de_pedidos/listagem_de_pedidos.dart';
import '../componentes/menu_dos_botoes/menu_dos_botoes.dart';

class TelaAcompanhar extends StatefulWidget {
  const TelaAcompanhar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaAcompanhar> createState() => _TelaAcompanharState();
}

class _TelaAcompanharState extends State<TelaAcompanhar> {
  final TelaAcompanharController _controller = TelaAcompanharController();

  @override
  void initState() {
    super.initState();
    widget.usuario.listaDePedidos?.clear();
    widget.usuario.addListener(() => setState(() {}));
    _controller.menuDosBotoesController.addListener(() => setState(() {}));
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FUNDO_400,
        appBar: AppBar(
          title: const Text("Acompanhar um produto"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  MenuDosBotoes(
                      menuBotoesController:
                          _controller.menuDosBotoesController),
                  FutureBuilder<List<PedidoOld>>(
                    future: _buscarListaDePedidoDoUsuario(),
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
                                "sucess ao carregar dados! ${snapshot.data!.length.toString()}");
                          }
                          break;
                      }
                      return ListagemDePedidos(
                        menuBotoesController:
                            _controller.menuDosBotoesController,
                        usuario: widget.usuario,
                      );
                    },
                  )
                ])),
          ),
        ));
  }

  Future<List<PedidoOld>> _buscarListaDePedidoDoUsuario() async {
    List<PedidoOld> pedidos = [];
    try {
      final pedidoDAO = PedidoDAO();
      pedidos = await pedidoDAO.buscarPedidosDoUsuario(usuario: widget.usuario);
    } catch (erro) {
      _erro(erro.toString());
      print("Erro ao buscar pedido_old para listar--> ${erro.toString()}");
    }
    return pedidos;
  }

  _erro(String erro) => showDialog(
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
