import 'package:flutter/material.dart';
import 'package:levv4/api/texto/text_levv.dart';
import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';
import 'package:levv4/model/bo/meio_de_transporte/carro.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';

class TelaCadastrarMeioDeTransporteController {
  int valueMeioDeTransporte = 0;
  final controllerModelo = TextEditingController();
  final controllerMarca = TextEditingController();
  final controllerCor = TextEditingController();
  final controllerPlaca = TextEditingController();
  final controllerRenavan = TextEditingController();
  final documentoDoVeiculo =
      Arquivo(descricao: TextLevv.DOCUMENTO_VEICULO.replaceAll(" ", ""));
  Color colorDocumentoDoVeiculo = Colors.red;

  void limparTodosOsCampos() {
    valueMeioDeTransporte = 0;
    controllerMarca.clear();
    controllerCor.clear();
    controllerPlaca.clear();
    controllerRenavan.clear();
    documentoDoVeiculo.file = null;
    colorDocumentoDoVeiculo = Colors.red;
  }

  bool validador() {
    if (valueMeioDeTransporte == 0 || valueMeioDeTransporte == 1) {
      return true;
    } else {
      return validarModelo() &
          validarMarca() &
          validarCor() &
          validarPlaca() &
          validarRenavan() &
          validarDocumentoDoVeiculo();
    }
  }

  bool validarModelo() {
    return controllerModelo.text.isNotEmpty;
  }

  bool validarMarca() {
    return controllerMarca.text.isNotEmpty;
  }

  bool validarCor() {
    return controllerCor.text.isNotEmpty;
  }

  bool validarPlaca() {
    return controllerPlaca.text.isNotEmpty &&
        controllerPlaca.text.length > 7 &&
        controllerPlaca.text.length < 8;
  }

  bool validarRenavan() {
    return controllerRenavan.text.isNotEmpty &&
        controllerRenavan.text.length > 6 &&
        controllerRenavan.text.length < 15;
  }

  bool validarDocumentoDoVeiculo() {
    return documentoDoVeiculo.file != null;
  }

  meioDeTransporteSelecionado() {
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
            documentoDoVeiculo: documentoDoVeiculo);

      case 3:
        return Carro(
            modelo: controllerModelo.text,
            marca: controllerMarca.text,
            cor: controllerCor.text,
            placa: controllerPlaca.text,
            renavam: controllerRenavan.text,
            documentoDoVeiculo: documentoDoVeiculo);
    }
  }
}
