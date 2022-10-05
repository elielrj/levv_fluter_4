import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:levv4/model/backend/firebase/auth/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/backend/firebase/auth/autenticacao.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../model/dao/pedido/pedido_dao.dart';
import '../../api/cor/colors_levv.dart';
import '../componentes/pedidos/lista/listagem_de_pedidos.dart';
import '../componentes/botoes/menu_dos_botoes.dart';

class TelaAcompanhar extends StatefulWidget {
  const TelaAcompanhar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaAcompanhar> createState() => _TelaAcompanharState();
}

class _TelaAcompanharState extends State<TelaAcompanhar>
    with NomeDoDocumentoDoUsuarioCorrente {
  final pedidoDAO = PedidoDAO();

  var listaDePedidosDoUsuario;

  final autenticacao = Autenticacao();

  Future<User> _buscarUsuarioCorrente() async {
    return await autenticacao.auth.currentUser!;
  }

  _buscarNumeroDeTelefoneDoUsuario() async {
    return nomeDoDocumentoDoUsuarioCorrente(await _buscarUsuarioCorrente());
  }

  _buscarListaDePedidosDoUsuario() async {

    try{

      listaDePedidosDoUsuario = await pedidoDAO
          .buscarPedidosDoUsuario(await _buscarNumeroDeTelefoneDoUsuario());

    }catch(error){
      print("Erro ao buscar pedidos do usuário!");
    }

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
