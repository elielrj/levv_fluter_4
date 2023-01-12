import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/motorizado.dart';

class Moto extends Motorizado {
  static const int VALUE = 2;

  Moto(
      {String nome = "Moto",
      int peso = 20,
      int volume = 1600,
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

  factory Moto.fromMap(Map<String, dynamic> map) {
    return Moto(
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
