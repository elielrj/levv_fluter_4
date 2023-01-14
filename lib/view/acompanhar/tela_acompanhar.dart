import 'dart:async';

import 'package:flutter/material.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/dao/pedido/pedido_dao.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../api/cor/colors_levv.dart';
import '../listagem_de_pedidos/listagem_de_pedidos.dart';
import '../componentes/botoes/menu_dos_botoes.dart';

class TelaAcompanhar extends StatefulWidget {
  const TelaAcompanhar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaAcompanhar> createState() => _TelaAcompanharState();
}

class _TelaAcompanharState extends State<TelaAcompanhar> {
  final MenuDosBotoes menuDosBotoes = MenuDosBotoes();

  @override
  void initState() {
    super.initState();
    widget.usuario.addListener(() => setState(() {}));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsLevv.FUNDO_400,
        appBar: AppBar(
          title: const Text("Acompanhar um produto"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  //botões
                  menuDosBotoes,
                  FutureBuilder<List<Pedido>>(
                    future: _buscarListaDePedidoDoUsuario(),
                    builder: (context, snapshot) {
                      List<Pedido> lista = [];
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
                            lista = snapshot.data!;
                            print("sucess ao carregar dados!");
                          }
                          break;
                      }
                      //lista de pedidos
                      return ListagemDePedidos(
                        menuDosBotoes: menuDosBotoes,
                        usuario: widget.usuario,
                        pedidos: lista,
                      );
                    },
                  )
                ])),
          ),
        ));
  }

  Future<List<Pedido>> _buscarListaDePedidoDoUsuario() async {
    List<Pedido> pedidos = [];
    try {
      final pedidoDAO = PedidoDAO();
      pedidos = await pedidoDAO.buscarPedidosDoUsuario(usuario: widget.usuario);
    } catch (erro) {
      print("Erro ao buscar pedido para listar--> ${erro.toString()}");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Erro"),
              titlePadding: const EdgeInsets.all(20),
              titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
              content: const Text(
                  'Não foi possível buscar seus pedido!\nTente novamente!'),
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
