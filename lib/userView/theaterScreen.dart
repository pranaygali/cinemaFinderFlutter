import 'package:cinemafinder/model/theaterModel.dart';
import 'package:cinemafinder/userView/theaterCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class theaterScreen extends StatefulWidget {
  const theaterScreen({Key? key}) : super(key: key);

  @override
  State<theaterScreen> createState() => _theaterScreenState();
}

class _theaterScreenState extends State<theaterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // context function

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
            itemBuilder: (context, index) => theaterCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}
