
abstract class ICrudArquivoDAO<Arquivo> {
  Future<void> upload(Arquivo object);

  Future<void> delete(Arquivo object);
}
