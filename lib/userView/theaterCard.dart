// This file deals with displaying of movies in the database in particular format
import 'package:cinemafinder/userView/theaterScreen.dart';
import 'package:cinemafinder/userView/ticketBooking.dart';
import 'package:flutter/material.dart';

class theaterCard extends StatelessWidget {
  final snap;
  const theaterCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ticketBooking()));
      },
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.32,
        child: Card(
          color: Colors.redAccent[400],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                snap['name'],
              ),
              Text(
                snap['address'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
