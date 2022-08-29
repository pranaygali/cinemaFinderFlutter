import 'package:cinemafinder/admin/addTheatersUI.dart';
import 'package:cinemafinder/admin/adminMovieCard.dart';
import 'package:cinemafinder/admin/adminTheaterCard.dart';
import 'package:cinemafinder/authentication/loginUI.dart';
import 'package:cinemafinder/authentication/signOutMethod.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class adminTheaterList extends StatefulWidget {
  const adminTheaterList({Key? key}) : super(key: key);

  @override
  State<adminTheaterList> createState() => _adminTheaterListState();
}

class _adminTheaterListState extends State<adminTheaterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => addTheater()));
            },
            icon: Icon(
              Icons.add,
              size: 40,
            )),
        title: Text(
          'All Theaters',
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
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('theater').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => adminTheaterCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}
