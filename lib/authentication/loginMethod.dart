import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginMethod
{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "An error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "logged in";
      } else {
        res = "Sorry, all the details are required";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}