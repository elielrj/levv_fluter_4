import 'package:flutter/material.dart';
import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';
import 'package:levv4/model/frontend/mask/masks_levv.dart';
import 'package:levv4/model/frontend/text_levv.dart';
import 'package:levv4/view/enviar/item_com_coleta_entrega.dart';

import '../../model/bo/endereco/endereco.dart';
import '../../model/bo/meio_de_transporte/carro.dart';
import '../../model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import '../../model/bo/pedido/pedido.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../model/dao/pedido/pedido_dao.dart';
import '../../model/frontend/colors_levv.dart';
import '../../model/frontend/image_levv.dart';

class TelaEnviar extends StatefulWidget {
    const TelaEnviar({Key? key, required this.usuario, required this.pedido}) : super(key: key);

  final Usuario usuario;
  final Pedido pedido;

  @override
  State<TelaEnviar> createState() => _TelaEnviarState();
}

class _TelaEnviarState extends State<TelaEnviar> {
  //final pedido = Pedido();
  final controllerValor = MasksLevv.moedaRealMask;
  bool limparControllers = false;

  @override
  void initState() {
    super.initState();
    controllerValor.textEditingController.addListener(() => setState(() {}));
    limparControllers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsLevv.FUNDO_400,
      appBar: AppBar(
        title: const Text(TextLevv.ENVIAR_UM_PRODUTO),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Image.asset(
                ImageLevv.LOGO_DO_APP_LEVV,
                width: 90,
              ),
            ),
            //1 Peso
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    TextLevv.PESO,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                      width: 90,
                      child: Card(
                        child: DropdownButton(
                          underline: Container(
                            color: Colors.brown,
                          ),
                          isExpanded: true,
                          value: widget.pedido.peso,
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child:
                                  Text("Até 1Kg", textAlign: TextAlign.center),
                            ),
                            DropdownMenuItem(
                              value: 5,
                              child:
                                  Text("Até 5Kg", textAlign: TextAlign.center),
                            ),
                            DropdownMenuItem(
                              value: 10,
                              child:
                                  Text("Até 10Kg", textAlign: TextAlign.center),
                            ),
                            DropdownMenuItem(
                              value: 15,
                              child:
                                  Text("Até 15Kg", textAlign: TextAlign.center),
                            ),
                            DropdownMenuItem(
                              value: 20,
                              child:
                                  Text("Até 20Kg", textAlign: TextAlign.center),
                            ),
                            DropdownMenuItem(
                              value: 25,
                              child:
                                  Text("Até 25Kg", textAlign: TextAlign.center),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              widget.pedido.peso = int.parse(value.toString());
                            });
                          },
                        ),
                      ))
                ],
              ),
            ),
            //2 Volume
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(TextLevv.VOLUME, style: TextStyle(fontSize: 16)),
                SizedBox(
                  width: 90,
                  child: Card(
                    child: DropdownButton(
                      underline: Container(
                        color: Colors.brown,
                      ),
                      isExpanded: true,
                      value: widget.pedido.volume,
                      items: const [
                        DropdownMenuItem(
                          value: 20,
                          child: Text(
                            "20 x 20",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DropdownMenuItem(
                          value: 40,
                          child: Text("40 x 40", textAlign: TextAlign.center),
                        ),
                        DropdownMenuItem(
                          value: 60,
                          child: Text("60 x 60", textAlign: TextAlign.center),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          widget.pedido.volume = int.parse(value.toString());
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            //3 Meio de Transporte
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(TextLevv.MEIO_DE_TRANSPORTE,
                    style: TextStyle(fontSize: 16)),
                SizedBox(
                  width: 120,
                  child: Card(
                    child: DropdownButton(
                      underline: Container(
                        color: Colors.brown,
                      ),
                      isExpanded: true,
                      value: widget.pedido.transporte,
                      items: const [
                        DropdownMenuItem(
                          value: APe.VALUE,
                          child: Text("A pé", textAlign: TextAlign.center),
                        ),
                        DropdownMenuItem(
                          value: Bike.VALUE,
                          child: Text("Bike", textAlign: TextAlign.center),
                        ),
                        DropdownMenuItem(
                          value: Moto.VALUE,
                          child: Text("Moto", textAlign: TextAlign.center),
                        ),
                        DropdownMenuItem(
                          value: Carro.VALUE,
                          child: Text("Carro", textAlign: TextAlign.center),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          widget.pedido.transporte = int.parse(value.toString());
                        });
                      },
                    ),
                  ),
                )
              ],
            ),

            //4 Rota
            Column(
              children: [
                const Text(TextLevv.ROTA),
                //item do pedido
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int index = 0; index < widget.pedido.itensDoPedido!.length; index++)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ItemComColetaEntrega(
                              itemDoPedido: widget.pedido.itensDoPedido![index],
                              limparControllers: limparControllers,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //add item do pedido
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  color: Colors.white,
                                  onPressed: () {
                                    if (widget.pedido.itensDoPedido!.length < 10) {
                                      setState(() {

                                        ItemDoPedido itemDoPedido =
                                            ItemDoPedido(
                                                ordem: (widget.pedido.itensDoPedido!.length + 1),
                                                coleta: Endereco(),
                                                entrega: Endereco());



                                        widget.pedido.itensDoPedido!.insert(index + 1,itemDoPedido);
                                        print("indice add: $index");

                                        int reordenar = 0;

                                        widget.pedido
                                            .itensDoPedido!
                                            .forEach(
                                                (itemDoPedido) {
                                              itemDoPedido.ordem = ++reordenar;
                                            });


                                      });

                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context){
                                            return AlertDialog(
                                              title: const Text("Erro ao adicionar item do pedido"),
                                              titlePadding: const EdgeInsets.all(20),
                                              titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
                                              content: const Text(
                                                  "Não é possível adicionar mais de 10 itens no pedido"
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: const Text("Ok"))
                                              ],
                                            );
                                          }
                                      );
                                    }
                                  },
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  iconSize: 25,
                                ),
                                //remove item do pedido
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  color: Colors.red,
                                  onPressed: () {
                                    if (widget.pedido.itensDoPedido!.length > 1) {
                                      setState(() {
                                        widget.pedido.itensDoPedido!.removeAt(index);

                                        print("indice add: $index");

                                        int reordenar = 0;

                                        widget.pedido
                                            .itensDoPedido!
                                            .forEach(
                                                (itemDoPedido) {
                                                  itemDoPedido.ordem = ++reordenar;
                                        });

                                      });
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context){
                                            return AlertDialog(
                                              title: const Text("Erro ao excluir item do pedido"),
                                              titlePadding: const EdgeInsets.all(20),
                                              titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
                                              content: const Text(
                                                  "Não é possível excluir o último item!\n"
                                                  "É necessário ter pelo menos 1 item!\n"
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: const Text("Ok"))
                                              ],
                                            );
                                          }
                                      );
                                    }
                                  },
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  iconSize: 25,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                  ],
                )
              ],
            ),

            // Valor
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("VALOR"),
                TextField(
                  controller: controllerValor.textEditingController,
                  inputFormatters: [controllerValor.formatter],
                  enabled: false,
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(backgroundColor: Colors.white),
                      labelText: "R\$ 0.00",
                      prefixIcon: Icon(Icons.monetization_on),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ],
            ),
            //Botão
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      textStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
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
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      textStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(180, 65),
                      elevation: 2,
                      primary: Colors.black,
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.pedido.limparPedido();
                        limparControllers = true;
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
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

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
