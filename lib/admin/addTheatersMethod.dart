import 'dart:typed_data';

import 'package:cinemafinder/authentication/fileStorage.dart';
import 'package:cinemafinder/model/movieModel.dart';
import 'package:cinemafinder/model/theaterModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FireStoreTheaterMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload the theater to the firebase

  Future<String> uploadTheater(
    String name,
    String address,
    //  String theaterCapacity,
    // Uint8List file,
    String uid,
  ) async {
    String res = "An error occured";
    try {
      // String photoUrl = await ImageStorageMethods().uploadImage('moviePics', file, true);
      // String theaterId = const Uuid().v1();
      final theaterId = _firestore.collection('theater').doc();
      Theater theater = Theater(
        name: name,
        address: address,
        //  theaterCapacity: theaterCapacity,
        theaterId: theaterId.id,
        //  movieUrl: photoUrl,
      );

      _firestore.collection('theater').doc(theaterId.id).set(theater.toJson());
      res = "Theater Added";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

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
