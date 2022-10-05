import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_banco_de_dados/bando_de_dados.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';

import '../../../api/firebase_auth/autenticacao.dart';
import 'i_crud_meio_de_transporte_dao.dart';

class BikeDAO
    implements ICrudMeioDeTransporteDAO<Bike> {
  final autenticacao = Autenticacao();
  final bancoDeDados = BancoDeDados();

  final collectionPath = "meios_de_transportes";

  @override
  Future<void> criar(Bike object) async {
    String documentName = autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .set(toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> atualizar(Bike object) async {
    String documentName = autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .update(toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<Bike?> buscarTodos() async {
    await bancoDeDados.db.collection(collectionPath).get().then(
      (res) {
        print("Successfully completed");
        return res.docs;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  Future<dynamic> retrive() async {

    String documentName = autenticacao. nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db.collection(collectionPath).doc(documentName).get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        return fromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Future<Bike?> buscarUmUsuarioPeloNomeDoDocumento(String reference) async {
    await bancoDeDados.db.collection(collectionPath).doc(reference).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        return fromMap(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Future<void> deletar(Bike object) async {
    String documentName = autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

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
  Map<String, dynamic> toMap(Bike object) {
    return {
      if (object.nome != null) "nome": object.nome,
      if (object.peso != null) "peso": object.peso,
      if (object.volume != null) "nome": object.volume
    };
  }

  @override
  Bike fromMap(Map<String, dynamic> map) {
    return Bike(
      nome: map["nome"],
      peso: map["peso"],
      volume: map["volume"],
    );
  }
}
