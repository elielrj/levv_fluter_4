import 'package:levv4/model/dao/usuario/acompanhar_dao.dart';
import 'package:levv4/model/dao/usuario/administrar_dao.dart';
import 'package:levv4/model/dao/usuario/entregar_dao.dart';
import 'package:levv4/model/dao/usuario/enviar_dao.dart';

import '../../bo/usuario/perfil/acompanhar/acompanhar.dart';
import '../../bo/usuario/perfil/administrar/administrar.dart';
import '../../bo/usuario/perfil/enviar/entregar/entregar.dart';
import '../../bo/usuario/perfil/enviar/enviar.dart';
import '../../bo/usuario/perfil/perfil.dart';

/*


mixin UpdatePerfil {
  Future<void> updatePerfil(Perfil object) async {
    if (object is Entregar) {
      EntregarDAO entregarDAO = EntregarDAO();
      await entregarDAO.atualizar(object);
    } else if (object is Enviar) {
      EnviarDAO enviarDAO = EnviarDAO();
      await enviarDAO.atualizar(object);
    } else if (object is Administrar) {
      AdministrarDAO administrarDAO = AdministrarDAO();
      await administrarDAO.atualizar(object);
    } else if (object is Acompanhar) {
      AcompanharDAO acompanharDAO = AcompanharDAO();
      await acompanharDAO.atualizar(object);
    }
  }
}

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
}

mixin SearchByReferencePerfil {
  Future<Perfil> searchByReferencePerfil(Map<String,dynamic> mapa, String perfil) async {
    var perfilClass;

    if (perfil == "Entregar") {
      EntregarDAO entregarDAO = EntregarDAO();
      perfilClass = await entregarDAO.fromMap(mapa);
      //perfilClass = await entregarDAO.searchByReference(celular);
    } else if (perfil == "Enviar") {
      EnviarDAO enviarDAO = EnviarDAO();
      perfilClass = await enviarDAO.fromMap(mapa);
     // perfilClass = await enviarDAO.searchByReference(celular);
    } else if (perfil == "Administrar") {
      AdministrarDAO administrarDAO = AdministrarDAO();
      perfilClass = await administrarDAO.fromMap(mapa);
      //perfilClass = await administrarDAO.searchByReference(celular);
    } else if (perfil == "Acompanhar") {
      AcompanharDAO acompanharDAO = AcompanharDAO();
      perfilClass = await acompanharDAO.fromMap(mapa);
      //perfilClass = await acompanharDAO.searchByReference(celular);
    }
    return perfilClass;
  }
}


mixin DeletePerfil {
  Future<void> deletePerfil(var object) async {
    if (object is Entregar) {
      EntregarDAO entregarDAO = EntregarDAO();
      await entregarDAO.deletar(object);
    } else if (object is Enviar) {
      EnviarDAO enviarDAO = EnviarDAO();
      await enviarDAO.deletar(object);
    } else if (object is Administrar) {
      AdministrarDAO administrarDAO = AdministrarDAO();
      await administrarDAO.deletar(object);
    } else if (object is Acompanhar) {
      AcompanharDAO acompanharDAO = AcompanharDAO();
      await acompanharDAO.deletar(object);
    }
  }
}
*/
