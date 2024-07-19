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
              apiKey: "AIzaSyCAEXkFB9SdEapLPnlxV4Xb9asyVTa8sYc",
              appId: "1:459490752567:android:04df9e9ef98b085d77e7b2",
              messagingSenderId: "459490752567",
              projectId: "auth-project-e3b75"),
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
