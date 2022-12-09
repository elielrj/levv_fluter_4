import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/bo/entregar/entregar.dart';
import 'package:levv4/model/bo/meio_de_transporte/carro.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';
import 'package:levv4/model/bo/meio_de_transporte/motorizado.dart';
import 'package:levv4/model/dao/arquivo/arquivo_dao.dart';
import 'package:levv4/model/dao/endereco/endereco_dao.dart';

import 'package:levv4/model/dao/meio_de_transporte/meio_de_transporte_dao.dart';
import 'package:levv4/model/dao/meio_de_transporte/moto/moto_dao.dart';
import 'package:levv4/model/dao/meio_de_transporte/motorizado/motorizado_dao.dart';
import '../../bo/endereco/endereco.dart';
import '../../bo/meio_de_transporte/meio_de_transporte.dart';
import 'interface_usuario_dao.dart';

class EntregarDAO
    with NomeDoDocumentoDoUsuarioCorrente
    implements InterfaceUsuarioDAO<Entregar> {
  final collectionPath = "entregar";

  static const documentSucessfullyCreate =
      "EntregarDAO: DocumentSnapshot successfully create!";
  static const documentSucessfullyUpdate =
      "EntregarDAO: DocumentSnapshot successfully update!";
  static const documentSucessfullyRetrive =
      "EntregarDAO: DocumentSnapshot successfully retrive!";
  static const documentSucessfullyRetriveAll =
      "EntregarDAO: DocumentSnapshot successfully retrive all!";
  static const documentSucessfullyDelete =
      "EntregarDAO: DocumentSnapshot successfully delete!";

  static const documentErrorCreate = "EntregarDAO: Error crete document!";
  static const documentErrorUpdate = "EntregarDAO: Error update document!";
  static const documentErrorRetrive = "EntregarDAO: Error retrive document!";
  static const documentErrorRetriveAll =
      "EntregarDAO: Error retrive all document!";
  static const documentErrorDelete = "EntregarDAO: Error delete document!";

  @override
  Future<void> criar(Entregar object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .set(await toMap(object))
          .then((value) => print(documentErrorCreate),
          onError: (e) =>
              print("$documentErrorCreate --> ${e.toString()}"));
      print(documentSucessfullyCreate);
    } catch (erro) {
      print("$documentErrorCreate--> ${erro.toString()}");
    }
  }

  @override
  Future<void> atualizar(Entregar object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .update(await toMap(object))
          .then((value) => print(documentSucessfullyUpdate),
          onError: (e) =>
              print("$documentErrorUpdate --> ${e.toString()}"));
      print(documentSucessfullyCreate);
    } catch (erro) {
      print("$documentErrorCreate--> ${erro.toString()}");
    }
  }

  @override
  Future<List<Entregar>> buscarTodos() async {
    List<Entregar> entregadoresDePedidos = [];
    try {
      await FirebaseFirestore.instance.collection(collectionPath).get().then(
            (res) {
          res.docs.map(
                  (e) async => entregadoresDePedidos.add(await fromMap(e.data())));
          print(documentSucessfullyRetriveAll);
        },
        onError: (e) => print("$documentErrorRetriveAll --> ${e.toString()}"),
      );
      print(documentSucessfullyCreate);
    } catch (erro) {
      print("$documentErrorCreate--> ${erro.toString()}");
    }
    return entregadoresDePedidos;
  }

  @override
  Future<Entregar> buscar() async {
    Entregar entregar = Entregar();
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .get()
          .then(
            (DocumentSnapshot doc) async {
          final data = doc.data() as Map<String, dynamic>;

          entregar = await fromMap(data);
          print(documentSucessfullyRetrive);
        },
        onError: (e) => print("$documentErrorRetrive --> ${e.toString()}"),
      );
      print(documentSucessfullyCreate);
    } catch (erro) {
      print("$documentErrorCreate--> ${erro.toString()}");
    }
    return entregar;
  }

  @override
  Future<void> deletar(Entregar object) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .delete()
          .then(
            (doc) => print(documentSucessfullyDelete),
        onError: (e) => print("$documentErrorDelete --> ${e.toString()}"),
      );
      print(documentSucessfullyCreate);
    } catch (erro) {
      print("$documentErrorCreate--> ${erro.toString()}");
    }
  }

  @override
  Future<Map<String, dynamic>> toMap(Entregar object) async {
    //1
    Map<String, dynamic> listaEnderecos = {
      "favoritos": object.enderecosFavoritos,
      "casa": object.casa,
      "trabalho": object.trabalho,
    };

    //2
    final enderecoDAO = EnderecoDAO();
    await enderecoDAO.criar(listaEnderecos);

    //3
    final meioDeTransporteDAO = MeioDeTransporteDAO();
    await meioDeTransporteDAO.criar(object.meioDeTransporte!);

    //4
    final arquivoDAO = ArquivoDAO();
    await arquivoDAO.upload(object.documentoDeIdentificacao!);



    return {
      if (object.exibirPerfil() != null) "perfil": object.exibirPerfil(),
      if (object.nome != null) "nome": object.nome,
      if (object.sobrenome != null) "sobrenome": object.sobrenome,
      if (object.cpf != null) "cpf": object.cpf,
      if (object.nascimento != null)
        "nascimento": Timestamp.fromMillisecondsSinceEpoch(
            object.nascimento!.millisecondsSinceEpoch),
      if (object.documentoDeIdentificacao != null)
        "documentoDeIdentificacao": object.documentoDeIdentificacao,
      if (object.meioDeTransporte != null)
        "meio_de_transporte": object.meioDeTransporte!.exibirMeioDeTransporte()
    };
  }

  @override
  Future<Entregar> fromMap(Map<String, dynamic> map) async {
    //1
    final enderecoDAO = EnderecoDAO();
    final enderecos = await enderecoDAO.buscarEnderecosDoUsuarioCorrente();

    //2
    Endereco casa = enderecos['casa'];
    Endereco trabalho = enderecos['trabalho'];
    List<Endereco> favoritos = enderecos['favoritos'];

    //3
    final meioDeTransporteDAO = MeioDeTransporteDAO();
    final meioDeTransporte =
    await meioDeTransporteDAO.buscar(map["meio_de_transporte"]);

    //4
    Timestamp timestamp = map["nascimento"];
    DateTime dateTime = timestamp.toDate();

    //5 Arquivo, não busca


    return Entregar(
      nome: map["nome"],
      sobrenome: map["sobrenome"],
      cpf: map["cpf"],
      nascimento: dateTime,
      enderecosFavoritos: favoritos,
      casa: casa,
      trabalho: trabalho,
      meioDeTransporte: meioDeTransporte,
    );
  }
}
