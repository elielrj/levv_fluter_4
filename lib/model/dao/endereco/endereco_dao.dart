import 'dart:async';

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/api/firebase_auth/autenticacao.dart';
import 'package:levv4/api/firebase_banco_de_dados/bando_de_dados.dart';
import 'package:levv4/model/dao/interface/i_crud_endereco_dao.dart';

class EnderecoDAO implements ICrudEnderecoDAO<Endereco> {
  final bancoDeDados = BancoDeDados();

  final autenticacao = Autenticacao();

  final collectionPath = "enderecos";

  @override
  Future<void> criar(Map<String, dynamic> object) async {
    String documentName = autenticacao
        .nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .set(toMapToMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> atualizar(Map<String, dynamic> object) async {
    String documentName = autenticacao
        .nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .update(toMapToMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<dynamic> buscarEnderecosDoUsuarioCorrente() async {
    String documentName = autenticacao
        .nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    Map<String, dynamic> listaDeMaps = {};

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .get()
        .then(
      (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;

        listaDeMaps = fromMapFromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );

    return listaDeMaps;
  }

  @override
  Future<void> deletar() async {
    String documentName = autenticacao
        .nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  @override
  Map<String, Map<String, dynamic>> toMapToMap(Map<String, dynamic> object) {
    return {
      "casa": toMap(object['casa']),
      "trabalho": toMap(object['trabalho']),
      "favoritos": favoritosToMap(object['favoritos'])
    };
  }

  @override
  Map<String, dynamic> fromMapFromMap(Map<String, dynamic> map) {
    Endereco casa = fromMap(map["casa"]);
    Endereco trabalho = fromMap(map['trabalho']);
    //List<Endereco> favoritos = favoritosFromMap(map['favoritos']);

    List<Endereco>? favoritos =
        map['favoritos'] is Iterable ? List.from(map['favoritos']) : [];

    return {
      'casa': casa,
      'trabalho': trabalho,
      'favoritos': favoritos,
    };
  }

  @override
  Map<String, dynamic> favoritosToMap(List<Endereco> listaDeEnderecos) {
    Map<String, dynamic> mapDeFavoritos = {};

    for (Endereco endereco in listaDeEnderecos) {
      mapDeFavoritos.addAll(toMap(endereco));
    }

    return mapDeFavoritos;
  }

  @override
  Map<String, dynamic> toMap(Endereco object) {
    return {
      if (object.logradouro != null) "logradouro": object.logradouro,
      if (object.numero != null) "numero": object.numero,
      if (object.complemento != null) "complemento": object.complemento,
      if (object.cep != null) "cep": object.cep,
      if (object.geolocalizacao != null)
        "geolocalizacao": object.geolocalizacao,
      if (object.bairro != null) "bairro": object.bairro,
      if (object.cidade != null) "cidade": object.cidade,
      if (object.estado != null) "estado": object.estado,
      if (object.pais != null) "pais": object.pais
    };
  }

  @override
  Endereco fromMap(Map<String, dynamic> map) {
    return Endereco(
      logradouro: map["logradouro"],
      numero: map["numero"],
      complemento: map["complemento"],
      cep: map["cep"],
      geolocalizacao: map["geolocalizacao"],
      bairro: map["bairro"],
      cidade: map["cidade"],
      estado: map["estado"],
      pais: map["pais"],
    );
  }
}
