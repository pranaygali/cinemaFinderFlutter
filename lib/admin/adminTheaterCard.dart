// This file deals with displaying of movies in the database in particular format
import 'package:cinemafinder/admin/addMoviesMethod.dart';
import 'package:cinemafinder/admin/addTheatersMethod.dart';
import 'package:cinemafinder/admin/editTheaters.dart';
import 'package:cinemafinder/userView/theaterScreen.dart';
import 'package:flutter/material.dart';

class adminTheaterCard extends StatelessWidget {
  final snap;

  const adminTheaterCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.23,
      child: Card(
        color: Colors.yellow,
        //  padding: EdgeInsets.all(50),
        child:
            // Container(
            //   height: 270,
            //   width: 150,
            //   // width
            //   // height: MediaQuery.of(context).size.height * 0.35,
            //   child: Image.network(snap['movieUrl']),
            // ),

            Container(
          //  width: double.infinity,
          width: 210,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 30, right: 30, bottom: 10),
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      snap['name'],
                      style: TextStyle(
                          fontFamily: 'IbarraRealNova',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent[400]),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => editTheaters(
                                theaterName: snap['name'],
                                theaterAddress: snap['address'],
                                theaterid: snap['theaterid'],
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit)),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      snap['address'],
                      style: TextStyle(
                          fontFamily: 'IbarraRealNova',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent[400]),
                    ),
                    IconButton(
                        onPressed: () async {
                          FireStoreTheaterMethods()
                              .deleteTheater(snap['theaterid']);
                        },
                        icon: Icon(Icons.delete_forever))
                  ],
                ),

                // MaterialButton(
                //   minWidth: double.infinity,
                //   height: 50,
                //   onPressed: () async {
                //     FireStoreTheaterMethods().deleteTheater(snap['theaterid']);
                //   },
                //   child: Text(
                //     'Delete',
                //     style: TextStyle(
                //         fontFamily: 'IbarraRealNova',
                //         fontSize: 25,
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold),
                //   ),
                //   elevation: 0,
                //   color: Colors.redAccent[400],
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20)),
                // ),
                // MaterialButton(
                //   minWidth: double.infinity,
                //   height: 50,
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => editTheaters(
                //                   theaterName: snap['name'],
                //                   theaterAddress: snap['address'],
                //                   theaterid: snap['theaterid'],
                //                 )));
                //   },
                //   elevation: 0,
                //   child: Text(
                //     'Edit',
                //     style: TextStyle(
                //         fontSize: 25,
                //         fontFamily: 'IbarraRealNova',
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white),
                //   ),
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20)),
                //   color: Colors.redAccent[400],
                // ),
              ],
            ),
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
      ),
    );
  }
}
