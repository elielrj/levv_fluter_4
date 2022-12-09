import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/dao/endereco/i_crud_endereco_dao.dart';


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
  Future<void> criar(Map<String, dynamic> object) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .set(toMapToMap(object))
        .then((value) => print(documentSucessfullyCreate),
            onError: (e) => print("$documentErrorCreate--> ${e.toString()}"));
  }

  @override
  Future<void> atualizar(Map<String, dynamic> object) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .update(toMapToMap(object))
        .then((value) => print(documentSucessfullyUpdate),
            onError: (e) => print("$documentErrorUpdate--> ${e.toString()}"));
  }

  @override
  Future<dynamic> buscarEnderecosDoUsuarioCorrente() async {
    Map<String, dynamic> listaDeMaps = {};

    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .get()
        .then(
      (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;

        listaDeMaps = fromMapFromMap(data);
        print(documentSucessfullyRetrive);
      },
      onError: (e) => print("$documentErrorRetrive--> ${e.toString()}"),
    );

    return listaDeMaps;
  }

  @override
  Future<void> deletar() async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(nomeDoDocumentoDoUsuarioCorrente())
        .delete()
        .then(
          (doc) => print(documentSucessfullyDelete),
          onError: (e) => print("$documentErrorDelete--> ${e.toString()}"),
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
