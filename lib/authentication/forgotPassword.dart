import 'package:cinemafinder/authentication/loginUI.dart';
import 'package:cinemafinder/reusables/textFields.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({Key? key}) : super(key: key);

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final TextEditingController resetPasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    resetPasswordController.dispose();
  }

  Future passwordForgot() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetPasswordController.text);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
          title: Text('ALERT'),
          contentPadding: EdgeInsets.all(20),
          content: Text('Link has been sent to your email'),
        ),
      );
    } catch (err) {
      print(err);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
          title: Text('ALERT'),
          contentPadding: EdgeInsets.all(20),
          content: Text(err.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent[400],
        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontFamily: 'IbarraRealNova',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Enter your email id to reset your password',
              style: TextStyle(
                  fontFamily: 'IbarraRealNova',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: resetPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: Divider.createBorderSide(context),
                ),
                // filled: false,
                labelText: 'Enter your email here',
                contentPadding: EdgeInsets.all(8),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            Container(
              padding: EdgeInsets.all(40),
              child: MaterialButton(
                minWidth: double.infinity,
                //double.infinity,
                height: 60,
                onPressed: passwordForgot,
                color: Colors.redAccent[400],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                    fontFamily: 'IbarraRealNova',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
