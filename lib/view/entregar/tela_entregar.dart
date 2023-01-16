import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:levv4/controller/menu_botoes_controller/menu_botoes_controller.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/view/localizar/localizar/localizar.dart';
import '../../model/bo/endereco/endereco.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../model/dao/pedido/pedido_dao.dart';
import '../../api/cor/colors_levv.dart';
import '../listagem_de_pedidos/listagem_de_pedidos.dart';
import '../componentes/menu_dos_botoes/menu_dos_botoes.dart';

class TelaEntregar extends StatefulWidget {
  const TelaEntregar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaEntregar> createState() => _TelaEntregarState();
}

class _TelaEntregarState extends State<TelaEntregar> {
  final MenuBotoesController menuDosBotoesController = MenuBotoesController();

  Endereco? endereco;

  @override
  void initState() {
    super.initState();
    widget.usuario.addListener(() => setState(() {}));
    menuDosBotoesController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsLevv.FUNDO_400,
        appBar: AppBar(
          title: const Text("Entregar um pedido"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  //menuDosBotoes,
                  MenuDosBotoes(menuBotoesController: menuDosBotoesController),
                  FutureBuilder<List<Pedido>>(
                      future: _buscarListaDePedidosNaCidadeAtualDoEntregador(),
                      builder: (context, snapshot) {
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
                              if(widget.usuario.listaDePedidos == null){
                                widget.usuario.listaDePedidos = snapshot.data!;


                              }else{
                                if(snapshot.data != null){
                                  widget.usuario.listaDePedidos = snapshot.data!;
                                }
                                //widget.usuario.listaDePedidos!.addAll(snapshot.data!);
                              }

                              print("sucess ao carregar dados! ${snapshot.data!.length.toString()}");
                            }
                            break;
                        }

                        return ListagemDePedidos(
                          menuBotoesController: menuDosBotoesController,
                          usuario: widget.usuario,
                        );
                      }),
                ])),
          ),
        ));
  }

  Future<List<Pedido>> _buscarListaDePedidosNaCidadeAtualDoEntregador() async {
    List<Pedido> pedidos = [];
    try {
      endereco ?? await _buscarLocalizacaoAtual();

      if (endereco != null) {
        final pedidoDAO = PedidoDAO();

        pedidos = await pedidoDAO.buscarPedidosPorCidade(endereco!.cidade!,
            usuario: widget.usuario);
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

  Future<void> _buscarLocalizacaoAtual() async {
    try {
      final localizar = Localizar();
      Position? position = await localizar.determinarPosicao();
      endereco = await localizar.converterPositionEmEndereco(position);
      print("Busca de endereço com sucesso: ${endereco!.cidade}");
    } catch (erro) {
      print("Busca de endereço sem sucesso!");
    }
  }
}
