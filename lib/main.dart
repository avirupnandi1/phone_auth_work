import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid == true
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "API KEY",
              appId: "APP-id",
              messagingSenderId: "ID",
              projectId: "projectID"),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
