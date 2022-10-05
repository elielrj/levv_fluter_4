import 'package:cloud_firestore/cloud_firestore.dart';

class BancoDeDados {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseFirestore get db => _db;
}
