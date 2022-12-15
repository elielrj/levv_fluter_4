import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levv4/controller/entregar/tela_entregar_controller.dart';

import '../../api/firebase_autenticacao/autenticacao.dart';
import '../../model/bo/endereco/endereco.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../model/dao/pedido/pedido_dao.dart';
import '../../api/cor/colors_levv.dart';
import '../componentes/pedidos/lista/listagem_de_pedidos.dart';
import '../componentes/botoes/menu_dos_botoes.dart';

class TelaEntregar extends StatefulWidget {
  const TelaEntregar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaEntregar> createState() => _TelaEntregarState();
}

class _TelaEntregarState extends State<TelaEntregar> {
  final controller = TelaEntregarController();

  //2 - segundo
  Future<void> _buscarListaDePedidosDoUsuario() async {
    await controller.buscarListaDePedidosDoUsuario();
  }

  @override
  void initState() {
    super.initState();
    widget.usuario.perfil;
    // 1- primeiro
    _buscarListaDePedidosDoUsuario();
  }

  final List<bool> listaDeStatusDosBotoes = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsLevv.FUNDO_400,
        appBar: AppBar(
          title: const Text("Entregar um produto"),
        ),
        body: Container(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              //botões
              MenuDosBotoes(listaDeStatusDosBotoes: listaDeStatusDosBotoes),
              //lista de pedidos
              ListagemDePedidos(
                usuario: widget.usuario,
                listaDePedidosDoUsuario: controller.listaDePedidosDoUsuario,
                listaDeStatusDosBotoes: listaDeStatusDosBotoes,
              )
            ])));
  }
}
