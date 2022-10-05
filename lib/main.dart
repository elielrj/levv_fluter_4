import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:levv4/view/splash/tela_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: TelaSplash(),
    debugShowCheckedModeBanner: false,
  ));
}
