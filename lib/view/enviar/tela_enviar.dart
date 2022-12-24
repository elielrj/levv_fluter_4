import 'package:flutter/material.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/view/enviar/botao_enviar_do_pedido.dart';
import 'package:levv4/view/enviar/botao_limpar_do_pedido.dart';
import 'package:levv4/view/enviar/meio_de_transporte_do_pedido.dart';
import 'package:levv4/view/enviar/peso_do_pedido.dart';
import 'package:levv4/view/enviar/rota_do_pedido.dart';
import 'package:levv4/view/enviar/valor_do_pedido.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/api/cor/colors_levv.dart';
import '../componentes/logo/widget_logo_levv.dart';
import 'volume_do_pedido.dart';

class TelaEnviar extends StatefulWidget {
  const TelaEnviar({Key? key, required this.usuario}) : super(key: key);

  final Usuario usuario;

  @override
  State<TelaEnviar> createState() => _TelaEnviarState();
}

class _TelaEnviarState extends State<TelaEnviar> {
  final Pedido pedido = Pedido();

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
                PesoDoPedido(pedido: pedido),

                ///2 Volume
                VolumeDoPedido(pedido: pedido),

                ///3 Meio de Transporte
                MeioDeTransporteDoPedido(pedido: pedido),
              ],
            ),

            ///4 Rota
            RotaDoPedido(pedido: pedido),

            /// Valor
            ValorDoPedido(pedido: pedido),

            ///Botões
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BotaoEnviarDoPedido(pedido: pedido),
                  BotaoLimparDoPedido(pedido: pedido),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
