abstract class InterfaceUsuarioDAO<T> {
  Future<void> criar(T object);

  Future<void> atualizar(T object);

  Future<void> buscar();

  Future<void> buscarTodos();

  Future<void> deletar(T object);

  Future<Map<String, dynamic>> toMap(T object);

  Future<T> fromMap(Map<String, dynamic> map);
}
