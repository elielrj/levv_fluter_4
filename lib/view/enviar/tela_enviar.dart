import 'package:flutter/material.dart';
import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';
import 'package:levv4/model/frontend/mask/masks_levv.dart';
import 'package:levv4/model/frontend/text_levv.dart';
import 'package:levv4/view/enviar/pedido_botoes.dart';
import 'package:levv4/view/enviar/pedido_rota.dart';
import 'package:levv4/view/enviar/pedido_valor.dart';
import 'package:levv4/view/enviar/pedido_veiculo.dart';
import 'package:levv4/view/enviar/item_with_collect_delivery.dart';
import 'package:levv4/view/enviar/pedido_peso.dart';

import '../../model/bo/endereco/endereco.dart';
import '../../model/bo/meio_de_transporte/carro.dart';
import '../../model/bo/pedido/item_do_pedido/item_do_pedido.dart';
import '../../model/bo/pedido/pedido.dart';
import '../../model/bo/usuario/usuario.dart';
import '../../model/dao/pedido/pedido_dao.dart';
import '../../model/frontend/colors_levv.dart';
import '../../model/frontend/image_levv.dart';
import '../componentes/logo/widget_logo_levv.dart';
import 'pedido_volume.dart';

class TelaEnviar extends StatefulWidget {
  const TelaEnviar({Key? key, required this.usuario, required this.pedido})
      : super(key: key);

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
              child: logoLevv(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //1 Peso
                PedidoPeso(pedido: widget.pedido),
                //2 Volume
                PedidoVolume(pedido: widget.pedido),
                //3 Meio de Transporte
                PedidoVeiculo(pedido: widget.pedido),
              ],
            ),

            //4 Rota
            PedidoRota(
              pedido: widget.pedido,
              limparControllers: limparControllers,
            ),
            // Valor
            PedidoValor(controllerValor: controllerValor),
            //Botão
            PedidoBotoes(
                pedido: widget.pedido, limparControllers: limparControllers),
          ]),
        ),
      ),
    );
  }
}
