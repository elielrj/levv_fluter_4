import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/biblioteca/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/dao/endereco/i_crud_endereco_dao.dart';
/*
class EnderecoDAO
    with NomeDoDocumentoDoUsuarioCorrente
    implements ICrudEnderecoDAO<Endereco> {
  final collectionPath = "enderecos";

  static const documentSucessfullyCreate =
      "EnderecoDAO: DocumentSnapshot successfully create!";
  static const documentSucessfullyUpdate =
      "EnderecoDAO: DocumentSnapshot successfully update!";
  static const documentSucessfullyRetrive =
      "EnderecoDAO: DocumentSnapshot successfully retrive!";
  static const documentSucessfullyRetriveAll =
      "EnderecoDAO: DocumentSnapshot successfully retrive all!";
  static const documentSucessfullyDelete =
      "EnderecoDAO: DocumentSnapshot successfully delete!";

  static const documentErrorCreate = "EnderecoDAO: Error crete document!";
  static const documentErrorUpdate = "EnderecoDAO: Error update document!";
  static const documentErrorRetrive = "EnderecoDAO: Error retrive document!";
  static const documentErrorRetriveAll =
      "EnderecoDAO: Error retrive all document!";
  static const documentErrorDelete = "EnderecoDAO: Error delete document!";

  @override
  Future<void> criar(Endereco object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .set(object.toMap());
      print(documentSucessfullyCreate);
    } catch (erro) {
      print("$documentErrorCreate--> ${erro.toString()}");
    }
  }

  @override
  Future<void> atualizar(Endereco object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .update(object.toMap());
      print(documentSucessfullyUpdate);
    } catch (erro) {
      print("$documentErrorUpdate--> ${erro.toString()}");
    }
  }

  @override
  Future<List<Endereco>> buscarEnderecosDoUsuarioCorrente() async {
    Map<String, dynamic> listaDeMaps = {};

    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .get()
          .then((DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;


        listaDeMaps = fromMapFromMap();
        print(documentSucessfullyRetrive);
      });
    } catch (erro) {
      print("$documentErrorRetrive--> ${erro.toString()}");
    }

    return listaDeMaps;
  }

  @override
  Future<void> deletar() async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .delete();
      print(documentSucessfullyDelete);
    } catch (erro) {
      print("$documentErrorDelete--> ${erro.toString()}");
    }
  }

  @override
  Map<String, Map<String, dynamic>> toMapToMap(Map<String, dynamic> object) {
    return {
      if(object['casa'] != null ) "casa": toMap(object['casa']),
      if(object['trabalho'] != null && object['trabalho'] is Endereco) "trabalho": toMap(object['trabalho']),
      if(object['favoritos'] != null && object['favoritos'] is Endereco) "favoritos": favoritosToMap(object['favoritos'])
    };
  }

  @override
  Map<String, dynamic> fromMapFromMap(Map<String, dynamic> map) {
    Endereco? casa = fromMap(map["casa"]);
    Endereco? trabalho = fromMap(map['trabalho']);
    //List<Endereco> favoritos = favoritosFromMap(map['favoritos']);

    List<Endereco>? favoritos =
        map['favoritos'] is Iterable ? List.from(map['favoritos']) : [];

    return {
      if(casa != null) 'casa': casa,
      if(trabalho != null) 'trabalho': trabalho,
      if(favoritos != null) 'favoritos': favoritos,
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


}
*/