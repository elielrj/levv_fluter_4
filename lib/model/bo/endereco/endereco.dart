

import 'package:cloud_firestore/cloud_firestore.dart';

class Endereco{
  String? logradouro;
  String? numero;
  String? complemento;
  String? cep;
  GeoPoint? geolocalizacao;
  String? bairro;
  String? cidade;
  String? estado;

  Endereco(
      {this.logradouro,
      this.numero,
      this.complemento,
      this.cep,
      this.geolocalizacao,
      this.bairro,
      this.cidade,
      this.estado}){
    logradouro??= "";
    numero ??=  "";
    complemento ??= "";
    cep ??= "";
    geolocalizacao ??=  GeoPoint(0, 0);
    bairro ??=  "";
    cidade??=  "";
    estado ??=  "";
  }

  @override
  String toString() {
    return "$logradouro, $numero${complementoToString()}\n$bairro, $cidade/$estado\nCEP $cep";
  }

  String complementoToString(){
    if(complemento == "" || complemento == null){
      return "";
    }  else{
      return ", Compl $complemento";
    }
  }
}