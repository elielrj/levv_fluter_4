

abstract class CrudFirebaseFirestore<T>{

  Future<void> create(T object);
  Future<void> update(T object);
  Future<void> retriveAll();
  Future<void> searchByReference(String reference);
  Future<void> delete(T object);
  Map<String, dynamic> toMap(T object);
  T fromMap(Map<String,dynamic> map);

}
