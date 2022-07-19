//import 'dart:html';

import 'package:cinemafinder/authentication/resetPassword.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class userProfile extends StatefulWidget {
  const userProfile({Key? key}) : super(key: key);

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  String fullName = "";
  String contactNumber = "";
  String email = "";
  String name = "";

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    print(snap.data());

    setState(() {
      fullName = (snap.data() as Map<String, dynamic>)['fullName'];
      contactNumber = (snap.data() as Map<String, dynamic>)['contactNumber'];
      email = (snap.data() as Map<String, dynamic>)['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'IbarraRealNova',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name: ',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IbarraRealNova',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  ' $fullName',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IbarraRealNova',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 20,
              color: Colors.redAccent[400],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Contact Number: ',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IbarraRealNova',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  ' $contactNumber',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IbarraRealNova',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 20,
              color: Colors.redAccent[400],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email: ',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IbarraRealNova',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  ' $email',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IbarraRealNova',
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 20,
              color: Colors.redAccent[400],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => resetPassword()));
                  },
                  child: Row(
                    children: [Icon(Icons.edit), Text('Change Password')],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
