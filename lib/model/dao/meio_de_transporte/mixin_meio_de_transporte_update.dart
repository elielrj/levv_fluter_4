import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';

import '../../bo/meio_de_transporte/carro.dart';
import 'carro/carro_dao.dart';
import 'moto/moto_dao.dart';



mixin MixinMeioDeTransporteUpdate {
  Future<void> updateMeioDeTransporte(MeioDeTransporte object) async {
    if (object is APe) {
    } else if (object is Bike) {
    } else if (object is Moto) {
      final motoDAO = MotoDAO();
      await motoDAO.atualizar(object);
    } else if (object is Carro) {
      final carroDAO = CarroDAO();
      await carroDAO.atualizar(object);
    }
  }
}

