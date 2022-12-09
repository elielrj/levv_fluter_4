import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/bo/perfil/perfil.dart';

class Usuario {
  String? celular;

  Perfil? perfil;
  List<Pedido>? listaDePedidos;

  Usuario({this.celular, this.perfil, this.listaDePedidos});
}
