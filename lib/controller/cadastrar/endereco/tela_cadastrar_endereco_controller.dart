import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:levv4/api/mascara/formatter_cep.dart';
import 'package:levv4/api/mascara/mask.dart';
import 'package:levv4/view/localizar/localizar/localizar.dart';

class TelaCadastrarEnderecoController {
  final logradouro = TextEditingController();
  final numero = TextEditingController();
  final complemento = TextEditingController();
  final cepMask = Mask(formatter: FormatterCep());
  final bairro = TextEditingController();
  final cidade = TextEditingController();
  final estado = TextEditingController();
  Color color = Colors.red;

  //todo mudar isso no geopoint
  GeoPoint geoPoint = const GeoPoint(0.0, 0.0);

  Future<void> buscarLocalizacaoAtual() async {
    final localizar = Localizar();

    Position? position = await localizar.determinarPosicao();

    if (position != null) {
      geoPoint = GeoPoint(position.latitude, position.longitude);
    }
  }

  void limparTodosOsCampos() {
    logradouro.clear();
    numero.clear();
    complemento.clear();
    cepMask.textEditingController.clear();
    cepMask.formatter.getMaskTextInputFormatter().clear();
    bairro.clear();
    cidade.clear();
    estado.clear();
    geoPoint = const GeoPoint(0.0, 0.0);
    color = Colors.red;
  }

  bool validador() {
    return validarLogradouro() &
        validarNumero() &
        validarComplemento() &
        validarCep() &
        validarBairro() &
        validarCidade() &
        validarEstado() &
        validarGeolocalizacao();
  }

  bool validarLogradouro() {
    return logradouro.text.isNotEmpty;
  }

  bool validarNumero() {
    return numero.text.isNotEmpty;
  }

  bool validarComplemento() {
    return complemento.text.isNotEmpty;
  }

  bool validarCep() {
    return cepMask.formatter.isValid();
  }

  bool validarBairro() {
    return bairro.text.isNotEmpty;
  }

  bool validarCidade() {
    return cidade.text.isNotEmpty;
  }

  bool validarEstado() {
    return estado.text.isNotEmpty;
  }

  bool validarGeolocalizacao() {
    return !(geoPoint.longitude == 0.0 && geoPoint.latitude == 0.0);
  }
}
