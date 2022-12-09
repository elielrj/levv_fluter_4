import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/motorizado.dart';

class Carro extends Motorizado implements MeioDeTransporte {
  static const VALUE = 3;
  static const nome = "Carro";
  static const peso = 25;
  static const volume = 3600;

  Carro(
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
