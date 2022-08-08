import 'package:cinemafinder/authentication/signUpMethod.dart';
import 'package:cinemafinder/model/userModel.dart';
import 'package:flutter/material.dart';

//change notifier is used such that we can inherit some functions from it
class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

//This function is used to update the values of the user
  Future<void> refreshUser() async {
    User user = await _authMethods.fetchUserDetails();
    _user = user;
    //this is used to update any changes in the user data
    notifyListeners();
  }
}
