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
          title: const Text("Entregar um produto"),
        ),
        body: Container(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              menuDosBotoes,
              FutureBuilder<List<Pedido>>(
                  future: _buscarListaDePedidosNaCidadeAtualDoEntregador(),
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
                        }
                        break;
                    }
                    //lista de pedidos
                    return ListagemDePedidos(
                      menuDosBotoes: menuDosBotoes,
                      usuario: widget.usuario,
                      pedidos: lista,
                    );
                  }),
            ])));
  }

  Future<List<Pedido>> _buscarListaDePedidosNaCidadeAtualDoEntregador() async {
    List<Pedido> pedidos = [];
    try {
      final localizar = Localizar();
      Position? position = await localizar.determinarPosicao();
      Endereco? endereco =
          await localizar.converterPositionEmEndereco(position);

      if (endereco != null) {
        final pedidoDAO = PedidoDAO();
        pedidos = await pedidoDAO.buscarPedidosPorCidade(endereco.cidade!);
      } else {
        print("Erro ao buscar endereço!");
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Erro"),
                titlePadding: const EdgeInsets.all(20),
                titleTextStyle:
                    const TextStyle(fontSize: 20, color: Colors.red),
                content: const Text(
                    'Não foi possível buscar obter sua localização para obter pedidos disponíveis!\nTente novamente!'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Ok")),
                ],
              );
            });
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
    return pedidos;
  }
}
