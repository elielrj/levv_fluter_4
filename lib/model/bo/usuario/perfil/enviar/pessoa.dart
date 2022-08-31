import 'package:levv4/model/bo/usuario/perfil/acompanhar/acompanhar.dart';

import '../../../endereco/endereco.dart';

abstract class Pessoa extends Acompanhar{
  String? nome;
  String? sobrenome;
  String? cpf;
  DateTime? nascimento;
  List<Endereco>? enderecosFavoritos;
  Endereco? casa;
  Endereco? trabalho;

  Pessoa({
    this.nome,
    this.sobrenome,
    this.cpf,
    this.nascimento,
    this.enderecosFavoritos,
    this.casa,
    this.trabalho
  });


}
