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

            Container(
              //  width: double.infinity,
              width: 210,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    snap['name'],
                    style: TextStyle(
                        fontFamily: 'IbarraRealNova',
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: () {},
                    elevation: 0,
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'IbarraRealNova',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.redAccent[400],
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: () async {
                      FireStoreMethods().deleteMovie(snap['movieid']);
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                          fontFamily: 'IbarraRealNova',
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    elevation: 0,
                    color: Colors.redAccent[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
            ),

            // Column(
            //   //  mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text(
            //       'Movie: Acharya',
            //       style: TextStyle(
            //           fontFamily: 'IbarraRealNova',
            //           fontWeight: FontWeight.bold,
            //           fontSize: 15),
            //     ),
            //     Text('Cast: Chiranjeevi, Ram Charan',
            //         style: TextStyle(
            //             fontFamily: 'IbarraRealNova',
            //             fontWeight: FontWeight.bold,
            //             fontSize: 15)),
            //     Text('Director: Koratala Siva',
            //         style: TextStyle(
            //             fontFamily: 'IbarraRealNova',
            //             fontWeight: FontWeight.bold,
            //             fontSize: 15)),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
