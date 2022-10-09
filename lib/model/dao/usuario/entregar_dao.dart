import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/autenticacao.dart';
import 'package:levv4/api/firebase_banco_de_dados/bando_de_dados.dart';
import 'package:levv4/model/dao/endereco/endereco_dao.dart';
import 'package:levv4/model/dao/meio_de_transporte/meio_de_transporte_dao.dart';

import '../../bo/endereco/endereco.dart';
import '../../bo/meio_de_transporte/meio_de_transporte.dart';
import '../../bo/usuario/perfil/enviar/entregar/entregar.dart';
import '../interface/i_crud_usuario_dao.dart';


class EntregarDAO with
    CreateMeioDeTransporteDAO,
    RetriveMeioDeTransporteDAO implements ICrudUsuarioDAO<Entregar>  {

  final bancoDeDados = BancoDeDados();
  final autenticacao = Autenticacao();
  final collectionPath = "entregar";

  @override
  Future<void> criar(Entregar object) async {

    String documentName = autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .set(await toMap(object))
        .then((value) => print("DocumentSnapshot successfully create!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<void> atualizar(Entregar object) async {
    String documentName = autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

    await bancoDeDados.db
        .collection(collectionPath)
        .doc(documentName)
        .update(await toMap(object))
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  Future<Entregar?> buscarTodos() async {
    //todo buscar todos, ver como fazer isso
    await bancoDeDados.db.collection(collectionPath).get().then(
      (res) {
        print("Successfully completed");
        return res.docs;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Future<Entregar> buscarUmUsuarioPeloNomeDoDocumento(String reference) async {

    var entregar;

      await bancoDeDados.db.collection(collectionPath).doc(reference).get().then(
            (DocumentSnapshot doc) {

          final data = doc.data() as Map<String, dynamic>;

          entregar = fromMap(data);
        },
        onError: (e) => print("Error getting document: $e"),
      );

    return entregar;
  }

  @override
  Future<void> deletar(Entregar object) async {
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
  Future<Map<String, dynamic>> toMap(Entregar object) async {

    //1
    Map<String,dynamic> listaEnderecos = {
      "favoritos": object.enderecosFavoritos,
      "casa": object.casa,
      "trabalho": object.trabalho,
    };

    //2
    final enderecoDAO = EnderecoDAO();
    await enderecoDAO.criar(listaEnderecos);

    //3
    await createMeioDeTransporteDAO(object.meioDeTransporte!);


    return {
      if (object.perfil != null) "perfil": object.perfil,
      if (object.nome != null) "nome": object.nome,
      if (object.sobrenome != null) "sobrenome": object.sobrenome,
      if (object.cpf != null) "cpf": object.cpf,
      if (object.nascimento != null) "nascimento": Timestamp.fromMillisecondsSinceEpoch(
          object.nascimento!.millisecondsSinceEpoch),
      if (object.documentoDeIdentificacao != null) "documentoDeIdentificacao": object.documentoDeIdentificacao,
      if (object.meioDeTransporte != null) "meio_de_transporte": object.meioDeTransporte!.exibirMeioDeTransporte()
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
    MeioDeTransporte meioDeTransporte = await retriveMeioDeTransporteDAO(map["meio_de_transporte"]);

    //4
    Timestamp timestamp = map["nascimento"];
    DateTime dateTime = timestamp.toDate();

    return Entregar(
      nome: map["nome"],
      sobrenome: map["sobrenome"],
      cpf: map["cpf"],
      nascimento:dateTime ,
      enderecosFavoritos: favoritos,
      casa: casa,
      trabalho: trabalho,
      documentoDeIdentificacao: map["documentoDeIdentificacao"],
      meioDeTransporte: meioDeTransporte,
    );
  }




}
