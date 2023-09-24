import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:levv4/biblioteca/firebase_autenticacao/mixin_nome_do_documento_do_usuario_corrente.dart';

class NumeradorDePedido with NomeDoDocumentoDoUsuarioCorrente {
  String converterEmMd5(String numeroDoPedido) {
    var bytes = utf8.encode(numeroDoPedido);

    var _md5 = md5.convert(bytes);

    return _md5.toString();
  }

  String criarNumeroDoPedido() =>
      DateTime.now()
          .toString()
          .replaceAll('-', '')
          .replaceAll(' ', '')
          .replaceAll(':', '')
          .replaceAll('.', '') +
      nomeDoDocumentoDoUsuarioCorrente().replaceAll('+', '');
}
