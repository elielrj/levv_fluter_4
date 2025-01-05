import 'estado/estado.dart';

class Cidade {
  final String _nome;
  final Estado _estado;

  Cidade(this._nome, this._estado);

  String get nome => _nome.toUpperCase();

  String get pertencenteAoEstado => _estado.nome;

  String get daUF => _estado.uf;
}
