import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/dao/arquivo/arquivo_dao.dart';
import '../arquivo/arquivo.dart';
import 'a_pe.dart';

abstract class Motorizado {

   String? modelo;
   String? marca;
   String? cor;
   String? placa;
   String? renavam;
   bool? documentoDoVeiculo;

   Motorizado(
      {this.modelo,
      this.marca,
      this.cor,
      this.placa,
      this.renavam,
      this.documentoDoVeiculo
      });

   cadastrarDocumentoDoVeiculoFromGallery() async {

      final arquivo = Arquivo(descricao: "documentoDoVeiculo");

      arquivo.image = await arquivo.getImageGallery();

      final arquivoDAO = ArquivoDAO();

      await arquivoDAO.upload(arquivo);
   }

   cadastrarDocumentoDoVeiculoFromCamera() async {

      final arquivo = Arquivo(descricao: "documentoDoVeiculo");

      arquivo.image = await arquivo.getImageCamera();

      final arquivoDAO = ArquivoDAO();

      await arquivoDAO.upload(arquivo);
   }


}
