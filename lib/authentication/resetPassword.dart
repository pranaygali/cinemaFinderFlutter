import 'package:cinemafinder/authentication/loginUI.dart';
import 'package:cinemafinder/authentication/signOutMethod.dart';
import 'package:cinemafinder/reusables/textFields.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({Key? key}) : super(key: key);

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  TextEditingController _changePasswordController = TextEditingController();

  Future<void> passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _changePasswordController.text);
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
      await SignOutMethod().signOutUser();
    } catch (err) {
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
        backgroundColor: Colors.redAccent[400],
        centerTitle: true,
        title: Text(
          'Password Change',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter your email id to receieve password change link',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'IbarraRealNova',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                textFields(
                    textEditingController: _changePasswordController,
                    labalText: 'Enter your email',
                    textInputType: TextInputType.emailAddress),
                Container(
                  padding: EdgeInsets.all(40),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    //double.infinity,
                    height: 60,
                    onPressed: passwordReset,
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
              ]),
        ),
      ),
    );
  }
}
