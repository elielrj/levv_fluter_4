

abstract class CrudFirebaseFirestoreToPerfil<T>{

  Future<void> createPerfil(T object);
  Future<void> updatePerfil(T object);
  Future<void> retriveAllPerfil(T object);
  Future<void> searchByReferencePerfil(String perfil, String celular);
  Future<void> deletePerfil(T object);

}