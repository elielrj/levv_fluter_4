import 'package:levv4/model/dao/usuario/acompanhar_dao.dart';
import 'package:levv4/model/dao/usuario/administrar_dao.dart';
import 'package:levv4/model/dao/usuario/entregar_dao.dart';
import 'package:levv4/model/dao/usuario/enviar_dao.dart';

import '../../bo/acompanhar/acompanhar.dart';
import '../../bo/administrar/administrar.dart';
import '../../bo/entregar/entregar.dart';
import '../../bo/enviar/enviar.dart';
import '../../bo/perfil/perfil.dart';

mixin BuscarPerfil {
  Future<dynamic> retriveAllPerfil(Perfil object) async {
    if (object is Entregar) {
      EntregarDAO entregarDAO = EntregarDAO();
      return await entregarDAO.buscarTodos();
    } else if (object is Enviar) {
      EnviarDAO enviarDAO = EnviarDAO();
      return await enviarDAO.buscarTodos();
    } else if (object is Administrar) {
      AdministrarDAO administrarDAO = AdministrarDAO();
      return await administrarDAO.buscarTodos();
    } else if (object is Acompanhar) {
      AcompanharDAO acompanharDAO = AcompanharDAO();
      return await acompanharDAO.buscarTodos();
    }
  }

  Future<dynamic> retrive(Perfil object) async {
    if (object is Entregar) {
      EntregarDAO entregarDAO = EntregarDAO();
      return await entregarDAO.buscarTodos();
    } else if (object is Enviar) {
      EnviarDAO enviarDAO = EnviarDAO();
      return await enviarDAO.buscarTodos();
    } else if (object is Administrar) {
      AdministrarDAO administrarDAO = AdministrarDAO();
      return await administrarDAO.buscarTodos();
    } else if (object is Acompanhar) {
      AcompanharDAO acompanharDAO = AcompanharDAO();
      return await acompanharDAO.buscarTodos();
    }
  }
}
