import 'package:flutter/material.dart';
import 'package:levv4/model/frontend/text_levv.dart';
import 'package:levv4/view/entregar/item_com_coleta_entrega.dart';

import '../../model/bo/endereco/endereco.dart';
import '../../model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import '../../model/bo/pedido/pedido.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../model/dao/pedido/pedido_dao.dart';
import '../../model/frontend/colors_levv.dart';
import '../../model/frontend/image_levv.dart';

class TelaEnviar extends StatefulWidget {
  const TelaEnviar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaEnviar> createState() => _TelaEnviarState();
}

class _TelaEnviarState extends State<TelaEnviar> {
  final _pedido = Pedido();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsLevv.FUNDO,
      appBar: AppBar(
        title: const Text(TextLevv.ENVIAR_UM_PRODUTO),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32, top: 16, right: 8, left: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Image.asset(
                ImageLevv.LOGO_DO_APP_LEVV,
                width: 90,
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //1 Peso
                  Column(
                    mainAxisSize: MainAxisSize.max,
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
                              value: _pedido.peso ?? 1,
                              items: const [
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text("Até 1Kg",
                                      textAlign: TextAlign.center),
                                ),
                                DropdownMenuItem(
                                  value: 5,
                                  child: Text("Até 5Kg",
                                      textAlign: TextAlign.center),
                                ),
                                DropdownMenuItem(
                                  value: 10,
                                  child: Text("Até 10Kg",
                                      textAlign: TextAlign.center),
                                ),
                                DropdownMenuItem(
                                  value: 15,
                                  child: Text("Até 15Kg",
                                      textAlign: TextAlign.center),
                                ),
                                DropdownMenuItem(
                                  value: 20,
                                  child: Text("Até 20Kg",
                                      textAlign: TextAlign.center),
                                ),
                                DropdownMenuItem(
                                  value: 25,
                                  child: Text("Até 25Kg",
                                      textAlign: TextAlign.center),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _pedido.peso = int.parse(value.toString());
                                });
                              },
                            ),
                          ))
                    ],
                  ),
                  //2 Volume
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(TextLevv.VOLUME,
                          style: TextStyle(fontSize: 16)),
                      SizedBox(
                        width: 90,
                        child: Card(
                          child: DropdownButton(
                            underline: Container(
                              color: Colors.brown,
                            ),
                            isExpanded: true,
                            value: _pedido.volume ?? 0,
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text(
                                  "20 x 20",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text("40 x 40",
                                    textAlign: TextAlign.center),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text("60 x 60",
                                    textAlign: TextAlign.center),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _pedido.volume = int.parse(value.toString());
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
                            //todo meio de trnsporte em pedido??
                            value: 0,
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child:
                                    Text("A pé", textAlign: TextAlign.center),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child:
                                    Text("Bike", textAlign: TextAlign.center),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child:
                                    Text("Moto", textAlign: TextAlign.center),
                              ),
                              DropdownMenuItem(
                                value: 3,
                                child:
                                    Text("Carro", textAlign: TextAlign.center),
                              ),
                            ],
                            //todo meio de transporte dentro do obj pedido
                            onChanged: (value) => 1,
                          ),
                        ),
                      )
                    ],
                  ),
                  //4 Rota
                  Column(
                    children: [
                      const Text(TextLevv.ROTA),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int index = 0;
                              index < _pedido.itensDoPedido!.length;
                              index++)
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 4.0, bottom: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ItemComColetaEntrega(
                                      itemDoPedido:
                                          _pedido.itensDoPedido![index]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        color: Colors.white,
                                        onPressed: () {
                                          if (_pedido.itensDoPedido!.length <
                                              10) {
                                            setState(() {
                                              int total = _pedido
                                                      .itensDoPedido!.length +
                                                  1;

                                              ItemDoPedido itemDoPedido =
                                                  ItemDoPedido(
                                                      ordem: total,
                                                      coleta: Endereco(),
                                                      entrega: Endereco());

                                              //todo reparar probema de ordem identica
                                              itemDoPedido.ordem = _pedido
                                                      .itensDoPedido!.length +
                                                  1;

                                              _pedido.itensDoPedido!
                                                  .add(itemDoPedido);
                                            });
                                          } else {
                                            //todo msg erro;
                                          }
                                        },
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        iconSize: 25,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        color: Colors.red,
                                        onPressed: () {
                                          if (_pedido.itensDoPedido!.length >
                                              1) {
                                            setState(() {
                                              _pedido.itensDoPedido!
                                                  .removeAt(index);
                                            });
                                          } else {
                                            //todo msg erro
                                          }
                                        },
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
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
                    children: const [
                      Text("VALOR"),
                      TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            labelStyle:
                                TextStyle(backgroundColor: Colors.white),
                            labelText: "R\$ 0.0",
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
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 18),
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
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            padding: const EdgeInsets.all(0),
                            minimumSize: const Size(180, 65),
                            elevation: 2,
                            primary: Colors.black,
                            alignment: Alignment.center,
                          ),
                          onPressed: () {
                            _pedido.limparPedido();
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
                ],
              ),
            ),
          ],
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
      pedidoDAO.create(_pedido);
      return true;
    } catch (e) {
      return false;
    }
  }
}
