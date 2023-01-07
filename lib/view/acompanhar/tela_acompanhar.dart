import 'package:flutter/material.dart';
import 'package:levv4/controller/acompanhar/tela_acompanhar_controller.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../api/cor/colors_levv.dart';
import '../componentes/pedidos/lista/listagem_de_pedidos.dart';
import '../componentes/botoes/menu_dos_botoes.dart';

class TelaAcompanhar extends StatefulWidget {
  const TelaAcompanhar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaAcompanhar> createState() => _TelaAcompanharState();
}

class _TelaAcompanharState extends State<TelaAcompanhar> {
  final controller = TelaAcompanharController();

  Future<void> _buscarListaDePedidosDoUsuario() async {
    await controller.buscarListaDePedidosDoUsuario();
  }

  @override
  void initState() {
    super.initState();
    _buscarListaDePedidosDoUsuario();
  }

  final List<bool> listaDeStatusDosBotoes = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsLevv.FUNDO_400,
        appBar: AppBar(
          title: const Text("Acompanhar um produto"),
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
