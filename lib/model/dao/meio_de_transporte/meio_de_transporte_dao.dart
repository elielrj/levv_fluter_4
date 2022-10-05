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
      await aPeDAO.criar(object);
    } else if (object is Bike) {
      final bikeDAO = BikeDAO();
      await bikeDAO.criar(object);
    } else if (object is Moto) {
      final motoDAO = MotoDAO();
      await motoDAO.criar(object);
    } else if (object is Carro){
      final carroDAO = CarroDAO();
      await carroDAO.criar(object);
    }
  }
}

mixin UpdateMeioDeTransporteDAO{
  Future<void> updateMeioDeTransporteDAO(MeioDeTransporte object) async {
    if (object is APe) {
      final aPeDAO = APeDAO();
      await aPeDAO.atualizar(object);
    } else if (object is Bike) {
      final bikeDAO = BikeDAO();
      await bikeDAO.atualizar(object);
    } else if (object is Moto) {
      final motoDAO = MotoDAO();
      await motoDAO.atualizar(object);
    } else if (object is Carro){
      final carroDAO = CarroDAO();
      await carroDAO.atualizar(object);
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
      await aPeDAO.deletar(object);
    } else if (object is Bike) {
      final bikeDAO = BikeDAO();
      await bikeDAO.deletar(object);
    } else if (object is Moto) {
      final motoDAO = MotoDAO();
      await motoDAO.deletar(object);
    } else if (object is Carro){
      final carroDAO = CarroDAO();
      await carroDAO.deletar(object);
    }
  }
}

