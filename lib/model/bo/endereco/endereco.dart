import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/model/bo/map/interface_map.dart';

class Endereco implements InterfaceMap {
  static const MARCO_ZERO = GeoPoint(0.0, 0.0);
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
      this.pais}) {
    logradouro ??= "";
    numero ??= "";
    complemento ??= "";
    cep ??= "";
    geolocalizacao ??= const GeoPoint(0.0, 0.0);
    bairro ??= "";
    cidade ??= "";
    estado ??= "";
    pais ??= "";
  }

  @override
  String toString() {
    return "$logradouro, $numero${complementoToString()}\n$bairro, $cidade/$estado, $pais\nCEP $cep";
  }

  String complementoToString() {
    if (complemento == "" || complemento == null) {
      return "";
    } else {
      return ", Compl $complemento";
    }
  }

  void limpar() {
    logradouro = null;
    numero = null;
    complemento = null;
    cep = null;
    geolocalizacao = const GeoPoint(0.0, 0.0);
    bairro = null;
    cidade = null;
    estado = null;
    pais = null;
  }

  @override
  Map<String, dynamic> toMap() {
    return Map.from({
      if (logradouro != null) "logradouro": logradouro,
      if (numero != null) "numero": numero,
      if (complemento != null) "complemento": complemento,
      if (cep != null) "cep": cep,
      if (geolocalizacao != null) "geolocalizacao": geolocalizacao,
      if (bairro != null) "bairro": bairro,
      if (cidade != null) "cidade": cidade,
      if (estado != null) "estado": estado,
      if (pais != null) "pais": pais,
    });
  }

  factory Endereco.fromMap(Map<String, dynamic> map) {
    return Endereco(
      logradouro: map['logradouro'],
      numero: map['numero'],
      complemento: map['complemento'],
      cep: map['cep'],
      geolocalizacao: map['geolocalizacao'],
      bairro: map['bairro'],
      cidade: map['cidade'],
      estado: map['estado'],
      pais: map['pais'],
    );
  }
}
