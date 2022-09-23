import 'package:flutter/material.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';

import '../../model/dao/pedido/pedido_dao.dart';

class PedidoBotoes extends StatefulWidget {
  PedidoBotoes(
      {Key? key, required this.pedido, required this.limparControllers})
      : super(key: key);

  final Pedido pedido;
  bool limparControllers;

  @override
  State<PedidoBotoes> createState() => _PedidoBotoesState();
}

class _PedidoBotoesState extends State<PedidoBotoes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _enviar(),
          _limpar(),
        ],
      ),
    );
  }

  Widget _limpar() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.all(0),
          minimumSize: const Size(180, 65),
          elevation: 2,
          primary: Colors.black,
          alignment: Alignment.center,
        ),
        onPressed: () {
          setState(() {
            widget.pedido.limparPedido();
            widget.limparControllers = true;
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              widthFactor: 1,
              child: Image.asset(
                "imagens/icon_trash.png",
                width: 20,
                height: 20,
              ),
            ),
            const Center(
              widthFactor: 2,
              child: Text("Limpar"),
            ),
          ],
        ),
      );

  Widget _enviar() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.all(0),
          minimumSize: const Size(180, 65),
          elevation: 2,
          primary: Colors.black,
          alignment: Alignment.center,
        ),
        onPressed: () {
          //todo enviar campos de um pedido//
          _enviarPedido();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              widthFactor: 1,
              child: Image.asset(
                "imagens/icon_register.png",
                width: 20,
                height: 20,
              ),
            ),
            const Center(
              widthFactor: 2,
              child: Text("Enviar"),
            ),
          ],
        ),
      );

  //2
  _enviarPedido() async {
    if (await _criarPedido()) {
      //todo msg erro
    } else {
      //todo mssg erro
    }
  }

  //3
  Future<bool> _criarPedido() async {
    try {
      final pedidoDAO = PedidoDAO();
      pedidoDAO.create(widget.pedido);
      return true;
    } catch (e) {
      return false;
    }
  }
}
