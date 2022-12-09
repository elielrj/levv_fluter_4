import 'package:levv4/model/dao/usuario/acompanhar_dao.dart';
import 'package:levv4/model/dao/usuario/administrar_dao.dart';
import 'package:levv4/model/dao/usuario/entregar_dao.dart';
import 'package:levv4/model/dao/usuario/enviar_dao.dart';
import '../../bo/perfil/perfil.dart';

mixin CriarObjetoPerfilComMap {
  Future<Perfil> toMapComPerfil(
      Map<String, dynamic> mapa, String perfil) async {
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
