import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignOutMethod {
  FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> signOutUser() async {
    await _auth.signOut();
  }
}

