// This file is used to model the details of a movie to store in the firebase

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String fullName;
  final String contactNumber;
  final String email;

  //constructor
  const User({
    required this.fullName,
    required this.contactNumber,
    required this.email,
  });

  // this method is used to convert user object from the above to the object

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "contactNumber": contactNumber,
        "email": email,
      };

  //This will take document snapshot and returns usermodel
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      fullName: snapshot['fullName'],
      email: snapshot['email'],
      contactNumber: snapshot['contactNumber'],
    );
  }
}
