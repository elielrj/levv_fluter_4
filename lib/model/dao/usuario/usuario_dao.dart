import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/biblioteca/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/biblioteca/texto/text_banco_de_dados.dart';
import 'package:levv4/model/bo/acompanhar/acompanhar.dart';
import 'package:levv4/model/bo/administrar/administrar.dart';
import 'package:levv4/model/bo/entregar/entregar.dart';
import 'package:levv4/model/bo/enviar/enviar.dart';
import 'package:levv4/model/bo/perfil/perfil.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/arquivo/arquivo_dao.dart';
import 'package:levv4/model/dao/perfil/perfil_dao.dart';
import 'package:levv4/model/dao/usuario/enviar_dao.dart';

import 'interface_usuario_dao.dart';

class UsuarioDAO
    with NomeDoDocumentoDoUsuarioCorrente
    implements InterfaceUsuarioDAO<Usuario> {
  static const collectionPath = "usuarios";

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

  @override
  Future<void> criar(Usuario object) async {
    //final perfilDAO = PerfilDAO();
   // await perfilDAO.criar(object.perfil!);
    try {

      await _enviar(object.perfil!);

      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .set(object.toMap());

      print(documentSucessfullyCreate);
    } catch (erro) {
      print('$documentErrorCreate --> ${erro.toString()}');
    }
  }

  @override
  Future<void> atualizar(Usuario object) async {
    try {
      ///1.0 - Atualizar Objeto Perfil
     // final perfilDAO = PerfilDAO();

      ///1.1 - Buscar perfil anterior
      // Perfil perfil = await perfilDAO.buscar();

      ///1.2 - Deletar perfil anterior buscado
      // await perfilDAO.deletar(perfil);

      ///1.3 - Criar novo perfil
      // await perfilDAO.criar(usuario.perfil!);
     // await perfilDAO.atualizar(object.perfil!);

      await _enviar(object.perfil!);

      ///2.0 - Atualizar Objeto Usuario
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .update(object.toMap());
      print(documentSucessfullyCreate);
    } catch (erro) {
      print('$documentErrorCreate --> ${erro.toString()}');
    }
  }

  @override
  Future<List<Usuario>> buscarTodos() async {
    List<Usuario> usuarios = [];
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .get()
          .then((res) async {
        res.docs.map((e) async => usuarios.add(Usuario.fromMap(e.data())));
      });
      print(documentSucessfullyRetrive);
    } catch (erro) {
      print("$documentErrorRetriveAll --> $erro");
    }

    return usuarios;
  }

  @override
  Future<Usuario?> buscar() async {
    Usuario? usuario;

    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .get()
          .then((DocumentSnapshot doc) async {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          usuario = Usuario.fromMap(data);
          print("UsuarioDAO: docs.exist = true");
        } else {
          print("UsuarioDAO: dodocs.exist = false");
        }
      });
      print(documentSucessfullyRetrive);
    } catch (erro) {
      print('$documentErrorRetrive -->${erro.toString()}');
    }

    return usuario;
  }

  Future<Usuario?> buscarComDocumentReference(
      DocumentReference documentReference) async {
    Usuario? usuario;

    try {
      await documentReference.get().then((DocumentSnapshot doc) async {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          usuario = Usuario.fromMap(data);
          print("UsuarioDAO: docs.exist = true");
        } else {
          print("UsuarioDAO: dodocs.exist = false");
        }
      });
      print(documentSucessfullyRetrive);
    } catch (erro) {
      print('$documentErrorRetrive -->${erro.toString()}');
    }

    return usuario;
  }

  @override
  Future<void> deletar(Usuario object) async {
    try {
      //final perfilDAO = PerfilDAO();
     // await perfilDAO.deletar(object.perfil!);

      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .delete();
      print(documentSucessfullyDelete);
    } catch (erro) {
      print("$documentErrorDelete --> ${erro.toString()}");
    }
  }

  Future<void> _enviar(Perfil object) async {

    if(object is Enviar){
      final arquivoDAO = ArquivoDAO();
      await arquivoDAO.upload(object.documentoDeIdentificacao!);
    }else if(object is Entregar){
      final arquivoDAO = ArquivoDAO();
      await arquivoDAO.upload(object.documentoDeIdentificacao!);
    }

  }
}
