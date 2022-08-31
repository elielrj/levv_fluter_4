import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';

import '../../bo/meio_de_transporte/carro.dart';
import 'a_pe_dao.dart';
import 'bike_dao.dart';
import 'carro_dao.dart';
import 'moto_dao.dart';

mixin CreateMeioDeTransporteDAO{
  Future<void> createMeioDeTransporteDAO(MeioDeTransporte object) async {
    if (object is APe) {
      final aPeDAO = APeDAO();
      await aPeDAO.create(object);
    } else if (object is Bike) {
      final bikeDAO = BikeDAO();
      await bikeDAO.create(object);
    } else if (object is Moto) {
      final motoDAO = MotoDAO();
      await motoDAO.create(object);
    } else if (object is Carro){
      final carroDAO = CarroDAO();
      await carroDAO.create(object);
    }
  }
}

mixin UpdateMeioDeTransporteDAO{
  Future<void> updateMeioDeTransporteDAO(MeioDeTransporte object) async {
    if (object is APe) {
      final aPeDAO = APeDAO();
      await aPeDAO.update(object);
    } else if (object is Bike) {
      final bikeDAO = BikeDAO();
      await bikeDAO.update(object);
    } else if (object is Moto) {
      final motoDAO = MotoDAO();
      await motoDAO.update(object);
    } else if (object is Carro){
      final carroDAO = CarroDAO();
      await carroDAO.update(object);
    }
  }
}

mixin RetriveMeioDeTransporteDAO{
  Future<dynamic> retriveMeioDeTransporteDAO(String nomeDoMeioDeTransporte) async {


    if (nomeDoMeioDeTransporte == "A pé") {
      final aPeDAO = APeDAO();
      return await aPeDAO.retrive();
    } else if (nomeDoMeioDeTransporte == "Bike") {
      final bikeDAO = BikeDAO();
      return await bikeDAO.retrive();
    } else if (nomeDoMeioDeTransporte == "Moto") {
      final motoDAO = MotoDAO();
      return await motoDAO.retrive();
    } else if (nomeDoMeioDeTransporte == "Carro"){
      final carroDAO = CarroDAO();
      return await carroDAO.retrive();
    }
  }
}

mixin DeleteMeioDeTransporteDAO{
  Future<void> delete(MeioDeTransporte object) async {
    if (object is APe) {
      final aPeDAO = APeDAO();
      await aPeDAO.delete(object);
    } else if (object is Bike) {
      final bikeDAO = BikeDAO();
      await bikeDAO.delete(object);
    } else if (object is Moto) {
      final motoDAO = MotoDAO();
      await motoDAO.delete(object);
    } else if (object is Carro){
      final carroDAO = CarroDAO();
      await carroDAO.delete(object);
    }
  }
}

