import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/view/localizar/localizar/localizar.dart';
import '../../model/bo/endereco/endereco.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../model/dao/pedido/pedido_dao.dart';
import '../../api/cor/colors_levv.dart';
import '../listagem_de_pedidos/listagem_de_pedidos.dart';
import '../componentes/botoes/menu_dos_botoes.dart';

class TelaEntregar extends StatefulWidget {
  const TelaEntregar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaEntregar> createState() => _TelaEntregarState();
}

class _TelaEntregarState extends State<TelaEntregar> {
  final MenuDosBotoes menuDosBotoes = MenuDosBotoes();

  List<Pedido> pedidos = [];

  @override
  void initState() {
    super.initState();
    pedidos;
    _buscarListaDePedidosNaCidadeAtualDoEntregador();
  }

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
              menuDosBotoes,
              //lista de pedidos
              ListagemDePedidos(
                menuDosBotoes: menuDosBotoes,
                usuario: widget.usuario,
                pedidos: pedidos,
              )
            ])));
  }

  Future<void> _buscarListaDePedidosNaCidadeAtualDoEntregador() async {
    try {
      final localizar = Localizar();
      Position? position = await localizar.determinarPosicao();
      Endereco? endereco =
          await localizar.converterPositionEmEndereco(position);

      if (endereco != null) {
        final pedidoDAO = PedidoDAO();
        pedidos = await pedidoDAO.buscarPedidosPorCidade(endereco.cidade!);
      }
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
  }
}
