import 'bairro/bairro.dart';

class Endereco {
  final Bairro _bairro;
  final String _logradouro;
  final String _complemento;
  final String _numero;

  Endereco(this._bairro, this._logradouro, this._complemento, this._numero);

  String get numero => _numero;

  String get complemento => _complemento;

  String get logradouro => _logradouro.toUpperCase();

  String get bairro => _bairro.nome;

  String get cidade => _bairro.daCidade;

  String get estado => _bairro.doEstado;

  String get daUF => _bairro.daUF;

  String get enderecoNoFormatoDeImpressaoDeCarta {
    return "$_logradouro, Nr $_numero, $_bairro\n"
        "$cidade, $estado - $daUF";
  }
}
