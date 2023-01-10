import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/enviar/enviar.dart';
import 'package:levv4/model/bo/meio_de_transporte/a_pe.dart';
import 'package:levv4/model/bo/meio_de_transporte/bike.dart';
import 'package:levv4/model/bo/meio_de_transporte/carro.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/meio_de_transporte/moto.dart';
import 'package:levv4/model/bo/meio_de_transporte/motorizado.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';

class Entregar extends Enviar {
  List<Pedido>? pedidosTransportados;
  MeioDeTransporte? meioDeTransporte;

  Entregar({
    String? nome,
    String? sobrenome,
    String? cpf,
    DateTime? nascimento,
    List<Endereco>? enderecosFavoritos,
    Endereco? casa,
    Endereco? trabalho,
    Arquivo? documentoDeIdentificacao,
    String perfil = "Entregar",
    this.pedidosTransportados,
    this.meioDeTransporte,
  }) : super(
            perfil: perfil,
            nome: nome,
            sobrenome: sobrenome,
            cpf: cpf,
            nascimento: nascimento,
            enderecosFavoritos: enderecosFavoritos,
            casa: casa,
            trabalho: trabalho,
            documentoDeIdentificacao: documentoDeIdentificacao);

  @override
  String exibirPerfil() => perfil!;

  @override
  Map<String, dynamic> toMap() {
    return Map.from({
      if (perfil != null) 'perfil': perfil,
      if (nome != null) 'nome': nome,
      if (sobrenome != null) 'sobrenome': sobrenome,
      if (cpf != null) 'cpf': cpf,
      if (nascimento != null)
        'nascimento': Timestamp.fromMillisecondsSinceEpoch(
            nascimento!.millisecondsSinceEpoch),
      if (enderecosFavoritos != null)
        'enderecosFavoritos': enderecosFavoritos!.asMap(),
      //todo ver como se comporta
      if (casa != null) 'casa': casa!.toMap(),
      if (trabalho != null) 'trabalho': trabalho!.toMap(),
      //if (pedidosTransportados != null)
      ////   'pedidosTransportados': pedidosTransportados,
      if (meioDeTransporte != null)
        'meioDeTransporte': meioDeTransporte!.toMap(),
    });
  }

  factory Entregar.fromMap(Map<String, dynamic> map) {
    List<Pedido> pedidos = [];

    Map<dynamic, dynamic> pedidoMap = map['pedido'] ??= {};
    if (pedidoMap.isNotEmpty) {
      pedidoMap.values.forEach((element) {
        pedidos.add(Pedido.fromMap(element));
      });
    }

    MeioDeTransporte meioDeTransporte;

    if (map['meioDeTransporte']['nome'] == 'Moto') {
      meioDeTransporte = Moto.fromMap(map['meioDeTransporte']);
    } else if (map['meioDeTransporte']['nome'] == 'Carro') {
      meioDeTransporte = Carro.fromMap(map['meioDeTransporte']);
    } else if (map['meioDeTransporte']['nome'] == 'A pé') {
      meioDeTransporte = APe.fromMap(map['meioDeTransporte']);
    } else if (map['meioDeTransporte']['nome'] == 'Bike') {
      meioDeTransporte = APe.fromMap(map['meioDeTransporte']);
    } else {
      meioDeTransporte = APe();
    }

    Timestamp timestamp = map['nascimento'];

    List<Endereco> enderecosFavoritos = [];
    Map<dynamic, dynamic> enderecos = map['enderecosFavoritos'] ??= {};
    if (enderecos.isNotEmpty) {
      enderecos.values.forEach((element) {
        enderecosFavoritos.add(Endereco.fromMap(element));
      });
    }
    Endereco enderecoDoTrabaho;
    Map<dynamic,dynamic> enderecoDoTrabahoMap = map['trabalho']??={};
    if(enderecoDoTrabahoMap.isNotEmpty){
      enderecoDoTrabaho =Endereco.fromMap(map['trabalho']);
    }else{
      enderecoDoTrabaho = Endereco();
    }


    return Entregar(
      perfil: map['perfil'],
      pedidosTransportados: pedidos,
      meioDeTransporte: meioDeTransporte,
      nome: map['nome'],
      sobrenome: map['sobrenome'],
      cpf: map['cpf'],
      nascimento: timestamp.toDate(),
      enderecosFavoritos: enderecosFavoritos,
      casa: Endereco.fromMap(map['casa']),
      trabalho: enderecoDoTrabaho,
    );
  }
}
