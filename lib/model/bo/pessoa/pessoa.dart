import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levv4/model/bo/acompanhar/acompanhar.dart';
import 'package:levv4/model/bo/endereco/endereco.dart';

abstract class Pessoa extends Acompanhar {
  String? nome;
  String? sobrenome;
  String? cpf;
  DateTime? nascimento;
  List<Endereco>? enderecosFavoritos;
  Endereco? casa;
  Endereco? trabalho;

  Pessoa(
      {String? perfil = 'Pessoa',
      this.nome,
      this.sobrenome,
      this.cpf,
      this.nascimento,
      this.enderecosFavoritos,
      this.casa,
      this.trabalho})
      : super(perfil: perfil);






}
