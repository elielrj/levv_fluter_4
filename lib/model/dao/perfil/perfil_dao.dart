import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/bo/acompanhar/acompanhar.dart';
import 'package:levv4/model/bo/perfil/perfil.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/perfil/interface_perfil_dao.dart';
import 'package:levv4/model/dao/perfil/mixin_criar_objeto_perfil_com_map.dart';
import 'package:levv4/model/dao/perfil/mixin_deletar_perfil.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';

import 'mixin_criar_perfil.dart';

class PerfilDAO
    with
        CriarPerfil,
        DeletePerfil,
        NomeDoDocumentoDoUsuarioCorrente,
        CriarObjetoPerfilComMap
    implements InterfacePerfilDAO {
  static const documentSucessfullyCreate =
      "UsuarioDAO: DocumentSnapshot successfully create!";
  static const documentSucessfullyUpdate =
      "UsuarioDAO: DocumentSnapshot successfully update!";
  static const documentSucessfullyRetrive =
      "UsuarioDAO: DocumentSnapshot successfully retrive!";
  static const documentSucessfullyRetriveAll =
      "UsuarioDAO: DocumentSnapshot successfully retrive all!";
  static const documentSucessfullyDelete =
      "UsuarioDAO: DocumentSnapshot successfully delete!";

  static const documentErrorCreate = "UsuarioDAO: Error crete document!";
  static const documentErrorUpdate = "UsuarioDAO: Error update document!";
  static const documentErrorRetrive = "UsuarioDAO: Error retrive document!";
  static const documentErrorRetriveAll =
      "UsuarioDAO: Error retrive all document!";
  static const documentErrorDelete = "UsuarioDAO: Error delete document!";

  static const documenteErrorRetrive = "Error retrive document!";

  @override
  Future<void> criar(Perfil perfil) async {
    try {
      await createPerfil(perfil);
      print(documentSucessfullyCreate);
    } catch (erro) {
      print("$documentErrorUpdate--> ${erro.toString()}");
    }
  }

  @override
  Future<void> atualizar(Perfil perfil) async {
    try {
      Perfil perfilAnterior = await buscar();

      await deletePerfil(perfilAnterior);

      await criar(perfil);
      print(documentSucessfullyUpdate);
    } catch (erro) {
      print("$documentErrorUpdate--> ${erro.toString()}");
    }
  }

  @override
  Future<Perfil> buscar() async {
    Perfil perfil = Acompanhar();

    try {
      DocumentReference documentReference = FirebaseFirestore.instance.doc(
          '${UsuarioDAO.collectionPath}/${nomeDoDocumentoDoUsuarioCorrente()}');

      await documentReference.get().then((doc) async {
        if(doc.exists){
          final data = doc.data() as Map<String, dynamic>;
          perfil = await buscarComDocumentReference(data['perfil']);
          print("$documentSucessfullyRetrive--> exists = true");
        }else{
          print("$documentErrorRetrive--> exists = false");
        }

      });

      print(documentSucessfullyRetrive);
    } catch (erro) {
      print("$documentErrorRetrive--> ${erro.toString()}");
    }

    return perfil;
  }

  @override
  Future<Perfil> buscarComDocumentReference(
      DocumentReference documentReference) async {
    Perfil perfil = Acompanhar();
    try {
      await documentReference.get().then((DocumentSnapshot doc) async {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;

          print("PerfilDAO: document exists = true");

          perfil = await toMapComPerfil(data, data["perfil"]);
        } else {
          print("PerfilDAO: document exists = false");

          final usuarioDAO = UsuarioDAO();
          await usuarioDAO.criar(Usuario(
            celular: nomeDoDocumentoDoUsuarioCorrente(),
            perfil: perfil,
          ));
        }
      });
      print(documentSucessfullyRetrive);
    } catch (erro) {
      print("$documenteErrorRetrive --> ${erro.toString()}}");
    }

    return perfil;
  }

  @override
  Future<void> deletar(Perfil perfil) async {
    try {
      await deletePerfil(perfil);
      print(documentSucessfullyDelete);
    } catch (erro) {
      print("$documentSucessfullyDelete--> ${erro.toString()}");
    }
  }
}
