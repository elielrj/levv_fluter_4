import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levv4/model/backend/firebase/auth/document_name_current_user.dart';
import 'package:levv4/model/backend/firebase/auth/firebase_auth.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../model/dao/pedido/pedido_dao.dart';
import '../../model/frontend/colors_levv.dart';
import '../componentes/pedidos/lista/listagem_de_pedidos.dart';
import '../componentes/botoes/menu_dos_botoes.dart';

class TelaAcompanhar extends StatefulWidget {
  const TelaAcompanhar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaAcompanhar> createState() => _TelaAcompanharState();
}

class _TelaAcompanharState extends State<TelaAcompanhar>
    with DocumentNameCurrentUser {
  final pedidoDAO = PedidoDAO();

  var listaDePedidosDoUsuario;

  final autenticacao = Autenticacao(FirebaseAuth.instance);

  Future<User> _buscarUsuarioCorrente() async {
    return await autenticacao.auth.currentUser!;
  }

  _buscarNumeroDeTelefoneDoUsuario() async {
    return name(await _buscarUsuarioCorrente());
  }

  _buscarListaDePedidosDoUsuario() async {
    listaDePedidosDoUsuario = await pedidoDAO
        .buscarPedidosDoUsuario(_buscarNumeroDeTelefoneDoUsuario());
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
                listaDePedidosDoUsuario: listaDePedidosDoUsuario,
                listaDeStatusDosBotoes: listaDeStatusDosBotoes,
              )
            ])));
  }
}
