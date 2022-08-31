

import 'dart:async';

abstract class CrudFirebaseFirestoreToEndereco<T>{

  Future<void> create(Map<String,dynamic> object);
  Future<void> update(Map<String,dynamic> object);
  Future<dynamic> retrive();
  Future<void> delete();
  Map<String, dynamic> toMap(T object);
  T fromMap(Map<String,dynamic> map);

}