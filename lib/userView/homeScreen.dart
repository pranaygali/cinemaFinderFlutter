import 'package:cinemafinder/authentication/loginUI.dart';
import 'package:cinemafinder/authentication/signOutMethod.dart';
import 'package:cinemafinder/model/movieModel.dart';
import 'package:cinemafinder/reusables/textFields.dart';
import 'package:cinemafinder/userView/bookingHistory.dart';
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

        //else {
        //   Text('No suggestions');
        // }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.person),
          );
        } // context function
            ),
        backgroundColor: Colors.redAccent[400],
        title: Text(
          'Now showing',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.redAccent[400],
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  'Entertainment4U',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.white,
                      fontFamily: 'IbarraRealNova'),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text(
                'profile',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'IbarraRealNova',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => userProfile()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.movie, color: Colors.white),
              title: Text(
                'Booking History',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'IbarraRealNova',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => bookingHistory()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'logout',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'IbarraRealNova',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () async {
                await SignOutMethod().signOutUser();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => loginAcount()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              child: TextField(
                controller: searchMovieController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context),
                  ),
                  filled: false,
                  labelText: "search movies",
                  contentPadding: EdgeInsets.all(8),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Expanded(
              //  child: Center(),
              child: resultsMovies.length == 0
                  ? Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(
                          fontFamily: 'IbarraRealNova',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: resultsMovies.length,
                      itemBuilder: (BuildContext context, int index) =>
                          movieCard(snap: resultsMovies[index])),
            ),
          ],
        ),
      ),
    );
  }
}
