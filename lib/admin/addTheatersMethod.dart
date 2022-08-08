import 'dart:typed_data';

import 'package:cinemafinder/authentication/fileStorage.dart';
import 'package:cinemafinder/model/movieModel.dart';
import 'package:cinemafinder/model/theaterModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FireStoreTheaterMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> deleteTheater(String theaterid) async {
    String res = "An error occured";
    try {
      await _firestore.collection('theater').doc(theaterid).delete();
      res = "success";
      if (res == "success") {
        print('Theater deleted');
      } else {
        print('Theater not deleted');
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
