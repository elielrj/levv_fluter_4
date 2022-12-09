import 'package:levv4/model/bo/arquivo/arquivo.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';
import 'package:levv4/model/bo/enviar/enviar.dart';
import 'package:levv4/model/bo/meio_de_transporte/meio_de_transporte.dart';
import 'package:levv4/model/bo/pedido/pedido.dart';

class Entregar extends Enviar {
  static const perfil = "Entregar";
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
    this.pedidosTransportados,
    this.meioDeTransporte,
  }) : super(
            nome: nome,
            sobrenome: sobrenome,
            cpf: cpf,
            nascimento: nascimento,
            enderecosFavoritos: enderecosFavoritos,
            casa: casa,
            trabalho: trabalho,
            documentoDeIdentificacao: documentoDeIdentificacao);

  @override
  String exibirPerfil() => perfil;
}
