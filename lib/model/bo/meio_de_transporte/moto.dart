import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/motorizado.dart';

class Moto extends Motorizado implements MeioDeTransporte {
  static const int VALUE = 2;
  static const nome = "Moto";
  static const peso = 20;
  static const volume = 1600;

  Moto(
      {String? modelo,
      String? marca,
      String? cor,
      String? placa,
      String? renavam,
      Arquivo? documentoDoVeiculo})
      : super(
            modelo: modelo,
            marca: marca,
            cor: cor,
            placa: placa,
            renavam: renavam,
            documentoDoVeiculo: documentoDoVeiculo);

  @override
  String exibirMeioDeTransporte() {
    return nome;
  }
}
