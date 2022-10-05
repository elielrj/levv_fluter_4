import 'package:levv4/model/dao/usuario/acompanhar_dao.dart';
import 'package:levv4/model/dao/usuario/administrar_dao.dart';
import 'package:levv4/model/dao/usuario/entregar_dao.dart';
import 'package:levv4/model/dao/usuario/enviar_dao.dart';

import '../../bo/usuario/perfil/acompanhar/acompanhar.dart';
import '../../bo/usuario/perfil/administrar/administrar.dart';
import '../../bo/usuario/perfil/enviar/entregar/entregar.dart';
import '../../bo/usuario/perfil/enviar/enviar.dart';

mixin CriarPerfil {
  Future<void> createPerfil(var object) async {
    if (object is Entregar) {
      EntregarDAO entregarDAO = EntregarDAO();
      await entregarDAO.criar(object);
    } else if (object is Enviar) {
      EnviarDAO enviarDAO = EnviarDAO();
      await enviarDAO.criar(object);
    } else if (object is Administrar) {
      AdministrarDAO administrarDAO = AdministrarDAO();
      await administrarDAO.criar(object);
    } else if (object is Acompanhar) {
      AcompanharDAO acompanharDAO = AcompanharDAO();
      await acompanharDAO.criar(object);
    }
  }
}