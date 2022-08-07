import 'package:cinemafinder/admin/addMoviesUI.dart';
import 'package:cinemafinder/admin/adminMovieCard.dart';
import 'package:cinemafinder/authentication/loginUI.dart';
import 'package:cinemafinder/authentication/signOutMethod.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinemafinder/userView/movieCard.dart';

class adminMovieList extends StatefulWidget {
  const adminMovieList({Key? key}) : super(key: key);

  @override
  State<adminMovieList> createState() => _adminMovieListState();
}

class _adminMovieListState extends State<adminMovieList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => addMovie()));
            },
            icon: Icon(
              Icons.add,
              size: 40,
            )),
        title: Text(
          'All Movies',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await SignOutMethod().signOutUser();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => loginAcount()));
              },
              icon: Icon(
                Icons.logout,
                size: 40,
              ))
        ],
        backgroundColor: Colors.redAccent[400],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('movie').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => adminMovieCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}
