import 'package:cinemafinder/authentication/loginUI.dart';
import 'package:cinemafinder/authentication/signOutMethod.dart';
import 'package:cinemafinder/model/movieModel.dart';
import 'package:cinemafinder/reusables/textFields.dart';
import 'package:cinemafinder/userView/movieCard.dart';
import 'package:cinemafinder/userView/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class movieHomeScreen extends StatefulWidget {
  const movieHomeScreen({Key? key}) : super(key: key);

  @override
  State<movieHomeScreen> createState() => _movieHomeScreenState();
}

class _movieHomeScreenState extends State<movieHomeScreen> {
  TextEditingController searchMovieController = TextEditingController();
  List allMovies = [];
  List resultsMovies = [];
  late Future MovieLoaded;
  String fullName = "";

  @override
  void initState() {
    super.initState();
    getUserDetails();
    searchMovieController.addListener(_searchMovie);
  }

  void getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    print(snap.data());

    setState(() {
      fullName = (snap.data() as Map<String, dynamic>)['fullName'];
    });
  }

  @override
  void dispose() {
    super.dispose();
    //  searchMovieController.dispose();
    searchMovieController.removeListener(_searchMovie);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    MovieLoaded = getMovieStream();
  }

  _searchMovie() {
    print("Home Screen" + searchMovieController.text);
    searchMoviesList();
  }

  searchMoviesList() {
    var showMovies = [];
    if (searchMovieController.text != "") {
      for (var movieSnapshot in allMovies) {
        // var title = Movie.fromSnap(movieSnapshot).name.toLowerCase();
        var movieName = Movie.fromSnap(movieSnapshot).name.toLowerCase();
        if (movieName.contains(searchMovieController.text.toLowerCase())) {
          showMovies.add(movieSnapshot);
        }
      }
    } else {
      showMovies = List.from(allMovies);
    }
    setState(() {
      resultsMovies = showMovies;
    });
  }
  getMovieStream() async {
    var movieData = await FirebaseFirestore.instance.collection('movie').get();
    setState(() {
      allMovies = movieData.docs;
    });
    searchMoviesList();

    return "success";
  }

      ),
    );
  }
}
