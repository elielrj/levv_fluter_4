import 'package:firebase_storage/firebase_storage.dart';

class BancoDeArquivos {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  FirebaseStorage get storage => _storage;
}
