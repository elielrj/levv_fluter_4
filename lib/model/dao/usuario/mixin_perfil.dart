import 'package:levv4/model/dao/usuario/acompanhar_dao.dart';
import 'package:levv4/model/dao/usuario/administrar_dao.dart';
import 'package:levv4/model/dao/usuario/entregar_dao.dart';
import 'package:levv4/model/dao/usuario/enviar_dao.dart';

import '../../bo/usuario/perfil/acompanhar/acompanhar.dart';
import '../../bo/usuario/perfil/administrar/administrar.dart';
import '../../bo/usuario/perfil/enviar/entregar/entregar.dart';
import '../../bo/usuario/perfil/enviar/enviar.dart';
import '../../bo/usuario/perfil/perfil.dart';

mixin CreatePerfil {
  Future<void> createPerfil(var object) async {
    if (object is Entregar) {
      EntregarDAO entregarDAO = EntregarDAO();
      await entregarDAO.create(object);
    } else if (object is Enviar) {
      EnviarDAO enviarDAO = EnviarDAO();
      await enviarDAO.create(object);
    } else if (object is Administrar) {
      AdministrarDAO administrarDAO = AdministrarDAO();
      await administrarDAO.create(object);
    } else if (object is Acompanhar) {
      AcompanharDAO acompanharDAO = AcompanharDAO();
      await acompanharDAO.create(object);
    }
  }
}

mixin UpdatePerfil {
  Future<void> updatePerfil(Perfil object) async {
    if (object is Entregar) {
      EntregarDAO entregarDAO = EntregarDAO();
      await entregarDAO.update(object);
    } else if (object is Enviar) {
      EnviarDAO enviarDAO = EnviarDAO();
      await enviarDAO.update(object);
    } else if (object is Administrar) {
      AdministrarDAO administrarDAO = AdministrarDAO();
      await administrarDAO.update(object);
    } else if (object is Acompanhar) {
      AcompanharDAO acompanharDAO = AcompanharDAO();
      await acompanharDAO.update(object);
    }
  }
}

mixin RetriveAllPerfil {
  Future<dynamic> retriveAllPerfil(Perfil object) async {
    if (object is Entregar) {
      EntregarDAO entregarDAO = EntregarDAO();
      return await entregarDAO.retriveAll();
    } else if (object is Enviar) {
      EnviarDAO enviarDAO = EnviarDAO();
      return await enviarDAO.retriveAll();
    } else if (object is Administrar) {
      AdministrarDAO administrarDAO = AdministrarDAO();
      return await administrarDAO.retriveAll();
    } else if (object is Acompanhar) {
      AcompanharDAO acompanharDAO = AcompanharDAO();
      return await acompanharDAO.retriveAll();
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
      await entregarDAO.delete(object);
    } else if (object is Enviar) {
      EnviarDAO enviarDAO = EnviarDAO();
      await enviarDAO.delete(object);
    } else if (object is Administrar) {
      AdministrarDAO administrarDAO = AdministrarDAO();
      await administrarDAO.delete(object);
    } else if (object is Acompanhar) {
      AcompanharDAO acompanharDAO = AcompanharDAO();
      await acompanharDAO.delete(object);
    }
  }
}
