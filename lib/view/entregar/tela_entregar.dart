import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  final pedidoDAO = PedidoDAO();

  var listaDePedidosDoUsuario;

  final autenticacao = Autenticacao();

  //4 - quarto
  Future<User> _buscarUsuarioCorrente() async {
    return await autenticacao.auth.currentUser!;
  }


  //3 - terceiro
  _buscarNumeroDeTelefoneDoUsuario() async {
    return autenticacao.nomeDoDocumentoDoUsuarioCorrente(await _buscarUsuarioCorrente());
  }

  //2 - segundo
  _buscarListaDePedidosDoUsuario() async {
    listaDePedidosDoUsuario = await pedidoDAO
        .buscarPedidosDoUsuario(_buscarNumeroDeTelefoneDoUsuario());
  }

  @override
  void initState() {
    super.initState();

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
                listaDePedidosDoUsuario: listaDePedidosDoUsuario,
                listaDeStatusDosBotoes: listaDeStatusDosBotoes,
              )
            ])));
  }
}
