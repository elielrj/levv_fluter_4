import 'package:levv4/model/bo/arquivo/arquivo.dart';

abstract class CrudFirebaseStore<T> {
  Future<void> upload(Arquivo object);

  Future<void> delete(Arquivo object);
}
