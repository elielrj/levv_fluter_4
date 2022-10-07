import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/carro.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';
import 'package:levv4/model/bo/usuario/perfil/enviar/entregar/entregar.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';
import 'package:levv4/view/enviar/tela_enviar.dart';
import 'package:levv4/view/mapa/localizar/localizar.dart';

import '../../../api/mascara/formatter_cep.dart';
import '../../../api/mascara/formatter_cpf.dart';
import '../../../api/mascara/formatter_date.dart';
import '../../../api/mascara/masks_levv.dart';
import '../../../model/bo/arquivo/arquivo.dart';
import '../../../model/bo/meio_de_transporte/bike.dart';
import '../../../model/bo/pedido/pedido.dart';
import '../../../model/bo/usuario/usuario.dart';
import '../../../model/dao/arquivo/arquivo_dao.dart';
import '../../../model/dao/usuario/entregar_dao.dart';
import '../../../api/cor/colors_levv.dart';
import '../../../api/imagem/image_levv.dart';
import '../../componentes/erro/show_dialog_erro.dart';
import '../../entregar/tela_entregar.dart';

class TelaCadastrarEntregador extends StatefulWidget {
  const TelaCadastrarEntregador({Key? key, required this.usuario})
      : super(key: key);

  final Usuario usuario;

  @override
  State<TelaCadastrarEntregador> createState() =>
      _TelaCadastrarEntregadorState();
}

class _TelaCadastrarEntregadorState extends State<TelaCadastrarEntregador>
    with ShowDialogErro {
  final controllerNome = TextEditingController();
  final controllerSobrenome = TextEditingController();
  final controllerMaskCpf = Mask(formatter: FormatterCpf());
  final controllerMaskNascimento = Mask(formatter: FormatterDate());
  final documentoDeIdentificacao = Arquivo();

  int valueMeioDeTransporte = 0;
  final controllerModelo = TextEditingController();
  final controllerMarca = TextEditingController();
  final controllerCor = TextEditingController();
  final controllerPlaca = TextEditingController();
  final controllerRenavan = TextEditingController();
  final documentoDoVeiculo = Arquivo();

  final logradouro = TextEditingController();
  final numero = TextEditingController();
  final complemento = TextEditingController();
  final cepMask = Mask(formatter: FormatterCep());
  final bairro = TextEditingController();
  final cidade = TextEditingController();
  final estado = TextEditingController();
  //todo mudar isso no geopoint
  GeoPoint geoPoit = GeoPoint(2.1, 1.1);

  @override
  void initState() {
    super.initState();
    controllerNome.addListener(() => setState(() {}));
    controllerSobrenome.addListener(() => setState(() {}));
    controllerMaskCpf.textEditingController.addListener(() => setState(() {}));
    controllerMaskNascimento.textEditingController
        .addListener(() => setState(() {}));

    controllerModelo.addListener(() => setState(() {}));
    controllerMarca.addListener(() => setState(() {}));
    controllerCor.addListener(() => setState(() {}));
    controllerPlaca.addListener(() => setState(() {}));
    controllerRenavan.addListener(() => setState(() {}));

    logradouro.addListener(() => setState(() {}));
    numero.addListener(() => setState(() {}));
    complemento.addListener(() => setState(() {}));
    cepMask.textEditingController.addListener(() => setState(() {}));
    cidade.addListener(() => setState(() {}));
    estado.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar perfil: Entregar"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Image.asset(ImageLevv.LOGO_DO_APP_LEVV, width: 80),
                    ),
                    TextField(
                      onTap: () {},
                      controller: controllerNome,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        counterText: controllerNome.text.length <= 1
                            ? "${controllerNome.text.length} caracter"
                            : "${controllerNome.text.length} caracteres",
                        labelText: "Nome",
                        labelStyle: const TextStyle(
                            backgroundColor: Colors.white, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: (controllerNome.text.length < 3
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: controllerNome.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () => controllerNome.clear(),
                              ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLength: 100,
                      style: const TextStyle(fontSize: 18),
                    ),
                    TextField(
                      onTap: () {},
                      controller: controllerSobrenome,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        counterText: controllerSobrenome.text.length <= 1
                            ? "${controllerSobrenome.text.length} caracter"
                            : "${controllerSobrenome.text.length} caracteres",
                        labelText: "Sobrenome",
                        labelStyle: const TextStyle(
                            backgroundColor: Colors.white, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: (controllerSobrenome.text.length < 3
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: controllerSobrenome.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () => controllerSobrenome.clear(),
                              ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLength: 100,
                      style: const TextStyle(fontSize: 18),
                    ),
                    TextField(
                      onTap: () {},
                      controller: controllerMaskCpf.textEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        //todo resolver contagem
                        counterText: controllerMaskCpf.formatter.getFormatter()
                                    .getUnmaskedText()
                                    .length <=
                                1
                            ? "${controllerMaskCpf.formatter.getFormatter().getUnmaskedText().length} caracter"
                            : "${controllerMaskCpf.formatter.getFormatter().getUnmaskedText().length} caracteres",
                        labelText: "CPF",
                        labelStyle: const TextStyle(
                            backgroundColor: Colors.white, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: (controllerMaskCpf.formatter.getFormatter()
                                      .getUnmaskedText()
                                      .length <
                                  3
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: controllerMaskCpf.formatter.getFormatter()
                                .getUnmaskedText()
                                .isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () => controllerMaskCpf
                                    .textEditingController
                                    .clear(),
                              ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      inputFormatters: [controllerMaskCpf.formatter.getFormatter()],
                      maxLength: 14,
                      style: const TextStyle(fontSize: 18),
                    ),
                    TextField(
                      onTap: () {},
                      controller:
                          controllerMaskNascimento.textEditingController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        counterText: controllerMaskNascimento.formatter.getFormatter()
                                    .getUnmaskedText()
                                    .length <=
                                1
                            ? "${controllerMaskNascimento.formatter.getFormatter().getUnmaskedText().length} caracter"
                            : "${controllerMaskNascimento.formatter.getFormatter().getUnmaskedText().length} caracteres",
                        labelText: "Data de nascimento",
                        labelStyle: const TextStyle(
                            backgroundColor: Colors.white, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: (controllerMaskNascimento.formatter.getFormatter()
                                      .getUnmaskedText()
                                      .length <
                                  3
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: controllerMaskNascimento.formatter.getFormatter()
                                .getUnmaskedText()
                                .isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () => controllerMaskNascimento
                                    .textEditingController
                                    .clear(),
                              ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      inputFormatters: [controllerMaskNascimento.formatter.getFormatter()],
                      maxLength: 10,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "Documento de identificação",
                                  labelStyle: const TextStyle(
                                      backgroundColor: Colors.transparent,
                                      color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black12, width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2)),
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color:
                                        (documentoDeIdentificacao.image == null
                                            ? Colors.black
                                            : Colors.green),
                                  ),
                                  fillColor: Colors.black12,
                                  filled: true,
                                  enabled: false),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            width: 90,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    documentoDeIdentificacao.getImageCamera();
                                    setState(() {
                                      documentoDeIdentificacao.image;
                                    });
                                    documentoDeIdentificacao.descricao =
                                        "documentoDeIdentificacao";
                                  },
                                  child: const Icon(Icons.add_a_photo,
                                      size: 25, color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      documentoDeIdentificacao
                                          .getImageGallery();
                                      setState(() {
                                        documentoDeIdentificacao.image;
                                      });
                                      documentoDeIdentificacao.descricao =
                                          "documentoDeIdentificacao";
                                    },
                                    child: const Icon(Icons.file_upload,
                                        size: 25, color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //veículo
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Meio que utilizará para transportar pedidos",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Card(
                        child: DropdownButton(
                            underline: Container(
                              color: Colors.brown,
                            ),
                            isExpanded: true,
                            value: valueMeioDeTransporte,
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
                              if (valueMeioDeTransporte !=
                                  int.parse(value.toString())) {
                                controllerModelo.clear();
                                controllerMarca.clear();
                                controllerCor.clear();
                                controllerPlaca.clear();
                                controllerRenavan.clear();
                                documentoDoVeiculo.image = null;

                                setState(() {
                                  valueMeioDeTransporte =
                                      int.parse(value.toString());
                                });
                              }
                            }),
                      ),
                    ),
                    (valueMeioDeTransporte == 0 || valueMeioDeTransporte == 1)
                        ? Container(
                            width: 0,
                          )
                        : Column(
                            children: [
                              TextField(
                                onTap: () {},
                                controller: controllerModelo,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  counterText: controllerModelo.text.length <= 1
                                      ? "${controllerModelo.text.length} caracter"
                                      : "${controllerModelo.text.length} caracteres",
                                  labelText: "Modelo",
                                  labelStyle: TextStyle(
                                      backgroundColor:
                                          (valueMeioDeTransporte <= 1
                                              ? Colors.transparent
                                              : Colors.white),
                                      color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black12, width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2)),
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: (controllerModelo.text.length < 3
                                        ? Colors.black
                                        : Colors.green),
                                  ),
                                  suffixIcon: controllerModelo.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.red),
                                          onPressed: () =>
                                              controllerModelo.clear(),
                                        ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabled: true,
                                ),
                                maxLength: 100,
                                style: const TextStyle(fontSize: 18),
                              ),
                              TextField(
                                onTap: () {},
                                controller: controllerMarca,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  counterText: controllerMarca.text.length <= 1
                                      ? "${controllerMarca.text.length} caracter"
                                      : "${controllerMarca.text.length} caracteres",
                                  labelText: "Marca",
                                  labelStyle: TextStyle(
                                      backgroundColor:
                                          (valueMeioDeTransporte <= 1
                                              ? Colors.transparent
                                              : Colors.white),
                                      color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black12, width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2)),
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: (controllerMarca.text.length < 3
                                        ? Colors.black
                                        : Colors.green),
                                  ),
                                  suffixIcon: controllerMarca.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.red),
                                          onPressed: () =>
                                              controllerMarca.clear(),
                                        ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabled: true,
                                ),
                                maxLength: 100,
                                style: const TextStyle(fontSize: 18),
                              ),
                              TextField(
                                onTap: () {},
                                controller: controllerCor,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  counterText: controllerCor.text.length <= 1
                                      ? "${controllerCor.text.length} caracter"
                                      : "${controllerCor.text.length} caracteres",
                                  labelText: "Cor do Veículo",
                                  labelStyle: TextStyle(
                                      backgroundColor:
                                          (valueMeioDeTransporte <= 1
                                              ? Colors.transparent
                                              : Colors.white),
                                      color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black12, width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2)),
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: (controllerCor.text.length < 3
                                        ? Colors.black
                                        : Colors.green),
                                  ),
                                  suffixIcon: controllerCor.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.red),
                                          onPressed: () =>
                                              controllerCor.clear(),
                                        ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabled: true,
                                ),
                                maxLength: 100,
                                style: const TextStyle(fontSize: 18),
                              ),
                              TextField(
                                onTap: () {},
                                controller: controllerPlaca,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  counterText: controllerPlaca.text.length <= 1
                                      ? "${controllerPlaca.text.length} caracter"
                                      : "${controllerPlaca.text.length} caracteres",
                                  labelText: "Placa",
                                  labelStyle: TextStyle(
                                      backgroundColor:
                                          (valueMeioDeTransporte <= 1
                                              ? Colors.transparent
                                              : Colors.white),
                                      color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black12, width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2)),
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: (controllerPlaca.text.length < 3
                                        ? Colors.black
                                        : Colors.green),
                                  ),
                                  suffixIcon: controllerPlaca.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.red),
                                          onPressed: () =>
                                              controllerPlaca.clear(),
                                        ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabled: true,
                                ),
                                maxLength: 100,
                                style: const TextStyle(fontSize: 18),
                              ),
                              TextField(
                                onTap: () {},
                                controller: controllerRenavan,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  counterText: controllerRenavan.text.length <=
                                          1
                                      ? "${controllerRenavan.text.length} caracter"
                                      : "${controllerRenavan.text.length} caracteres",
                                  labelText: "Renavan",
                                  labelStyle: TextStyle(
                                      backgroundColor:
                                          (valueMeioDeTransporte <= 1
                                              ? Colors.transparent
                                              : Colors.white),
                                      color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.black12, width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2)),
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: (controllerRenavan.text.length < 3
                                        ? Colors.black
                                        : Colors.green),
                                  ),
                                  suffixIcon: controllerRenavan.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.red),
                                          onPressed: () =>
                                              controllerRenavan.clear(),
                                        ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabled: true,
                                ),
                                maxLength: 100,
                                style: const TextStyle(fontSize: 18),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: "Documento do Veículo",
                                            labelStyle: const TextStyle(
                                                backgroundColor:
                                                    Colors.transparent,
                                                color: Colors.black),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.black12,
                                                    width: 2)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.green,
                                                    width: 2)),
                                            prefixIcon: Icon(
                                              Icons.account_circle,
                                              color:
                                                  (documentoDoVeiculo.image ==
                                                          null
                                                      ? Colors.black
                                                      : Colors.green),
                                            ),
                                            fillColor: Colors.black12,
                                            filled: true,
                                            enabled: false),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (!(valueMeioDeTransporte ==
                                                      1 ||
                                                  valueMeioDeTransporte == 0)) {
                                                documentoDoVeiculo
                                                    .getImageCamera();
                                                setState(() {
                                                  documentoDoVeiculo.image;
                                                });
                                                documentoDoVeiculo.descricao =
                                                    "documentoDoVeiculo";
                                              }
                                            },
                                            child: const Icon(Icons.add_a_photo,
                                                size: 25, color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                if (!(valueMeioDeTransporte ==
                                                        1 ||
                                                    valueMeioDeTransporte ==
                                                        0)) {
                                                  documentoDoVeiculo
                                                      .getImageGallery();
                                                  setState(() {
                                                    documentoDoVeiculo.image;
                                                  });
                                                  documentoDoVeiculo.descricao =
                                                      "documentoDoVeiculo";
                                                  setState(() {
                                                    documentoDoVeiculo;
                                                  });
                                                }
                                              },
                                              child: const Icon(
                                                  Icons.file_upload,
                                                  size: 25,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                  ],
                ),
                //endereço
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Endereço particular",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                Column(
                  children: [
                    TextField(
                      onTap: () {},
                      controller: logradouro,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: logradouro.text.length <= 1
                            ? "${logradouro.text.length} caracter"
                            : "${logradouro.text.length} caracteres",
                        labelText: "Logradouro",
                        labelStyle: const TextStyle(
                            backgroundColor: Colors.white, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: (logradouro.text.length < 3
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: logradouro.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () => logradouro.clear(),
                              ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLength: 100,
                      style: const TextStyle(fontSize: 18),
                    ),
                    TextField(
                      onTap: () {},
                      controller: numero,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: numero.text.length <= 1
                            ? "${numero.text.length} caracter"
                            : "${numero.text.length} caracteres",
                        labelText: "Número",
                        labelStyle: const TextStyle(
                            backgroundColor: Colors.white, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: (numero.text.length < 3
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: numero.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () => numero.clear(),
                              ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLength: 100,
                      style: const TextStyle(fontSize: 18),
                    ),
                    TextField(
                      onTap: () {},
                      controller: complemento,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: complemento.text.length <= 1
                            ? "${complemento.text.length} caracter"
                            : "${complemento.text.length} caracteres",
                        labelText: "Complemento",
                        labelStyle: const TextStyle(
                            backgroundColor: Colors.white, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: (complemento.text.length < 3
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: complemento.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () => complemento.clear(),
                              ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLength: 100,
                      style: const TextStyle(fontSize: 18),
                    ),
                    TextField(
                      onTap: () {},
                      controller: cepMask.textEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: cepMask.formatter.getFormatter()
                                    .getUnmaskedText()
                                    .length <=
                                1
                            ? "${cepMask.formatter.getFormatter().getUnmaskedText().length} caracter"
                            : "${cepMask.formatter.getFormatter().getUnmaskedText().length} caracteres",
                        labelText: "CEP",
                        labelStyle: const TextStyle(
                            backgroundColor: Colors.white, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color:
                              (cepMask.formatter.getFormatter().getUnmaskedText().length == 9
                                  ? Colors.black
                                  : Colors.green),
                        ),
                        suffixIcon: cepMask.formatter.getFormatter().getUnmaskedText().isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () =>
                                    cepMask.textEditingController.clear(),
                              ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      inputFormatters: [cepMask.formatter.getFormatter()],
                      maxLength: 9,
                      style: const TextStyle(fontSize: 18),
                    ),
                    TextField(
                      onTap: () {},
                      controller: bairro,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: bairro.text.length <= 1
                            ? "${bairro.text.length} caracter"
                            : "${bairro.text.length} caracteres",
                        labelText: "Bairro",
                        labelStyle: const TextStyle(
                            backgroundColor: Colors.white, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: (bairro.text.length < 3
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: bairro.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () => bairro.clear(),
                              ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLength: 100,
                      style: const TextStyle(fontSize: 18),
                    ),
                    TextField(
                      onTap: () {},
                      controller: cidade,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: cidade.text.length <= 1
                            ? "${cidade.text.length} caracter"
                            : "${cidade.text.length} caracteres",
                        labelText: "Cidade",
                        labelStyle: const TextStyle(
                            backgroundColor: Colors.white, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: (cidade.text.length < 3
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: cidade.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () => cidade.clear(),
                              ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLength: 100,
                      style: const TextStyle(fontSize: 18),
                    ),
                    TextField(
                      onTap: () {},
                      controller: estado,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: estado.text.length <= 1
                            ? "${estado.text.length} caracter"
                            : "${estado.text.length} caracteres",
                        labelText: "Estado",
                        labelStyle: const TextStyle(
                            backgroundColor: Colors.white, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black12, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: (estado.text.length < 3
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: estado.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () => estado.clear(),
                              ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLength: 100,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final localizar = Localizar();

                              Position? position =
                                  await localizar.ultimaPosicao();

                              if (position != null) {
                                geoPoit = GeoPoint(
                                    position.latitude, position.longitude);
                                setState(() {
                                  geoPoit;
                                });
                              } else {
                                erroAoBuscarLocalizacao(context);
                              }
                            },
                            child: Icon(
                              Icons.location_on,
                              color: ((geoPoit.longitude == 0 &&
                                      geoPoit.latitude == 0)
                                  ? Colors.black
                                  : Colors.green),
                              size: 30,
                            ),
                          ),
                          Container(
                            width: 160,
                            child: Text("Latitude: ${geoPoit.latitude}"),
                          ),
                          Container(
                              width: 160,
                              child: Text("Longitude ${geoPoit.longitude}")),
                        ],
                      ),
                    )
                  ],
                ),
                //botões
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        padding: const EdgeInsets.all(8),
                        minimumSize: const Size(190, 65),
                        elevation: 2,
                        primary: Colors.black,
                        alignment: Alignment.center,
                      ),
                      onPressed: () => _cadastrarPerfilEntregador(),
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
                            child: Text("Cadastrar"),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        padding: const EdgeInsets.all(8),
                        minimumSize: const Size(190, 65),
                        elevation: 2,
                        primary: Colors.black,
                        alignment: Alignment.center,
                      ),
                      onPressed: () {
                        _limparCampos();
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
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: ColorsLevv.FUNDO_400,
    );
  }

  _exibirMensagemDeFaltaDeUploadDeDocumentoDoVeiculo() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Campo Vazio"),
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
            content:
                const Text("Envie um documento de identificação do veículo!"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"))
            ],
          );
        });
  }

  _meioDeTransporteSelecionado() {
    switch (valueMeioDeTransporte) {
      case 0:
        return APe();

      case 1:
        return Bike();

      case 2:
        return Moto(
            modelo: controllerModelo.text,
            marca: controllerMarca.text,
            cor: controllerCor.text,
            placa: controllerPlaca.text,
            renavam: controllerRenavan.text,
            documentoDoVeiculo: false);

      case 3:
        return Carro(
            modelo: controllerModelo.text,
            marca: controllerMarca.text,
            cor: controllerCor.text,
            placa: controllerPlaca.text,
            renavam: controllerRenavan.text,
            documentoDoVeiculo: false);
    }
  }

  _limparCampos() {
    controllerNome.clear();
    controllerSobrenome.clear();
    controllerMaskCpf.textEditingController.clear();
    controllerMaskNascimento.textEditingController.clear();

    documentoDeIdentificacao.image = null;

    valueMeioDeTransporte = 0;

    controllerModelo.clear();
    controllerMarca.clear();
    controllerCor.clear();
    controllerPlaca.clear();
    controllerRenavan.clear();

    documentoDoVeiculo.image = null;

    logradouro.clear();
    numero.clear();
    complemento.clear();
    cepMask.textEditingController.clear();
    bairro.clear();
    cidade.clear();
    estado.clear();

    geoPoit = const GeoPoint(0, 0);
  }

  _cadastrarPerfilEntregador() async {
    if (_verificarDados()) {
      //monta objeto endereço
      Endereco casa = Endereco(
          logradouro: numero.text,
          numero: numero.text,
          complemento: numero.text,
          cep: numero.text,
          bairro: numero.text,
          cidade: numero.text,
          estado: estado.text,
          geolocalizacao: geoPoit);

      List<Endereco> listaDeEnderecos = [];
      //monta objeto entregar
      Entregar entregar = Entregar(
        nome: controllerNome.text,
        sobrenome: controllerSobrenome.text,
        cpf: controllerMaskCpf.textEditingController.text,
        nascimento: DateFormat('dd/MM/yyyy')
            .parse(controllerMaskNascimento.textEditingController.text),
        enderecosFavoritos: listaDeEnderecos,
        casa: casa,
        trabalho: Endereco(),
        documentoDeIdentificacao: false,
        pedidosTransportados: null,
        meioDeTransporte: _meioDeTransporteSelecionado(),
      );

      try {
        //1 - inserir doc de identificação
        final arquivoDAO = ArquivoDAO();
        await arquivoDAO.upload(documentoDeIdentificacao);

        //2 - inserir documento do veículo
        if (valueMeioDeTransporte == 2 || valueMeioDeTransporte == 3) {
          await arquivoDAO.upload(documentoDoVeiculo);
        }

        //inserir meio de transporte
        /*
        if (valueMeioDeTransporte == 0) {
          final aPeDAO = APeDAO();
          await aPeDAO.create(_meioDeTransporteSelecionado());
        } else if (valueMeioDeTransporte == 1) {
          final bikeDAO = BikeDAO();
          await bikeDAO.create(_meioDeTransporteSelecionado());
        } else if (valueMeioDeTransporte == 2) {
          final motoDAO = MotoDAO();
          await motoDAO.create(_meioDeTransporteSelecionado());
        } else {
          final carroDAO = CarroDAO();
          carroDAO.create(_meioDeTransporteSelecionado());
        }*/

        //3 - criar entregador
        final entregadorDAO = EntregarDAO();
        await entregadorDAO.criar(entregar);

        //4 - update o perfil de user
        widget.usuario.perfil = entregar;

        //5 - atualizar perfil do usuárioas no banco
        final usuarioDAO = UsuarioDAO();
        await usuarioDAO.atualizar(widget.usuario);

        //6 - navegar para tela Entregar
        _navegarParaTelaEntregar();
      } catch (onError) {
        _exibirMensagemDeErroAoCadastrar();
      }
    }
  }

  _exibirMensagemDeErroAoCadastrar() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erro"),
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
            content: const Text("Erro ao cadastrar usuário entregador!"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"))
            ],
          );
        });
  }

  bool _verificarDados() {
    return _verificarNome();
  }

  bool _verificarNome() {
    if (controllerNome.text.length > 3) {
      return _verificarSobrenome();
    } else {
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, no campo nome!");
      return false;
    }
  }

  bool _verificarSobrenome() {
    if (controllerSobrenome.text.length > 3) {
      return _verificarCpf();
    } else {
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, no campo sobrnome!");
      return false;
    }
  }

  bool _verificarCpf() {
    if (controllerMaskCpf.formatter.getFormatter().getUnmaskedText().length == 11) {
      return _verificarNascimento();
    } else {
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, no campo CPF!");
      print("erro em verificar cpf");
      return false;
    }
  }

  bool _verificarNascimento() {
    if (controllerMaskNascimento.formatter.getFormatter().getUnmaskedText().length == 8) {
      return _verificarDocumentoDeIdentificacao();
    } else {
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, no campo Data de Nascimento!");
      return false;
    }
  }

  bool _verificarDocumentoDeIdentificacao() {
    if (documentoDeIdentificacao.image != null) {
      return _verificarMeioDeTransporte();
    } else {
      _exibirMensagemDeFaltaDeUploadDeDocumento();
      return false;
    }
  }

  bool _verificarMeioDeTransporte() {
    if (valueMeioDeTransporte == 0 || valueMeioDeTransporte == 1) {
      return _verificarEnderecoDeCasa();
    } else if (controllerModelo.text.length > 3 &&
        controllerMarca.text.length > 3 &&
        controllerCor.text.length > 3 &&
        controllerPlaca.text.length > 8 &&
        controllerPlaca.text.length < 12 &&
        controllerRenavan.text.length > 10) {
      if (documentoDoVeiculo.image != null) {
        return _verificarEnderecoDeCasa();
      } else {
        _exibirMensagemDeFaltaDeUploadDeDocumentoDoVeiculo();
        print("erro em verificar endereço de casa");
        return false;
      }
    } else {
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, nos campos meio de transporte!");
      print("erro em verificar meio de transporte");
      return false;
    }
  }



  bool _verificarEnderecoDeCasa() {
    return _verificarLogradouro();
  }

  bool _verificarLogradouro(){
    if(logradouro.text.length >= 3){
      return _verificarNumero();
    }else{
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, no campo Logradouro!");
      return false;
    }
  }

  bool _verificarNumero(){
    if(numero.text.length >= 3){
      return _verificarComplemento();
    }else{
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, no campo Número!");
      return false;
    }
  }

  bool _verificarComplemento(){
    if(complemento.text.length >= 3){
      return _verificarCep();
    }else{
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, no campo Complemento!");
      return false;
    }
  }

  bool _verificarCep(){
    if(cepMask.formatter.getFormatter().getUnmaskedText().length == 8){
      return _verificarBairro();
    }else{
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, no campo Cep!");
      return false;
    }
  }

  bool _verificarBairro(){
    if(bairro.text.length >= 3){
      return _verificarCidade();
    }else{
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, no campo Bairro!");
      return false;
    }
  }

  bool _verificarCidade(){
    if(cidade.text.length >= 3){
      return _verificarEstado();
    }else{
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, no campo Cidade!");
      return false;
    }
  }

  bool _verificarEstado(){
    if(estado.text.length >= 3){
      return _verificarGeopoint();
    }else{
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, no campo Estado!");
      return false;
    }
  }

  bool _verificarGeopoint(){
    if(geoPoit.latitude != 0.0 && geoPoit.longitude != 0.0){
      return true;
    }else{
      _exibirMensagemDeCampoVazio(mensagem:  "Varifique os dados digitados, no campo Geopoint!");
      return false;
    }
  }


  _navegarParaTelaEntregar() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaEntregar(
                  usuario: widget.usuario,
                )));
  }

  _exibirMensagemDeFaltaDeUploadDeDocumento() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Campo Vazio"),
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
            content: const Text("Envie um documento de identificação!"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"))
            ],
          );
        });
  }

  _exibirMensagemDeCampoVazio({required String mensagem}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Campo Inválido"),
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
            content: Text(
                mensagem),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"))
            ],
          );
        });
  }
}
