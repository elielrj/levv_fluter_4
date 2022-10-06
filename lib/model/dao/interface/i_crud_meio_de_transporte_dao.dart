abstract class ICrudMeioDeTransporteDAO<T> {
  Future<void> criar(T object);

  Future<void> atualizar(T object);

  Future<void> buscarTodos();

  Future<void> buscarUmUsuarioPeloNomeDoDocumento(String reference);

  Future<void> deletar(T object);

  Map<String, dynamic> toMap(T object);

  T fromMap(Map<String, dynamic> map);
}