//import 'dart:html';
import 'dart:typed_data';

import 'package:cinemafinder/authentication/fileStorage.dart';
import 'package:cinemafinder/model/movieModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload the movie to the firebase

  Future<String> uploadMovie(
    // String movieName,
    // String castDetails,
    // String directorName,
    // Uint8List file,
    // String uid,

    String name,
    String cast,
    String director,
    Uint8List file,
    String uid,

    //  String checkId,
  ) async {
    String res = "An error occured";
    try {
      String photoUrl =
          await ImageStorageMethods().uploadImage('moviePics', file, true);
      // String movieid = const Uuid().v1();
      final movieid = _firestore.collection('movie').doc();
      // final randomid = _firestore.collection('movie').doc();
      // Movie movie = Movie(
      //   movieName: movieName,
      //   castDetails: castDetails,
      //   directorName: directorName,
      //   movieId: movieId,
      //   movieUrl: photoUrl,
      // );
      Movie movie = Movie(
        name: name,
        cast: cast,
        director: director,
        movieid: movieid.id,
        // randomid: randomid.id,
        imageUrl: photoUrl,
      );

      //   String checkId = _firestore
      // .collection('movie')
      // .document()
      // .documentID;

      _firestore.collection('movie').doc(movieid.id).set(movie.toJson());
      // _firestore.collection('movie').add(movie.toJson());

      res = "Movie uploaded";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

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
