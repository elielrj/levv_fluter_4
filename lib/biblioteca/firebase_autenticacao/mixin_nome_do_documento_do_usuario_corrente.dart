import 'package:firebase_auth/firebase_auth.dart';

mixin NomeDoDocumentoDoUsuarioCorrente {
  String nomeDoDocumentoDoUsuarioCorrente() {
    var celular = FirebaseAuth.instance.currentUser?.phoneNumber;
    var email = FirebaseAuth.instance.currentUser?.email;

    String documentName = "";

    if (celular != null && celular != "") {
      documentName = celular.toString();
    }
    if (email != null && email != "") {
      documentName = email.toString();
    }

    return documentName;
  }
}
