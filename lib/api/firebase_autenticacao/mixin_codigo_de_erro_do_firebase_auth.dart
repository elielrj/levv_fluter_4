import 'package:firebase_auth/firebase_auth.dart';

mixin CodigoDeErroDoFirebaseAuth {
  codigoDeErro(FirebaseAuthException e) {
    switch (e.code) {
      case "quotaExceeded":
        print('CodigoDeErroDoFirebaseAuth--> quotaExceeded.');
        break;
      case "invalid-phone-number":
        print('CodigoDeErroDoFirebaseAuth--> The provided phone number is not valid.');
        break;
      case "too-many-requests":
        print("CodigoDeErroDoFirebaseAuth--> Excesso de tentativas, tente mais tarde!");
        break;
      case 'invalid-email':
        print("CodigoDeErroDoFirebaseAuth--> E-mail inválido!");
        break;
      case 'user-disabled':
        print("CodigoDeErroDoFirebaseAuth--> Usuário dasabilitado!");
        break;
      case 'user-not-found':
        print("CodigoDeErroDoFirebaseAuth--> Usuário não encontrado!");
        break;
      case 'wrong-password':
        print("CodigoDeErroDoFirebaseAuth--> Senha inválida!");
        break;
      case 'email-already-in-use':
        print("CodigoDeErroDoFirebaseAuth--> E-mail já cadastrado!");
        break;
      case 'invalid-verification-id':
        print("CodigoDeErroDoFirebaseAuth--> invalid-verification-id");
        break;
      default:
        print("CodigoDeErroDoFirebaseAuth--> Falha ao logar! Code: \"${e.code}\" - Menssage: \"${e.message}\"");
        break;
    }
  }
}
