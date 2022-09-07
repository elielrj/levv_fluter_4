import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/motorizado.dart';

class Moto extends Motorizado implements MeioDeTransporte{
  static const int VALUE = 2;
  String? nome= "Moto";
  double? peso= 20;
  double? volume= 1600;

  Moto(
      {String? modelo,
      String? marca,
      String? cor,
      String? placa,
      String? renavam,
      bool? documentoDoVeiculo,
        this.nome,
        this.peso,
        this.volume}): super(
            modelo: modelo,
            marca: marca,
            cor: cor,
            placa: placa,
            renavam: renavam,
            documentoDoVeiculo: documentoDoVeiculo
  ) {
    nome = nome;
    peso = peso;
    volume = volume;
  }

  @override
  exibirMeioDeTransporte() {
   return nome;
  }
}
