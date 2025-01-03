import 'bairro/cidade/cidade.dart';

class Endereco {
  final Cidade _cidade;
  final String _logradouro;
  final String _complemento;
  final String _numero;

  Endereco(
    this._cidade,
    this._logradouro,
    this._complemento,
    this._numero,
  );
}
