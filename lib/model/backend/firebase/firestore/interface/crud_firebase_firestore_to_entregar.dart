

abstract class CrudFirebaseFirestoreToEntregar<T>{

  Future<void> create(T object);
  Future<void> update(T object);
  Future<void> retriveAll();
  Future<void> searchByReference(String reference);
  Future<void> delete(T object);
  Future<Map<String, dynamic>> toMap(T object);
  Future<T> fromMap(Map<String,dynamic> map);

}