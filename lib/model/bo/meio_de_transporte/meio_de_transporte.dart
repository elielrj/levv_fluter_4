import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

@deprecated
abstract class MeioDeTransporte{

  String exibirMeioDeTransporte();

  MeioDeTransporte.fromMap(Map<dynamic, dynamic> map);

  Map<String, dynamic> toMap();
}