import 'package:flutter/material.dart';
import 'package:sample_/homePage.dart';
import 'package:sample_/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sample_/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const login(),
      routes: {
        MyRoutes.homePage: (context) => const homePage(),
        MyRoutes.login: (context) => const login(),
      },
    );
  }
}
