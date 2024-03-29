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
          await ImageStorageMethods().uploadImage('movies', file, true);
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
      if (name.isNotEmpty && cast.isNotEmpty && director.isNotEmpty) {
        _firestore.collection('movie').doc(movieid.id).set(movie.toJson());
        // _firestore.collection('movie').add(movie.toJson());
        res = "Movie uploaded";
      }
      if (name.isEmpty && cast.isEmpty && director.isEmpty) {
        res = "Enter all the details";
      }
      if (name.isEmpty && cast.isNotEmpty && director.isNotEmpty) {
        res = "Movie name cannot be empty";
      }
      if (name.isNotEmpty && cast.isEmpty && director.isNotEmpty) {
        res = "cast field be empty";
      }
      if (name.isNotEmpty && cast.isNotEmpty && director.isEmpty) {
        res = "Director field cannot be empty";
      }
      if (name.isNotEmpty && cast.isEmpty && director.isEmpty) {
        res = "Cast, Director fields cannot be empty";
      }
      if (name.isEmpty && cast.isNotEmpty && director.isEmpty) {
        res = "Name, Director fields cannot be empty";
      }
      if (name.isEmpty && cast.isEmpty && director.isNotEmpty) {
        res = "Name, Cast fields cannot be empty";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //update a movie
  Future<String> updateMovie(
    String name,
    String cast,
    String director,
    Uint8List imageUrl,
    String movieid,
  ) async {
    String res = "An error occured";

    try {
      String photoUrl =
          await ImageStorageMethods().uploadImage('movies', imageUrl, true);
      await _firestore.collection('movie').doc(movieid).update({
        'name': name,
        'director': director,
        'cast': cast,
        'movieid': movieid,
        'imageUrl': photoUrl,
      });
    } catch (err) {
      res = err.toString();
      print("The error about upadting the movie is " + res);
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
