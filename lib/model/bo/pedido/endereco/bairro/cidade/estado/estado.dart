class Estado {
  final String _nome;
  final String _uf;

  Estado(this._nome, this._uf);

  String get nome => _nome.toUpperCase();

  String get uf => _uf.toLowerCase();
}
