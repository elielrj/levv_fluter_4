import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';

@deprecated
class Carro extends Moto {
  static const VALUE = 3;

  Carro(
      {String nome = "Carro",
      int peso = 25,
      int volume = 3600,
      String? modelo,
      String? marca,
      String? cor,
      String? placa,
      String? renavam,
      Arquivo? documentoDoVeiculo})
      : super(
            nome: nome,
            peso: peso,
            volume: volume,
            modelo: modelo,
            marca: marca,
            cor: cor,
            placa: placa,
            renavam: renavam,
            documentoDoVeiculo: documentoDoVeiculo);

  @override
  String exibirMeioDeTransporte() {
    return nome!;
  }

  @override
  Map<String, dynamic> toMap() {
    return Map.from({
      'nome': nome,
      'peso': peso,
      'volume': volume,
      'modelo': modelo,
      'marca': marca,
      'cor': cor,
      'placa': placa,
      'renavam': renavam,
    });
  }

  factory Carro.fromMap(Map<String, dynamic> map) {
    return Carro(
      nome: map['nome'],
      peso: map['peso'],
      volume: map['volume'],
      modelo: map['modelo'],
      marca: map['marca'],
      cor: map['cor'],
      placa: map['placa'],
      renavam: map['renavam'],
    );
  }
}
