// This file deals with displaying of movies in the database in particular format
import 'package:cinemafinder/admin/addMoviesMethod.dart';
import 'package:cinemafinder/userView/theaterScreen.dart';
import 'package:flutter/material.dart';

class adminMovieCard extends StatelessWidget {
  final snap;
  const adminMovieCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.32,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 270,
              width: 150,
              // width
              // height: MediaQuery.of(context).size.height * 0.35,
              //  child: Image.network(snap['imageUrl']),
            ),

           
          ],
        ),
      ),
    );
  }
}
