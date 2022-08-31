
import 'package:cloud_firestore/cloud_firestore.dart';

class BancoDeDados{

  final FirebaseFirestore _db;

  BancoDeDados(this._db);

  FirebaseFirestore get db => _db;
}