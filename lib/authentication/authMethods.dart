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
    
  }) async {
    String res = "An error occured";

    try {
      if (fullName.isNotEmpty &&
              contactNumber.isNotEmpty &&
              email.isNotEmpty &&
              password.isNotEmpty &&
              confirmPassword.isNotEmpty &&
              (password == confirmPassword) &&
              (password.length > 7) &&
              (contactNumber.length == 10)

          
          ) {
        UserCredential userDetails = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(userDetails.user!.uid);
        // Exclamation is used because, the user can be returned as null


        //add user to the database
        _firestore.collection('users').doc(userDetails.user!.uid).set({
          'fullName': fullName,
          //'uid': userDetails.user!.uid,
          'contactNumber': contactNumber,
          'email': email,
          
        });
        res = "signup success";
      } else if (password.length < 8) {
        res = "Password length shouldn't be less than 8 characters";
      } else if (password != confirmPassword) {
        res = "Password mismatch";
      } else if (contactNumber.length != 10) {
        res = "Contact number should not be less than 10 digits";
      } else {
        print('Thank you for being oversmart, kindly enter all the details');
        res = "Thank you for being oversmart, kindly enter all the details";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
