import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';

class Bike implements MeioDeTransporte {
  static const VALUE = 1;
  static const nome = "Bike";
  static const peso = 15;
  static const volume = 400;

  @override
  exibirMeioDeTransporte() {
    return nome;
  }
}
