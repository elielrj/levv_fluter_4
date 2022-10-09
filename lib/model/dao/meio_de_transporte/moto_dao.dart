import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_banco_de_dados/bando_de_dados.dart';
import '../../../api/firebase_autenticacao/autenticacao.dart';
import '../../bo/meio_de_transporte/moto.dart';
import '../interface/i_crud_meio_de_transporte_dao.dart';


class MotoDAO  implements ICrudMeioDeTransporteDAO<Moto> {

  final autenticacao = Autenticacao();
  final bancoDeDados = BancoDeDados();

  final collectionPath = "meios_de_transportes";

  @override
  Future<void> criar(Moto object) async {

    String documentName =  autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .set(toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> atualizar(Moto object) async {

    String documentName =  autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .update(toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  Future<dynamic> retrive() async {

    String documentName =  autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db.collection(collectionPath).doc(documentName).get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        return fromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Future<Moto?> buscarTodos() async {

    await bancoDeDados.db.collection(collectionPath).get().then(
      (res) {
        print("Successfully completed");
        return res.docs;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Future<Moto?> buscarUmUsuarioPeloNomeDoDocumento(String reference) async {
    await bancoDeDados.db.collection(collectionPath).doc(reference).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        return fromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Future<void> deletar(Moto object) async {

    String documentName =  autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

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
  Map<String, dynamic> toMap(Moto object) {
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
  Moto fromMap(Map<String, dynamic> map) {

    return Moto(
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
