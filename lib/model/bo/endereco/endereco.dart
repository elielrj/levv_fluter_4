

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
  String? pais;

  Endereco(
      {this.logradouro,
      this.numero,
      this.complemento,
      this.cep,
      this.geolocalizacao,
      this.bairro,
      this.cidade,
      this.estado,
      this.pais}){
    logradouro??= "";
    numero ??=  "";
    complemento ??= "";
    cep ??= "";
    geolocalizacao ??=  const GeoPoint(0.0, 0.0);
    bairro ??=  "";
    cidade??=  "";
    estado ??=  "";
    pais ??=  "";
  }

  @override
  String toString() {
    return "$logradouro, $numero${complementoToString()}\n$bairro, $cidade/$estado, $pais\nCEP $cep";
  }

  String complementoToString(){
    if(complemento == "" || complemento == null){
      return "";
    }  else{
      return ", Compl $complemento";
    }
  }

  void limpar(){
    logradouro = null;
    numero =  null;
    complemento = null;
    cep = null;
    geolocalizacao =  const GeoPoint(0.0, 0.0);
    bairro =  null;
    cidade =  null;
    estado =  null;
    pais =  null;
  }
}