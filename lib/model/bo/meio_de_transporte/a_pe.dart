import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';

class APe implements MeioDeTransporte {
  static const VALUE = 0;
  static const nome = "A pé";
  static const peso = 10;
  static const volume = 400;

  @override
  String exibirMeioDeTransporte() {
    return nome;
  }
}
