import 'package:flutter/material.dart';
import 'package:levv4/biblioteca/texto/text_levv.dart';
import 'package:levv4/controller/cadastrar/endereco/tela_cadastrar_endereco_controller.dart';
import 'package:levv4/view/componentes/text_field/text_field_customized_for_cep.dart';
import 'package:levv4/view/componentes/text_field/text_field_customized_for_name.dart';
import 'package:levv4/view/componentes/text_field/text_field_customized_for_number.dart';

class TelaCadastrarEndereco extends StatefulWidget {
  const TelaCadastrarEndereco({Key? key, required this.controller})
      : super(key: key);
  final TelaCadastrarEnderecoController controller;

  @override
  State<TelaCadastrarEndereco> createState() => _TelaCadastrarEnderecoState();
}

class _TelaCadastrarEnderecoState extends State<TelaCadastrarEndereco> {



  @override
  void initState() {
    super.initState();
    widget.controller.logradouro.addListener(() => setState(() {}));
    widget.controller.numero.addListener(() => setState(() {}));
    widget.controller.complemento.addListener(() => setState(() {}));
    widget.controller.bairro.addListener(() => setState(() {}));
    widget.controller.cidade.addListener(() => setState(() {}));
    widget.controller.estado.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        /// Campo 1
        TextFieldCustomizedForName(
            widget.controller.logradouro,  "Logradouro"),

        /// Campo 2
        TextFieldCustomizedForNumber(widget.controller.numero, "Número"),

        /// Campo 3
        TextFieldCustomizedForName(
            widget.controller.complemento, "Complemento",
        maxLength: 10),

        /// Campo 4
        TextFieldCustomizedForCep(controller: widget.controller.cepMask),

        /// Campo 5
        TextFieldCustomizedForName(
            widget.controller.bairro,  "Bairro"),

        /// Campo 6
        TextFieldCustomizedForName(
            widget.controller.cidade, "Cidade"),

        /// Campo 7
        TextFieldCustomizedForName(
            widget.controller.estado,  "Estado"),

        /// Campo 8
        _campoDeGeolocalizacao(),
      ],
    );
  }

  Widget _campoDeGeolocalizacao() => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async  {
                await _buscarLocalizacao();

                setState(() {
                  (widget.controller.geoPoint.latitude == 0.0 &&
                      widget.controller.geoPoint.longitude == 0.0)
                      ? widget.controller.color = Colors.red
                      : widget.controller.color = Colors.green;
                });

                },
              child: Icon(
                Icons.location_on,
                color: widget.controller.color,
                size: 30,
              ),
            ),
            Container(
              width: 160,
              child: Text("Latitude: ${widget.controller.geoPoint.latitude}"),
            ),
            Container(
                width: 160,
                child:
                    Text("Longitude ${widget.controller.geoPoint.longitude}")),
          ],
        ),
      );

  Future<void> _buscarLocalizacao() async {
    try {
      await widget.controller.buscarLocalizacaoAtual();
      setState(() {
        widget.controller.geoPoint;
      });
    } catch (erro) {
      _erroAoBuscarLocalizacao();
      print("TelaCadastrarEndereco() --> erro: ${erro.toString()}");
    }
  }

  _erroAoBuscarLocalizacao() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(TextLevv.ERRO),
            titlePadding: const EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
            content: const Text(TextLevv.ERRO_BUSCAR_LOCALIZACAO),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(TextLevv.OK))
            ],
          );
        });
  }
}
