import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:levv4/biblioteca/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';
import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/dao/interface/i_crud_arquivo_dao.dart';

class ArquivoDAO
    with NomeDoDocumentoDoUsuarioCorrente
    implements ICrudArquivoDAO<Arquivo> {
  final collectionPath = "arquivos";

  static const fileSucessfullyUpload = "ArquivoDAO: file successfully upload!";
  static const fileErrorUpload = "ArquivoDAO: file erro upload!";

  static const fileSucessfullyDelete =
      "ArquivoDAO: file successfully upload delete!";
  static const fileErrorDelete = "ArquivoDAO: file erro upload delete!";

  @override
  Future<void> upload(Arquivo object) async {
    String path = object.file!.path;

    File file = File(path);

    if (file != null) {
      String reference =
          "$collectionPath/";
      reference += "${nomeDoDocumentoDoUsuarioCorrente()}/";
      reference += "${object.descricao!.replaceAll(" ", "")}/";
      reference += "${object.descricao}";
      reference += "${DateTime.now().toString()}.jpg";
      reference = reference.replaceAll(" ", "");

      try {
        await FirebaseStorage.instance.ref(reference).putFile(file);
        print("$fileSucessfullyUpload--> ${object.descricao}");
      } catch (erro) {
        print("$fileErrorUpload--> ${object.descricao}--> ${erro.toString()}");
      }
    }
  }

  @override
  Future<void> delete(Arquivo object) async {
    String reference = "$collectionPath/${object.descricao!.replaceAll(" ", "")}";
    reference += "${nomeDoDocumentoDoUsuarioCorrente()}/";
    reference += "${object.descricao!.replaceAll(" ", "")}/";
    reference += "${object.descricao}.jpg";
    reference = reference.replaceAll(" ", "");

    try {
      await FirebaseStorage.instance.ref(reference).delete();
      print("$fileSucessfullyDelete--> ${object.descricao}");
    } catch (erro) {
      print("$fileErrorDelete--> ${object.descricao}--> ${erro.toString()}");
    }
  }
}
