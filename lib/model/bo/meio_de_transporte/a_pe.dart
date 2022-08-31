import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';

class APe implements MeioDeTransporte{
  String? nome = "A pé";
  double? peso = 10;
  double? volume = 400;

  APe({String? nome,double? peso,double? volume}){
    nome = nome ;
    peso = peso ;
    volume = volume;
  }

  @override
  exibirMeioDeTransporte() {
    return nome;
  }

}