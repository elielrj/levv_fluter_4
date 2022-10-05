import 'package:firebase_auth/firebase_auth.dart';

import 'mixin_codigo_de_erro_do_firebase_auth.dart';
import 'mixin_nome_do_documento_do_usuario_corrente.dart';


class Autenticacao with NomeDoDocumentoDoUsuarioCorrente, CodigoDeErroDoFirebaseAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;
}
