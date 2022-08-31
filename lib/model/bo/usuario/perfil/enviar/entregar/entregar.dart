import 'package:levv4/model/bo/usuario/perfil/enviar/enviar.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';
import 'package:levv4/model/bo/usuario/perfil/perfil.dart';
import 'package:levv4/model/bo/usuario/perfil/enviar/pessoa.dart';
import 'package:levv4/model/bo/meio_de_transporte/motorizado.dart';

import '../../../../endereco/endereco.dart';
import '../../../../meio_de_transporte/meio_de_transporte.dart';

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
      bool? documentoDeIdentificacao,
      this.pedidosTransportados,
      this.meioDeTransporte,
      })
      : super(
            nome: nome,
            sobrenome: sobrenome,
            cpf: cpf,
            nascimento: nascimento,
            enderecosFavoritos: enderecosFavoritos,
            casa: casa,
            trabalho: trabalho,
            documentoDeIdentificacao: documentoDeIdentificacao
  ){
    perfil = "Entregar";
  }




}
