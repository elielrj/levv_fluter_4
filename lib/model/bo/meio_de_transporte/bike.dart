import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';

class Bike implements MeioDeTransporte{
  String? nome = "Bike";
  double? peso= 15;
  double? volume= 400;

  Bike({String? nome,double? peso,double? volume}){
    nome = nome;
    peso = peso;
    volume = volume;
  }

  @override
  exibirMeioDeTransporte() {
    return nome;
  }

}