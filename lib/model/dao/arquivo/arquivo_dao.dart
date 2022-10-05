import 'dart:io';
import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/api/firebase_auth/autenticacao.dart';
import 'package:levv4/model/backend/firebase/storage/bando_de_arquivos.dart';
import 'package:levv4/model/backend/firebase/storage/interface/crud_firebase_store.dart';

class ArquivoDAO  implements CrudFirebaseStore<Arquivo> {
  final bancoDeArquivos = BancoDeArquivos();

  final autenticacao = Autenticacao();

  final collectionPath = "arquivos";

  @override
  Future<void> upload(Arquivo object) async {

    String path = object.image!.path;

    File file = File(path);

    if (file != null) {
      String documentName = autenticacao.nomeDoDocumentoDoUsuarioCorrente(autenticacao.auth.currentUser!);

      String reference = "$collectionPath/$documentName/${object.descricao}.jpg";

      await bancoDeArquivos
          .storage
          .ref(reference)
          .putFile(file)
          .then((p0) => print("sucess upload storage"))
          .onError((error, stackTrace) => print("Erro no upload: ${error}"));
    }
  }

  @override
  Future<void> delete(Arquivo object) async {
    String? celular = autenticacao.auth.currentUser!.phoneNumber;

    String reference = "$collectionPath/$celular/${object.descricao}.jpg";

    await bancoDeArquivos.storage
        .ref(reference)
        .delete()
        .then((value) => print("sucess ao deletar!"))
        .onError((error, stackTrace) => print("erro ao deletar: $error"));
  }
}
