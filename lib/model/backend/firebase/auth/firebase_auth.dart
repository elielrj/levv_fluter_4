

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

//todo mudar o nome do arquivo
//todo add mixin error e currentUser
class Autenticacao{

  final FirebaseAuth _auth;

  Autenticacao(this._auth);

  FirebaseAuth get auth => _auth;
}