import 'package:levv4/model/bo/meio_de_transporte/moto.dart';
import 'package:levv4/model/dao/meio_de_transporte/carro/carro_dao.dart';
import 'package:levv4/model/dao/meio_de_transporte/moto/moto_dao.dart';

import '../../../bo/meio_de_transporte/carro.dart';

mixin MixinMotorizadoDelete {
  Future<void> deleMotorizado(var object) async {
    if (object is Moto) {
      MotoDAO motoDAO = MotoDAO();
      await motoDAO.deletar(object);
    }else if(object is Carro){
      CarroDAO carroDAO = CarroDAO();
      await carroDAO.deletar(object);
    }
  }
}
