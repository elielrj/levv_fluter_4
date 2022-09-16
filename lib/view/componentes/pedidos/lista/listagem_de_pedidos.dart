import 'package:flutter/material.dart';
import '../../../../model/bo/usuario/usuario.dart';
import 'lista_com_detahes_dos_pedidos.dart';

class ListagemDePedidos extends StatefulWidget {
  ListagemDePedidos(
      {Key? key,
      required this.listaDeStatusDosBotoes,
      required this.usuario,
      required this.listaDePedidosDoUsuario})
      : super(key: key);

  final List<bool> listaDeStatusDosBotoes;
  final Usuario usuario;
  var listaDePedidosDoUsuario;

  @override
  State<ListagemDePedidos> createState() => _ListagemDePedidosState();
}

class _ListagemDePedidosState extends State<ListagemDePedidos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.only(top: 16,bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_pedidos()],
        ),
      ),
    );
  }

  Widget _pedidos() {
    return widget.listaDePedidosDoUsuario == null
        ? _listaVazia()
        : _listaComDetalhesDosPedidos();
  }

  _listaVazia() => const Text(
        "Não há pedidos para seu usuário!",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontStyle: FontStyle.italic),
      );

  _listaComDetalhesDosPedidos() => Padding(
    padding: const EdgeInsets.only(top: 5),
    child: ListaComDetalhesDosPedidos(
          usuario: widget.usuario,
          pedidos: widget.listaDePedidosDoUsuario,
          listaDeStatusDosBotoes: widget.listaDeStatusDosBotoes,
        ),
  );
}
