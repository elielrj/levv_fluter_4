import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/dao/arquivo/arquivo_dao.dart';
import '../arquivo/arquivo.dart';
import 'a_pe.dart';

@deprecated
abstract class Motorizado extends Bike{
  String? modelo;
  String? marca;
  String? cor;
  String? placa;
  String? renavam;
  Arquivo? documentoDoVeiculo;

  Motorizado(
      {
        String nome = '',
        int peso = 0,
        int volume = 0,
        this.modelo,
      this.marca,
      this.cor,
      this.placa,
      this.renavam,
      this.documentoDoVeiculo}):super(
    nome: nome,
    peso: peso,
    volume: volume,
  );

  void cadastrarDocumentoDoVeiculoFromGallery() async {
    documentoDoVeiculo = Arquivo(descricao: "documentoDoVeiculo");

    await documentoDoVeiculo!.getImageGallery();
  }

  void cadastrarDocumentoDoVeiculoFromCamera() async {
    documentoDoVeiculo = Arquivo(descricao: "documentoDoVeiculo");

    await documentoDoVeiculo!.getImageCamera();
  }
}
