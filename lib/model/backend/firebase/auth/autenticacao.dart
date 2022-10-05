import 'package:firebase_auth/firebase_auth.dart';
import 'document_name_current_user.dart';

class Autenticacao with NomeDoDocumentoDoUsuarioCorrente {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;
}
