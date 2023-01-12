import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';

class APe implements MeioDeTransporte {
  static const VALUE = 0;
  String nome;
  int peso;
  int volume;

  APe({
    this.nome = "A pé",
    this.peso = 10,
    this.volume = 400,
  }) ;

  @override
  String exibirMeioDeTransporte() {
    return nome;
  }

  @override
  Map<String, dynamic> toMap() {
    return Map.from({
      'nome': nome,
      'peso': peso,
      'volume': volume,
    });
  }

  factory APe.fromMap(Map<String, dynamic> map) {
    return APe(
      nome: map['nome'],
      peso: map['peso'],
      volume: map['volume'],
    );
  }
}
