// ignore_for_file: file_names, prefer_const_constructors, unnecessary_this, camel_case_types, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_/routes.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String _uid = "";

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = auth.currentUser;
    final uid = user!.uid;
    print(uid);
    setState(() {
      _uid = uid;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Home")),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text("User ID :" + "" + _uid),
        ),
        ElevatedButton(
            onPressed: () {
              _signOut();
              Navigator.pushReplacementNamed(context, MyRoutes.login);
            },
            child: Text("log out"))
      ]),
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
Future<void> _signOut() async {
  await _auth.signOut();
}
