import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:levv4/api/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/dao/interface/i_crud_arquivo_dao.dart';

class ArquivoDAO
    with NomeDoDocumentoDoUsuarioCorrente
    implements ICrudArquivoDAO<Arquivo> {
  final collectionPath = "arquivos";

  static const fileSucessfullyUpload = "ArquivoDAO: file successfully upload!";
  static const fileErrorUpload = "ArquivoDAO: file erro upload!";

  static const fileSucessfullyDelete =       "ArquivoDAO: file successfully upload delete!";
  static const fileErrorDelete =       "ArquivoDAO: file erro upload delete!";

  @override
  Future<void> upload(Arquivo object) async {
    String path = object.file!.path;

    File file = File(path);

    if (file != null) {
      String reference =
          "$collectionPath/${nomeDoDocumentoDoUsuarioCorrente()}/${object.descricao}${DateTime.now().toString()}.jpg";

      await FirebaseStorage.instance
          .ref(reference)
          .putFile(file)
          .then((p0) => print(fileSucessfullyUpload))
          .onError((error, stackTrace) => print("$fileErrorUpload--> ${error.toString()}"));
    }
  }

  @override
  Future<void> delete(Arquivo object) async {
    String reference =
        "$collectionPath/${nomeDoDocumentoDoUsuarioCorrente()}/${object.descricao}.jpg";

    await FirebaseStorage.instance
        .ref(reference)
        .delete()
        .then((value) => print(fileSucessfullyDelete))
        .onError((error, stackTrace) => print("$fileErrorDelete ${error.toString()}"));
  }
}
