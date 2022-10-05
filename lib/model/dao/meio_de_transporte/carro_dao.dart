import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:levv4/model/backend/firebase/auth/document_name_current_user.dart';
import 'package:levv4/model/backend/firebase/firestore/bando_de_dados.dart';
import 'package:levv4/model/backend/firebase/firestore/interface/crud_firebase_firestore.dart';

import '../../backend/firebase/auth/autenticacao.dart';
import '../../bo/meio_de_transporte/carro.dart';


class CarroDAO with NomeDoDocumentoDoUsuarioCorrente implements CrudFirebaseFirestore<Carro> {

  final autenticacao = Autenticacao();
  final bancoDeDados = BancoDeDados(FirebaseFirestore.instance);

  final collectionPath = "meios_de_transportes";

  @override
  Future<void> create(Carro object) async {

    String documentName =  nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .set(toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> update(Carro object) async {

    String documentName =  nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .update(toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  Future<dynamic> retrive() async {

    String documentName =  nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db.collection(collectionPath).doc(documentName).get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        return fromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Future<Carro?> retriveAll() async {
    await bancoDeDados.db.collection(collectionPath).get().then(
      (res) {
        print("Successfully completed");
        return res.docs;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Future<Carro?> searchByReference(String reference) async {
    await bancoDeDados.db.collection(collectionPath).doc(reference).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        return fromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Future<void> delete(Carro object) async {

    String documentName =  nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

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
  Map<String, dynamic> toMap(Carro object) {
    return {
      if (object.modelo != null) "modelo": object.modelo,
      if (object.marca != null) "marca": object.marca,
      if (object.cor != null) "cor": object.cor,
      if (object.placa != null) "placa": object.placa,
      if (object.renavam != null) "renavam": object.renavam,
      if (object.documentoDoVeiculo != null) "documentoDoVeiculo": object.documentoDoVeiculo,
      if (object.nome != null) "nome": object.nome,
      if (object.peso != null) "peso": object.peso,
      if (object.volume != null) "nome": object.volume
    };
  }

  @override
  Carro fromMap(Map<String, dynamic> map) {

    return Carro(
      modelo: map["modelo"],
      marca: map["marca"],
      cor: map["cor"],
      placa: map["placa"],
      renavam: map["renavam"],
      documentoDoVeiculo: map["documentoDoVeiculo"],
      nome: map["nome"],
      peso: map["peso"],
      volume: map["volume"],
    );

  }
}
