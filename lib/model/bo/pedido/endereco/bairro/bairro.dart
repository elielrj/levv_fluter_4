import 'cidade/cidade.dart';

class Bairro {
  final String _nome;
  final Cidade _cidade;

  Bairro(this._nome, this._cidade);

  String get nome => _nome.toUpperCase();

  String get daCidade => _cidade.nome;
  String get doEstado => _cidade.pertencenteAoEstado;
  String get daUF => _cidade.daUF;
}
