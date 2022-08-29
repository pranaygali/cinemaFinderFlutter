//import 'dart:typed_data';

import 'dart:typed_data';

import 'package:cinemafinder/authentication/fileStorage.dart';
import 'package:cinemafinder/model/userModel.dart' as model;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:cinemafinder/model/userModel.dart' as userModel;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> fetchUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

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
          (contactNumber.length == 10)) {
        UserCredential userDetails = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(userDetails.user!.uid);
        // Exclamation is used because, the user can be returned as null

        //add user to the database
        //1. user model, to send these particular details into the database
        model.User user = model.User(
            fullName: fullName, contactNumber: contactNumber, email: email);

        //firebase collection
        _firestore
            .collection('users')
            .doc(userDetails.user!.uid)
            .set(user.toJson());

        // _firestore.collection('users').doc(userDetails.user!.uid).set({
        //   // 'fullName': fullName,
        //   // //'uid': userDetails.user!.uid,
        //   // 'contactNumber': contactNumber,
        //   // 'email': email,
        // });
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

  Future<String> updateUserDetails(
      String fullName, String email, String contactNumber) async {
    String res = "An error occured";

    try {
      if (fullName.isNotEmpty && email.isNotEmpty && contactNumber.isNotEmpty) {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({
          'fullName': fullName,
          'email': email,
          'contactNumber': contactNumber,
        });
        res = "details updated!";
      }
      if (fullName.isEmpty && email.isEmpty && contactNumber.isEmpty) {
        res = 'Enter all the details';
      }
      if (fullName.isEmpty && email.isNotEmpty && contactNumber.isNotEmpty) {
        res = 'full name cannot be empty';
      }
      if (fullName.isNotEmpty && email.isEmpty && contactNumber.isNotEmpty) {
        res = 'email cannot be empty';
      }
      if (fullName.isNotEmpty && email.isNotEmpty && contactNumber.isEmpty) {
        res = 'contact number cannot be empty';
      }
      if (fullName.isNotEmpty && email.isNotEmpty && contactNumber.isEmpty) {
        res = 'contact number cannot be empty';
      }
      if (fullName.isNotEmpty && email.isEmpty && contactNumber.isEmpty) {
        res = 'email, contact number cannot be empty';
      }
      if (fullName.isEmpty && email.isNotEmpty && contactNumber.isEmpty) {
        res = 'name, contact number cannot be empty';
      }
      if (fullName.isEmpty && email.isEmpty && contactNumber.isNotEmpty) {
        res = 'name, email cannot be empty';
      }
      if (contactNumber.length > 10) {
        res = "contact number's length should not be more then 10";
      }
      if (contactNumber.length < 10) {
        res = "contact number's length should not be less then 10";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Future<void> facebookSignIn() async {
  //   try {
  //    final facebookLoginResult =  FacebookAuth.instance
  //         .login(permissions: ["public_profile", "email"]).then((value) {
  //       FacebookAuth.instance.getUserData().then((userData) async {
  //         // Navigator.push(
  //         //     context,
  //         //     MaterialPageRoute(
  //         //         builder: (context) => movieHomeScreen()));
  //       });
  //     });
  //     print("Facebook login success" + facebookLoginResult.toString());
  //   } catch (err) {
  //     print("The error in the facebook login is " + err.toString());
  //   }
  // }

  // Future<void> facebookSignOut() async {
  //   try {
  //     await FacebookAuth.instance.logOut().then((value) {});
  //     print("Facebbok logout success");
  //   } catch (err) {
  //     print("The facebook logout error is " + err.toString());
  //   }
  // }

  Future<void> facebookSignIn(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await _auth.signInWithCredential(facebookAuthCredential);

      print("Facebook login success " + LoginStatus.success.toString());
    } catch (e) {
      print("The error in the facebook login is " + e.toString());
    }
  }

  // Future<void> facebookSignOut(BuildContext context) async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     await FacebookAuth.instance.logOut();
  //     print("Facebook logout success");
  //   } catch (err) {
  //     print("The facebook logout error is " + err.toString());
  //   }
  // }
}
