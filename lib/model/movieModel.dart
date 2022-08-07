// This file is used to model the details of a movie to store in the firebase

import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  // final String movieName;
  // final String castDetails;
  // final String directorName;
  // final String movieId;
  // final String movieUrl;
  final String name;
  final String cast;
  final String director;
  // final String movieid;
  final String imageUrl;
  final movieid;
//   final randomid;

  //constructor
  // const Movie(
  //     {required this.movieName,
  //     required this.castDetails,
  //     required this.directorName,
  //     required this.movieId,
  //     required this.movieUrl});
  const Movie({
    required this.name,
    required this.cast,
    required this.director,
    required this.movieid,
    required this.imageUrl,
    //    required this.randomid
  });

  // this method is used to convert user object from the above to the object

  // Map<String, dynamic> toJson() => {
  //       "movieName": movieName,
  //       "castDetails": castDetails,
  //       "directorName": directorName,
  //       "movieId": movieId,
  //       "movieUrl": movieUrl,
  //     };
  Map<String, dynamic> toJson() => {
        "name": name,
        "cast": cast,
        "director": director,
        "movieid": movieid,
        "imageUrl": imageUrl,
        //      "randomid": randomid,
      };

  //This will take document snapshot and returns usermodel
  static Movie fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    // return Movie(
    //     movieName: snapshot['movieName'],
    //     castDetails: snapshot['castDetails'],
    //     directorName: snapshot['directorName'],
    //     movieId: snapshot['movieId'],
    //     movieUrl: snapshot['movieUrl']);
    return Movie(
      name: snapshot['name'],
      cast: snapshot['cast'],
      director: snapshot['director'],
      movieid: snapshot['movieid'],
      imageUrl: snapshot['imageUrl'],
      //    randomid: snapshot['randomid'],
    );
  }
}
