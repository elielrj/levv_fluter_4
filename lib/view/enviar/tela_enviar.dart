import 'package:flutter/material.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/view/enviar/botao/pedido_botoes.dart';
import 'package:levv4/view/enviar/rota/pedido_rota.dart';
import 'package:levv4/view/enviar/valor/pedido_valor.dart';
import 'package:levv4/view/enviar/meio_de_transporte/pedido_veiculo.dart';
import 'package:levv4/view/enviar/peso/pedido_peso.dart';
import '../../api/mascara/formatter_valor_em_real.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../api/cor/colors_levv.dart';
import '../componentes/logo/widget_logo_levv.dart';
import 'volume/pedido_volume.dart';

class TelaEnviar extends StatefulWidget {
  const TelaEnviar({Key? key,
    required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaEnviar> createState() => _TelaEnviarState();
}

class _TelaEnviarState extends State<TelaEnviar> {
  final controllerValor = Mask(formatter: FormatterValorEmReal());
  bool limparControllers = false;

  Pedido pedido = Pedido();

  @override
  void initState() {
    super.initState();
    controllerValor.textEditingController
        .addListener(() => setState(() {}));
    limparControllers;
    widget.usuario.perfil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsLevv.FUNDO_400,
      appBar: AppBar(
        title: const Text(TextLevv.ENVIAR_UM_PRODUTO),
      ),
      body: Container(
        padding: const EdgeInsets
            .only(left: 8, right: 8, top: 16, bottom: 8),
        child: SingleChildScrollView(
          child: Column(children: [
            ///Logo Levv
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: logoLevv(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///1 Peso
                PedidoPeso(pedido: pedido),

                ///2 Volume
                PedidoVolume(pedido: pedido),

                ///3 Meio de Transporte
                PedidoVeiculo(pedido: pedido),
              ],
            ),

            ///4 Rota
            PedidoRota(
              pedido: pedido,
              limparControllers: limparControllers,
            ),

            /// Valor
            PedidoValor(controllerValor: controllerValor),

            ///Botão
            PedidoBotoes(
                pedido: pedido,
                limparControllers: limparControllers,
            ),
          ]),
        ),
      ),
    );
  }
}
