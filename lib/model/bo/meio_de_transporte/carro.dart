import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/motorizado.dart';

class Carro extends Motorizado  implements MeioDeTransporte{
  String? nome= "Carro";
  double? peso= 25;
  double? volume= 3600;

  Carro(
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
