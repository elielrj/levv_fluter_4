import 'dart:async';

abstract class ICrudEnderecoDAO<Endereco> {
  Future<void> criar(Map<String, dynamic> object);

  Future<void> atualizar(Map<String, dynamic> object);

  Future<dynamic> buscarEnderecosDoUsuarioCorrente();

  Future<void> deletar();

  Map<String, Map<String, dynamic>> toMapToMap(Map<String, dynamic> object);

  Map<String, dynamic> fromMapFromMap(Map<String, dynamic> map);

  Map<String, dynamic> favoritosToMap(List<Endereco> listaDeEnderecos);

  Map<String, dynamic> toMap(Endereco object);

  Endereco fromMap(Map<String, dynamic> map);
}
