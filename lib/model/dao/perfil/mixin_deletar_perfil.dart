import 'package:levv4/model/dao/usuario/acompanhar_dao.dart';
import 'package:levv4/model/dao/usuario/administrar_dao.dart';
import 'package:levv4/model/dao/usuario/entregar_dao.dart';
import 'package:levv4/model/dao/usuario/enviar_dao.dart';

import '../../bo/acompanhar/acompanhar.dart';
import '../../bo/administrar/administrar.dart';
import '../../bo/entregar/entregar.dart';
import '../../bo/enviar/enviar.dart';

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