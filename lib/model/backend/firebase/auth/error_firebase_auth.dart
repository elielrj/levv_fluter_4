import 'package:firebase_auth/firebase_auth.dart';

mixin ErrorFirebaseAuth {
  code(FirebaseAuthException e) {
    switch (e.code) {
      case "quotaExceeded":
        print('quotaExceeded.');
        break;
      case "invalid-phone-number":
        print('The provided phone number is not valid.');
        break;
      case "too-many-requests":
        print("Excesso de tentativas, tente mais tarde!");
        break;
      case 'invalid-email':
        print("E-mail inválido!");
        break;
      case 'user-disabled':
        print("Usuário dasabilitado!");
        break;
      case 'user-not-found':
        print("Usuário não encontrado!");
        break;
      case 'wrong-password':
        print("Senha inválida!");
        break;
      case 'email-already-in-use':
        print("E-mail já cadastrado!");
        break;
      case 'invalid-verification-id':
        print("invalid-verification-id");
        break;
      default:
        print("Falha ao logar! Code: \"${e.code}\" - Menssage: \"${e.message}\"");
        break;
    }
  }
}
