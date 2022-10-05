import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'document_name_current_user.dart';

//todo mudar o nome do arquivo
//todo add mixin error e currentUser
class Autenticacao with NomeDoDocumentoDoUsuarioCorrente{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;
}
