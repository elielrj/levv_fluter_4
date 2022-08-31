import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/bo/usuario/perfil/perfil.dart';

import '../endereco/endereco.dart';

class Usuario {
  String? celular;

  Perfil? perfil;
  List<Pedido>? listaDePedidos;

  Usuario({
    this.celular,
    this.perfil,
    this.listaDePedidos
  });

}
