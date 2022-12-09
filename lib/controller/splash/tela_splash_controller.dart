import 'package:firebase_auth/firebase_auth.dart';
import 'package:levv4/model/bo/usuario/usuario.dart';
import 'package:levv4/model/dao/usuario/usuario_dao.dart';

class TelaSplashController {
  final usuarioDAO = UsuarioDAO();

  Future<Usuario?> buscarUsuario() async {
    return await usuarioDAO.buscar();
  }

  bool usuarioFirebaseEstaLogado() {
    return FirebaseAuth.instance.currentUser != null ? true : false;
  }
}
