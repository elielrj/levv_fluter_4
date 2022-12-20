import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/api/texto/text_banco_de_dados.dart';
import 'package:levv4/model/bo/perfil/perfil.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/perfil/perfil_dao.dart';

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
  Future<void> criar(Usuario usuario) async {
    final perfilDAO = PerfilDAO();
    await perfilDAO.criar(usuario.perfil!);
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .set(await toMap(usuario));
      print(documentSucessfullyCreate);
    } catch (erro) {
      print('$documentErrorCreate --> ${erro.toString()}');
    }
  }

  @override
  Future<void> atualizar(Usuario usuario) async {
    try {
      ///1.0 - Atualizar Objeto Perfil
      final perfilDAO = PerfilDAO();

      ///1.1 - Buscar perfil anterior
      // Perfil perfil = await perfilDAO.buscar();

      ///1.2 - Deletar perfil anterior buscado
      // await perfilDAO.deletar(perfil);

      ///1.3 - Criar novo perfil
      // await perfilDAO.criar(usuario.perfil!);
      await perfilDAO.atualizar(usuario.perfil!);

      ///2.0 - Atualizar Objeto Usuario
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .update(await toMap(usuario));
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
        res.docs.map((e) async => usuarios.add(await fromMap(e.data())));
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
          usuario = await fromMap(data);
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
      final perfilDAO = PerfilDAO();
      await perfilDAO.deletar(object.perfil!);

      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(nomeDoDocumentoDoUsuarioCorrente())
          .delete();
      print(documentSucessfullyDelete);
    } catch (erro) {
      print("$documentErrorDelete --> ${erro.toString()}");
    }
  }

  @override
  Future<Map<String, dynamic>> toMap(Usuario object) async {
    DocumentReference documentReference = FirebaseFirestore.instance.doc(
        "${object.perfil!.exibirPerfil().toString().toLowerCase()}/${object.celular}");

    return {
      if (object.celular != null) TextBancoDeDados.CELULAR: object.celular,
      if (object.perfil != null) TextBancoDeDados.PERFIL: documentReference,
    };
  }

  @override
  Future<Usuario> fromMap(Map<String, dynamic> map) async {
    final perfilDAO = PerfilDAO();
    Perfil perfil = await perfilDAO
        .buscarComDocumentReference(map[TextBancoDeDados.PERFIL]);

    return Usuario(
      celular: map[TextBancoDeDados.CELULAR],
      perfil: perfil,
      listaDePedidos: null,
    );
  }
}
