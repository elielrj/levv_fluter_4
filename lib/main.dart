import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:levv4/view/splash/tela_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaSplash(),
    ),
  );
}
