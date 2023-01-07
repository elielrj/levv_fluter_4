import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';

class APe implements MeioDeTransporte {
  static const VALUE = 0;
  String? nome;
  int? peso;
  int? volume;

  APe({
    String? nome = "A pé",
    int? peso = 10,
    int? volume = 400,
  });

  @override
  String exibirMeioDeTransporte() {
    return nome!;
  }

  @override
  Map<dynamic, dynamic> toMap() {
    return Map.from({
      'nome': nome,
      'peso': peso,
      'volume': volume,
    });
  }

  factory APe.fromMap(Map<dynamic, dynamic> map) {
    return APe(
      nome: map['nome'],
      peso: map['peso'],
      volume: map['volume'],
    );
  }
}
