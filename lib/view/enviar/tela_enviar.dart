import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:levv4/api/criador_de_pedido.dart';
import 'package:levv4/api/imagem/image_levv.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/controller/enviar/item_da_rota_do_pedido_controller.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import 'package:levv4/view/enviar/mapa_do_item_do_pedido.dart';
import 'package:levv4/view/enviar/meio_de_transporte_do_pedido.dart';
import 'package:levv4/view/enviar/peso_do_pedido.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/api/cor/colors_levv.dart';
import 'package:levv4/view/localizar/localizar/localizar.dart';
import '../componentes/logo/widget_logo_levv.dart';
import 'volume_do_pedido.dart';
import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';
import 'package:levv4/model/bo/meio_de_transporte/carro.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';

class TelaEnviar extends StatefulWidget {
  const TelaEnviar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaEnviar> createState() => _TelaEnviarState();
}

class _TelaEnviarState extends State<TelaEnviar> {
  final criadorDePedido = CriadorDePedido();

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
            ///Logo Levv
            WidgetLogoLevv(bottom: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///1 Peso
                _pesoDoPedido(),

                ///2 Volume
                _volumeDoPedido(),

                ///3 Meio de Transporte
                _meioDeTransporteDoPedido(),
              ],
            ),

            ///4 Rota
            _rotaDoPedido(),

            /// Valor
            _valorDoPedido(),

            ///Botões
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _botaoEnviarDoPedido(),
                  _botaoLimparDoPedido(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  ///1 Peso
  ///
  Widget _pesoDoPedido() {
    final List<int> valoresDosPesos = [1, 5, 10, 15, 20, 25];
    final List<String> textosDosPesos = [
      "Até 1Kg",
      "Até 5Kg",
      "Até 10Kg",
      "Até 15Kg",
      "Até 20Kg",
      "Até 25Kg"
    ];

    return Container(
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
                  value: criadorDePedido.pesoDoPedido(),
                  items: [
                    for (int index = 0; index < valoresDosPesos.length; index++)
                      DropdownMenuItem(
                        value: valoresDosPesos[index],
                        child: Text(textosDosPesos[index],
                            textAlign: TextAlign.center),
                      ),
                  ],
                  onChanged: (value) {
                    criadorDePedido
                        .novoPesoDoPedido(int.parse(value.toString()));
                  },
                ),
              ))
        ],
      ),
    );
  }

  ///2 Volume
  ///
  Widget _volumeDoPedido() {
    List<String> listaTamanhoDeVolumes = ["20 x 20", "40 x 40", "60 x 60"];
    List<int> listaDeValoresDosTamanhosDosVolumes = [20, 40, 60];

    return Column(
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
              value: criadorDePedido.volumeDoPedido(),
              items: [
                for (int index = 0;
                    index < listaTamanhoDeVolumes.length;
                    index++)
                  DropdownMenuItem(
                    value: listaDeValoresDosTamanhosDosVolumes[index],
                    child: Text(
                      listaTamanhoDeVolumes[index],
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
              onChanged: (value) =>
                  criadorDePedido.novoPesoDoPedido(int.parse(value.toString())),
            ),
          ),
        ),
      ],
    );
  }

  ///3 Meio de Transporte
  ///
  Widget _meioDeTransporteDoPedido() {
    List<int> valoresDosVeiculos = [
      APe.VALUE,
      Bike.VALUE,
      Moto.VALUE,
      Carro.VALUE
    ];

    List<String> textDosVeiculos = ["A pé", "Bike", "Moto", "Carro"];

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(TextLevv.MEIO_DE_TRANSPORTE, style: TextStyle(fontSize: 16)),
        SizedBox(
          width: 120,
          child: Card(
            child: DropdownButton(
              underline: Container(
                color: Colors.brown,
              ),
              isExpanded: true,
              value: criadorDePedido.meioDeTransporte(),
              items: [
                for (int index = 0; index < valoresDosVeiculos.length; index++)
                  DropdownMenuItem(
                    value: valoresDosVeiculos[index],
                    child: Text(textDosVeiculos[index],
                        textAlign: TextAlign.center),
                  ),
              ],
              onChanged: (value) {
                criadorDePedido
                    .novoMeioDeTransporte(int.parse(value.toString()));
              },
            ),
          ),
        )
      ],
    );
  }

  ///4 Rota
  ///
  Widget _rotaDoPedido() => Column(
        children: [
          const Text(TextLevv.ROTA),
          //item do pedido
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int index = 0;
                  index < criadorDePedido.itensDoPedido.length;
                  index++)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// item do pedido
                      Card(
                        child: Column(
                          children: [
                            /// Campo Etiqueta c/ Nr de cada item
                            Text(
                              "Item: ${criadorDePedido.itensDoPedido[index].ordem.toString()}",
                              style: const TextStyle(
                                fontSize: 10,
                                backgroundColor: Colors.white70,
                              ),
                            ),

                            /// Campo Coleta
                            _itemDaRotaDoPedido(
                                itemDoPedido:
                                    criadorDePedido.itensDoPedido[index],
                                labelText: TextLevv.ENDERECO_COLETA),

                            /// Campo Entrega
                            _itemDaRotaDoPedido(
                                itemDoPedido:
                                    criadorDePedido.itensDoPedido[index],
                                labelText: TextLevv.ENDERECO_ENTREGA),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //add item do pedido
                          _adicionarItem(index),
                          //remove item do pedido
                          _removerItem(index),
                        ],
                      )
                    ],
                  ),
                ),
            ],
          )
        ],
      );

  Widget _removerItem(int index) => IconButton(
        icon: const Icon(Icons.remove),
        color: Colors.red,
        onPressed: () {
          if (criadorDePedido.itensDoPedido.length > 1) {
            setState(() {
              criadorDePedido.itensDoPedido.removeAt(index);

              print("indice add: $index");

              int reordenar = 0;

              criadorDePedido.itensDoPedido.forEach((itemDoPedido) {
                itemDoPedido.ordem = ++reordenar;
              });
            });
            criadorDePedido.calcularValorDoPedido();
          } else {
            _erroAoRemoverItem();
          }
        },
        padding: const EdgeInsets.only(left: 8, right: 8),
        iconSize: 25,
      );

  Widget _adicionarItem(int index) => IconButton(
        icon: const Icon(Icons.add),
        color: Colors.white,
        onPressed: () {
          if (criadorDePedido.itensDoPedido.length < 10) {
            setState(() {
              ItemDoPedido itemDoPedido = ItemDoPedido(
                  ordem: (criadorDePedido.itensDoPedido.length + 1),
                  coleta: Endereco(),
                  entrega: Endereco());

              criadorDePedido.itensDoPedido.insert(index + 1, itemDoPedido);
              print("indice add: $index");

              int reordenar = 0;

              criadorDePedido.itensDoPedido.forEach((itemDoPedido) {
                itemDoPedido.ordem = ++reordenar;
              });
            });
          } else {
            _erroAoAdicionarItem();
          }
        },
        padding: const EdgeInsets.only(left: 8, right: 8),
        iconSize: 25,
      );

  /// ItemDaRotaDoPedido: Campo Coleta e Entrega
  ///
  Widget _itemDaRotaDoPedido(
      {required ItemDoPedido itemDoPedido, required String labelText}) {
    final itemDaRotaDoPedidoController = ItemDaRotaDoPedidoController();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: itemDaRotaDoPedidoController.textEditingController,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    labelStyle: const TextStyle(
                        backgroundColor: Colors.white, color: Colors.blue),
                    labelText: labelText,
                    prefixIcon: const Icon(
                      Icons.account_box,
                      color: Colors.black38,
                    ),
                    suffixIcon: itemDaRotaDoPedidoController
                            .textEditingController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            onPressed: () => itemDaRotaDoPedidoController
                                .textEditingController
                                .clear(),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.redAccent,
                            )),
                    fillColor: Colors.white,
                    filled: true),
                onChanged: (text) => _buscarSugestaoDeEndereco(text),
              ),
            ),
            Column(children: [
              IconButton(
                icon: const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                ),
                color: Colors.black,
                onPressed: () => _buscarLocalizacao(labelText, itemDoPedido,
                    itemDaRotaDoPedidoController.textEditingController),
              ),
              IconButton(
                icon: const Icon(
                  Icons.map,
                  size: 20,
                ),
                color: Colors.black,
                onPressed: () {
                  setState(() => itemDaRotaDoPedidoController
                      .trocarStatusDeVisualizacaoDeMapa());
                },
              )
            ])
          ],
        ),
        Row(
          children: [
            Expanded(
              child: itemDaRotaDoPedidoController.isShowMap
                  ? Column(
                      children: [
                        Container(
                            color: Colors.white,
                            //width: double.infinity,
                            height: 300,
                            child: MapaDoItemDoPedido(
                                itemDoPedido: itemDoPedido,
                                labelText: labelText,
                                itemDaRotaDoPedidoController:
                                    itemDaRotaDoPedidoController,
                                criadorDePedido: criadorDePedido))
                      ],
                    )
                  : Container(width: 0),
            )
          ],
        )
      ],
    );
  }

  /// Valor do pedido
  ///
  Widget _valorDoPedido() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(TextLevv.VALOR),
          TextField(
            controller:
                criadorDePedido.controllerValorPedido.textEditingController,
            inputFormatters: [
              criadorDePedido.controllerValorPedido.formatter
                  .getMaskTextInputFormatter()
            ],
            enabled: false,
            decoration: InputDecoration(
                labelStyle: const TextStyle(backgroundColor: Colors.white),
                labelText:
                    criadorDePedido.controllerValorPedido.formatter.getHint(),
                prefixIcon: const Icon(Icons.monetization_on),
                fillColor: Colors.white,
                filled: true),
          ),
        ],
      );

  ///Botão Enviar
  ///
  Widget _botaoEnviarDoPedido() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.all(0),
          minimumSize: const Size(180, 65),
          elevation: 2,
          foregroundColor: Colors.black,
          alignment: Alignment.center,
        ),
        onPressed: () async {
          criadorDePedido.pedidoEstaCompleto()
              ? await criadorDePedido.enviarPedido()
              : _exibirMensagemDeCampoVazio();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              widthFactor: 1,
              child: Image.asset(
                ImageLevv.REGISTER,
                width: 20,
                height: 20,
              ),
            ),
            const Center(
              widthFactor: 2,
              child: Text(TextLevv.ENVIAR),
            ),
          ],
        ),
      );

  ///Botão Limpar
  ///
  Widget _botaoLimparDoPedido() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          textStyle: const TextStyle(color: Colors.black, fontSize: 18),
          padding: const EdgeInsets.all(0),
          minimumSize: const Size(180, 65),
          elevation: 2,
          foregroundColor: Colors.black,
          alignment: Alignment.center,
        ),
        onPressed: () {
          setState(() {
            criadorDePedido.limparPedido();
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              widthFactor: 1,
              child: Image.asset(
                ImageLevv.ICON_TRASH,
                width: 20,
                height: 20,
              ),
            ),
            const Center(
              widthFactor: 2,
              child: Text(TextLevv.LIMPAR),
            ),
          ],
        ),
      );

  _exibirMensagemDeCampoVazio() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(TextLevv.ERRO),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text(TextLevv.ERRO_PEDIDO_INCOMPLETO),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(TextLevv.OK))
            ],
          );
        });
  }

  _erroAoRemoverItem() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro ao excluir item do pedido"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text("Não é possível excluir o último item!\n"
                "É necessário ter pelo menos 1 item!\n"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"))
            ],
          );
        });
  }

  _erroAoAdicionarItem() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro ao adicionar item do pedido"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text(
                "Não é possível adicionar mais de 10 itens no pedido"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"))
            ],
          );
        });
  }

  _buscarSugestaoDeEndereco(String texto) {
    //todo buscar sugestão
    print('aqui');
  }

  Future<void> _buscarLocalizacao(String labelText, ItemDoPedido itemDoPedido,
      TextEditingController _controller) async {
    try {
      final localizar = Localizar();

      Position position = await localizar.determinarPosicao();

      Endereco? endereco =
          await localizar.converterPositionEmEndereco(position);

      if (labelText == TextLevv.ENDERECO_ENTREGA) {
        setState(() {
          itemDoPedido.entrega = endereco;
          _controller.text = itemDoPedido.entrega.toString();
        });
      } else {
        setState(() {
          itemDoPedido.coleta = endereco;
          _controller.text = itemDoPedido.coleta.toString();
        });
      }

      criadorDePedido.calcularValorDoPedido();
    } catch (error) {
      print('erro: ${error.toString()}');
      _erro();
    }
  }

  _erro() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro"),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.red),
            content: const Text("Não é possível buscar local do endereço!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok"))
            ],
          );
        });
  }
}
