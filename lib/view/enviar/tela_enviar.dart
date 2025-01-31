import 'package:flutter/material.dart';
import 'package:levv4/biblioteca/criador_de_pedido.dart';
import 'package:levv4/biblioteca/imagem/image_levv.dart';
import 'package:levv4/biblioteca/texto/text_levv.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/biblioteca/cor/colors_levv.dart';
import 'package:levv4/view/home/tela_home.dart';
import '../componentes/logo/widget_logo_levv.dart';
import 'rota_do_pedido.dart';
import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';
import 'package:levv4/model/bo/meio_de_transporte/carro.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';

class TelaEnviar extends StatefulWidget {
  const TelaEnviar({Key? key, required this.usuario})
      : super(key: key);

  final Usuario usuario;


  @override
  State<TelaEnviar> createState() => _TelaEnviarState();
}

class _TelaEnviarState extends State<TelaEnviar> {
  final criadorDePedido = CriadorDePedido();

  @override
  void initState() {
    super.initState();
    criadorDePedido.addListener(() => setState(() {}));
    criadorDePedido.controllerValorPedido.textEditingController
        .addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FUNDO_400,
      appBar: AppBar(
        title: const Text(TextLevv.ENVIAR_UM_PEDIDO),
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

            RotaDoPedido(criadorDePedido: criadorDePedido),

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
    final List<int> valoresDosPesos = [0, 1, 2, 3, 4, 5];
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
                    setState(() {
                      criadorDePedido
                          .novoPesoDoPedido(int.parse(value.toString()));
                    });
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
    List<int> listaDeValoresDosTamanhosDosVolumes = [0, 1, 2];
    List<String> listaTamanhoDeVolumes = ["20 x 20", "40 x 40", "60 x 60"];

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
              onChanged: (value) {
                setState(() {
                  criadorDePedido
                      .novoVolumeDoPedido(int.parse(value.toString()));
                });
              },
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
                setState(() {
                  criadorDePedido
                      .novoMeioDeTransporte(int.parse(value.toString()));
                });
              },
            ),
          ),
        )
      ],
    );
  }

  ///4 Rota
  ///

  /// Valor do pedido_old
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
          try {
            criadorDePedido.pedidoEstaCompleto()
                ? await criadorDePedido.enviarPedido(usuario: widget.usuario)
                : _exibirMensagemDeCampoVazio();

            print("Pedido enviado com sucesso!");

            _navegarParaTelaHome();
          } catch (erro) {
            print("erro ao Enviar Pedido: ${erro.toString()}");
          }
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
          criadorDePedido.limparPedido();
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

  void _navegarParaTelaHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaHome(usuario: widget.usuario)));
  }
}
