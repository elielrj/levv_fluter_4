import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';

import '../../bo/meio_de_transporte/carro.dart';
import 'carro/carro_dao.dart';
import 'moto/moto_dao.dart';


mixin MixinMeioDeTransporteRetrive {
  Future<dynamic> retriveMeioDeTransporte(
      String nomeDoMeioDeTransporte) async {
    if (nomeDoMeioDeTransporte == "A pé") {
    } else if (nomeDoMeioDeTransporte == "Bike") {
    } else if (nomeDoMeioDeTransporte == "Moto") {
      final motoDAO = MotoDAO();
      return await motoDAO.buscar();
    } else if (nomeDoMeioDeTransporte == "Carro") {
      final carroDAO = CarroDAO();
      return await carroDAO.buscar();
    }
  }
}
