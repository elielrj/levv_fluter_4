import 'package:flutter/material.dart';
import 'package:levv4/controller/cadastrar/meio_de_transporte/tela_cadastrar_meio_de_transporte_controller.dart';
import 'package:levv4/view/componentes/documento_de_identificacao/documento_de_identificacao.dart';
import 'package:levv4/view/componentes/text_field/text_field_customized_for_name.dart';

class TelaCadastrarMeioDeTransporte extends StatefulWidget {
  const TelaCadastrarMeioDeTransporte({Key? key, required this.controller})
      : super(key: key);

  final TelaCadastrarMeioDeTransporteController controller;

  @override
  State<TelaCadastrarMeioDeTransporte> createState() => _TelaCadastrarMeioDeTransporteState();
}

class _TelaCadastrarMeioDeTransporteState extends State<TelaCadastrarMeioDeTransporte> {
  @override
  void initState() {
    super.initState();
    widget.controller.controllerModelo.addListener(() => setState(() {}));
    widget.controller.controllerMarca.addListener(() => setState(() {}));
    widget.controller.controllerCor.addListener(() => setState(() {}));
    widget.controller.controllerPlaca.addListener(() => setState(() {}));
    widget.controller.controllerRenavan.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Card(
            child: DropdownButton(
                underline: Container(
                  color: Colors.brown,
                ),
                isExpanded: true,
                value: widget.controller.valueMeioDeTransporte,
                items: const [
                  DropdownMenuItem(
                    value: 0,
                    child: Text(
                      "A pé",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text(
                      "Bike",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text(
                      "Moto",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text(
                      "Carro",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (widget.controller.valueMeioDeTransporte !=
                      int.parse(value.toString())) {
                    widget.controller.controllerModelo.clear();
                    widget.controller.controllerMarca.clear();
                    widget.controller.controllerCor.clear();
                    widget.controller.controllerPlaca.clear();
                    widget.controller.controllerRenavan.clear();
                    widget.controller.documentoDoVeiculo.file = null;

                    setState(() {
                      widget.controller.valueMeioDeTransporte =
                          int.parse(value.toString());
                    });
                  }
                }),
          ),
        ),
        (widget.controller.valueMeioDeTransporte == 0 ||
                widget.controller.valueMeioDeTransporte == 1)
            ? Container(
                width: 0,
              )
            : Column(
                children: [
                  ///1
                  TextFieldCustomizedForName(widget.controller.controllerModelo,
                       "Modelo"),

                  ///2
                  TextFieldCustomizedForName(widget.controller.controllerMarca,
                      "Marca"),

                  ///3
                  TextFieldCustomizedForName(widget.controller.controllerCor,
                      "Cor do Veículo"),

                  ///4
                  TextFieldCustomizedForName(widget.controller.controllerPlaca,
                      "Placa",
                      maxLength: 8),

                  ///5
                  TextFieldCustomizedForName(
                      widget.controller.controllerRenavan,

                      "Renavan",
                      maxLength: 15),

                  ///6
                  DocumentoDeIdentificacao(
                      documento: widget.controller.documentoDoVeiculo,
                  color: widget.controller.colorDocumentoDoVeiculo,),
                ],
              ),
      ],
    );
  }
}
