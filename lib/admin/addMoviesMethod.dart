//import 'dart:html';
import 'dart:typed_data';

import 'package:cinemafinder/authentication/fileStorage.dart';
import 'package:cinemafinder/model/movieModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //Delete a movie

  Future<String> deleteMovie(String movieid) async {
    String res = "An error occured";
    try {
      await _firestore.collection('movie').doc(movieid).delete();
      res = 'success';
      if (res == "success") {
        print('Movie deleted');
      } else {
        print('movie not deleted');
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
