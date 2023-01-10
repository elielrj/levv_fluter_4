import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';

class Bike extends APe {
  static const VALUE = 1;

  Bike({String nome = "Bike", int peso = 15, int volume = 400})
      : super(
          nome: nome,
          peso: peso,
          volume: volume,
        );

  @override
  exibirMeioDeTransporte() {
    return nome!;
  }

  @override
  Map<String, dynamic> toMap() {
    return Map.from({
      'nome': nome,
      'peso': peso,
      'volume': volume,
    });
  }

  factory Bike.fromMap(Map<String, dynamic> map) {
    return Bike(
      nome: map['nome'],
      peso: map['peso'],
      volume: map['volume'],
    );
  }
}
