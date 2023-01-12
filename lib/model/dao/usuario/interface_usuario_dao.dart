abstract class InterfaceUsuarioDAO<T> {
  Future<void> criar(T object);

  Future<void> atualizar(T object);

  Future<void> buscar();

  Future<void> buscarTodos();

  Future<void> deletar(T object);

}
