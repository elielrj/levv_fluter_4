

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class Autenticacao{

  final FirebaseAuth _auth;

  Autenticacao(this._auth);

  FirebaseAuth get auth => _auth;
}