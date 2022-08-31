
import 'package:firebase_storage/firebase_storage.dart';

class BancoDeArquivos{

  final FirebaseStorage _storage;

  BancoDeArquivos(this._storage);

  FirebaseStorage get storage => _storage;
}