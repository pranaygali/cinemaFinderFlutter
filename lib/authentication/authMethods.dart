//import 'dart:typed_data';

import 'dart:typed_data';

import 'package:cinemafinder/authentication/fileStorage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String fullName,
    required String contactNumber,
    required String email,
    required String password,
    required String confirmPassword,
  //  required Uint8List file,
  }) async {
    String res = "An error occured";

    try {
      if (fullName.isNotEmpty &&
              contactNumber.isNotEmpty &&
              email.isNotEmpty &&
              password.isNotEmpty &&
              confirmPassword.isNotEmpty &&
              (password == confirmPassword)
          // file != null
          ) {
        UserCredential userDetails = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(userDetails.user!.uid);
        // Exclamation is used because, the user can be returned as null

        // adding image to the storage
      //  String photoUrl =   await FileStorage().uploadImage('profilePics', file, false);

        //add user to the database
        _firestore.collection('users').doc(userDetails.user!.uid).set({
          'fullName': fullName,
          'uid': userDetails.user!.uid,
          'contactNumber': contactNumber,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        //  'photoUrl': photoUrl,
        });
        res = "signup success";
      } else if (password != confirmPassword) {
        res = "Password mismatch";
      } else {
        print('Thank you for being oversmart, kindly enter all the details');
        res = "Thank you for being oversmart, kindly enter all the details";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //login a user

  // Future<String> loginUser(
  //     {required String email, required String password}) async {
  //   String res = "An error occured";
  //   try {
  //     if (email.isNotEmpty && password.isNotEmpty) {
  //       await _auth.signInWithEmailAndPassword(
  //           email: email, password: password);
  //       res = "logged in";
  //     } else {
  //       res = "Sorry, all the details are required";
  //     }
  //   } catch (err) {
  //     res = err.toString();
  //   }
  //   return res;
  // }
}
