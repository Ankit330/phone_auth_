// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample_/routes.dart';

// ignore: camel_case_types
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationID = "";

  bool otpCodeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Log in")),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: SizedBox(
            width: 300,
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  labelText: "Enter your phone number",
                  border: OutlineInputBorder()),
              onChanged: (value) {
                value = phoneController.text;
              },
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: SizedBox(
            width: 300,
            child: Visibility(
              visible: otpCodeVisible,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: otpController,
                decoration: const InputDecoration(
                    labelText: "Enter OTP", border: OutlineInputBorder()),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              if (otpCodeVisible) {
                verifyCode();
              } else {
                verifyPhone();
              }
            },
            child: Text(otpCodeVisible ? "Log in" : "Verify"))
      ]),
    );
  }

  void verifyPhone() {
    auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth
              .signInWithCredential(credential)
              .then((value) => print("You are login successfully"));
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
          ));
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationID = verificationId;
          otpCodeVisible = true;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  Future<void> verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      print("You are Logged In Successfully");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You are Logged In Successfully"),
      ));
      Navigator.pushReplacementNamed(context, MyRoutes.homePage);
    });
  }
}
