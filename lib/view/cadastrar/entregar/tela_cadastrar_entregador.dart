import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/carro.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';
import 'package:levv4/model/bo/usuario/perfil/enviar/entregar/entregar.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';
import 'package:levv4/model/frontend/colors_levv.dart';
import 'package:levv4/model/frontend/image_levv.dart';
import 'package:levv4/model/frontend/mask/masks_levv.dart';
import 'package:levv4/view/enviar/tela_enviar.dart';

import '../../../model/bo/arquivo/arquivo.dart';
import '../../../model/bo/meio_de_transporte/bike.dart';
import '../../../model/bo/usuario/usuario.dart';
import '../../../model/dao/arquivo/arquivo_dao.dart';
import '../../../model/dao/usuario/entregar_dao.dart';

class TelaCadastrarEntregador extends StatefulWidget {
  const TelaCadastrarEntregador({Key? key, required this.usuario})
      : super(key: key);

  final Usuario usuario;

  @override
  State<TelaCadastrarEntregador> createState() =>
      _TelaCadastrarEntregadorState();
}

class _TelaCadastrarEntregadorState extends State<TelaCadastrarEntregador> {
  final controllerNome = TextEditingController();
  final controllerSobrenome = TextEditingController();
  final controllerMaskCpf = MasksLevv.cpfMask;
  final controllerMaskNascimento = MasksLevv.dateMask;
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
  final cepMask = MasksLevv.cepMask;
  final bairro = TextEditingController();
  final cidade = TextEditingController();
  final estado = TextEditingController();
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  GeoPoint geoPoit = GeoPoint(0, 0);

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
    latitude.addListener(() => setState(() {}));
    longitude.addListener(() => setState(() {}));
    latitude.text = "1.2";
    longitude.text = "1.2";
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
                        counterText: controllerMaskCpf.formatter
                                    .getUnmaskedText()
                                    .length <=
                                1
                            ? "${controllerMaskCpf.formatter.getUnmaskedText().length} caracter"
                            : "${controllerMaskCpf.formatter.getUnmaskedText().length} caracteres",
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
                          color: (controllerMaskCpf.formatter
                                      .getUnmaskedText()
                                      .length <
                                  3
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: controllerMaskCpf.formatter
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
                      inputFormatters: [controllerMaskCpf.formatter],
                      maxLength: 14,
                      style: const TextStyle(fontSize: 18),
                    ),
                    TextField(
                      onTap: () {},
                      controller:
                          controllerMaskNascimento.textEditingController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        counterText: controllerMaskNascimento.formatter
                                    .getUnmaskedText()
                                    .length <=
                                1
                            ? "${controllerMaskNascimento.formatter.getUnmaskedText().length} caracter"
                            : "${controllerMaskNascimento.formatter.getUnmaskedText().length} caracteres",
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
                          color: (controllerMaskNascimento.formatter
                                      .getUnmaskedText()
                                      .length <
                                  3
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: controllerMaskNascimento.formatter
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
                      inputFormatters: [controllerMaskNascimento.formatter],
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
                                      documentoDoVeiculo.image;
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
                                        documentoDoVeiculo.image;
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
                        counterText: cepMask.formatter
                                    .getUnmaskedText()
                                    .length <=
                                1
                            ? "${cepMask.formatter.getUnmaskedText().length} caracter"
                            : "${cepMask.formatter.getUnmaskedText().length} caracteres",
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
                          color: (cepMask.formatter.getUnmaskedText().length == 9
                              ? Colors.black
                              : Colors.green),
                        ),
                        suffixIcon: cepMask.formatter.getUnmaskedText().isEmpty
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
                      inputFormatters: [cepMask.formatter],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color:
                              ((geoPoit.longitude == 0 && geoPoit.latitude == 0)
                                  ? Colors.black
                                  : Colors.green),
                          size: 30,
                        ),
                        Container(
                          width: 160,
                          child: TextField(
                              onTap: () {},
                              controller: latitude,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Latitude",
                                labelStyle: const TextStyle(
                                    backgroundColor: Colors.white,
                                    color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.black12, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.green, width: 2)),
                                suffixIcon: latitude.text.isEmpty
                                    ? Container(
                                        width: 0,
                                      )
                                    : IconButton(
                                        icon: const Icon(Icons.close,
                                            color: Colors.red),
                                        onPressed: () => latitude.clear(),
                                      ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              maxLength: 100,
                              style: const TextStyle(fontSize: 18),
                              enabled: false),
                        ),
                        Container(
                          width: 160,
                          child: TextField(
                            onTap: () {},
                            controller: longitude,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Longitude",
                              labelStyle: const TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2)),
                              suffixIcon: longitude.text.isEmpty
                                  ? Container(
                                      width: 0,
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.close,
                                          color: Colors.red),
                                      onPressed: () => longitude.clear(),
                                    ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            maxLength: 100,
                            style: const TextStyle(fontSize: 18),
                            enabled: false,
                          ),
                        ),
                      ],
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
      backgroundColor: ColorsLevv.FUNDO,
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
    latitude.clear();
    longitude.clear();

    geoPoit = GeoPoint(0, 0);
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
          geolocalizacao: GeoPoint(double.parse(latitude.text.toString()),
              double.parse(longitude.text.toString())));

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
        await entregadorDAO.create(entregar);

        //4 - update o perfil de user
        widget.usuario.perfil = entregar;

        //5 - atualizar perfil do usuárioas no banco
        final usuarioDAO = UsuarioDAO();
        await usuarioDAO.update(widget.usuario);

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
      _exibirMensagemDeCampoVazio();
      return false;
    }
  }

  bool _verificarSobrenome() {
    if (controllerSobrenome.text.length > 3) {
      return _verificarCpf();
    } else {
      _exibirMensagemDeCampoVazio();
      return false;
    }
  }

  bool _verificarCpf() {
    if (controllerMaskCpf.formatter.getUnmaskedText().length == 11) {
      return _verificarNascimento();
    } else {
      _exibirMensagemDeCampoVazio();
      print("erro em verificar cpf");
      return false;
    }
  }

  bool _verificarNascimento() {
    if (controllerMaskNascimento.formatter.getUnmaskedText().length == 8) {
      return _verificarDocumentoDeIdentificacao();
    } else {
      _exibirMensagemDeCampoVazio();
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
      _exibirMensagemDeCampoVazio();
      print("erro em verificar meio de transporte");
      return false;
    }
  }

  bool _verificarEnderecoDeCasa() {
    if (logradouro.text.length > 3 &&
        numero.text.length > 3 &&
        complemento.text.length > 3 &&
        cepMask.formatter.getUnmaskedText().length == 8 &&
        latitude.text.length > 1 &&
        longitude.text.length > 1 &&
        bairro.text.length > 3 &&
        cidade.text.length > 3 &&
        estado.text.length > 3) {
      return true;
    } else {
      _exibirMensagemDeCampoVazio();
      print("erro em verificar endereço de casa");
      return false;
    }
  }

  _navegarParaTelaEntregar() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TelaEnviar(usuario: widget.usuario)));
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

  _exibirMensagemDeCampoVazio() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Campo Inválido"),
            titlePadding: EdgeInsets.all(20),
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.orange),
            content: const Text(
                "Varifique os dados digitados, pois há 1 ou mais campos vazios!"),
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
