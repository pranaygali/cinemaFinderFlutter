// This file deals with displaying of movies in the database in particular format
import 'package:cinemafinder/admin/addMoviesMethod.dart';
import 'package:cinemafinder/admin/editMovies.dart';
import 'package:cinemafinder/admin/editTheaters.dart';
import 'package:cinemafinder/model/movieModel.dart';
import 'package:cinemafinder/userView/theaterScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class bookingCard extends StatefulWidget {
  final snap;
  const bookingCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<bookingCard> createState() => _bookingCardState();
}

class _bookingCardState extends State<bookingCard> {
  String movieName = "";
  String theaterName = "";
//  late String documentId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieName();
  }

  void getMovieName() async {
    await FirebaseFirestore.instance
        .collection('movie')
        .where('movieid', isEqualTo: widget.snap['movieid'])
        .get()
        .then((value) => movieName = value.docs[0].get('name'));

    await FirebaseFirestore.instance
        .collection('theater')
        .where('theaterid', isEqualTo: widget.snap['theaterid'])
        .get()
        .then((value) => theaterName = value.docs[0].get('name'));

    //  final documentId = FirebaseFirestore.instance.collection('booking').where('movieid', isEqualTo: widget.snap['movieid']).get();

    //   print("The booking id is " + documentId);

    setState(() {
      movieName = movieName;
      theaterName = theaterName;
    });

    print("movie name is " + movieName);
    print("Theater name is " + theaterName);
    print("Movie id is " + widget.snap['movieid']);
    print("Movie Date is " + widget.snap['movieDate']);
    print("Movie Time is " + widget.snap['movieTime']);
    print("Number of seats: " + widget.snap['numberOfSeats']);
    print("Payment " + widget.snap['totalPayment']);
    print("The current user id is " + FirebaseAuth.instance.currentUser!.uid);
    //  print("The booking id is " + documentId);

    //  return movieName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.50,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //  crossAxisAlignment: CrossAxisAlignment.,
          children: [
            Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Order Id: ',
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Liger',
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Date: ',
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.snap['movieDate'],
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Seats: ',
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.snap['numberOfSeats'],
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Movie: ',
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  movieName,
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Theater: ',
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  theaterName,
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show: ',
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.snap['movieTime'],
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Price: ',
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.snap['totalPayment'],
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),

            // Container(
            //   height: 270,
            //   width: 150,
            //   // width
            //   // height: MediaQuery.of(context).size.height * 0.35,
            //   child: Image.network(snap['imageUrl']),
            // ),

            // Container(
            //   //  width: double.infinity,
            //   width: 210,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Text(
            //         snap['name'],
            //         style: TextStyle(
            //             fontFamily: 'IbarraRealNova',
            //             fontSize: 30,
            //             fontWeight: FontWeight.bold),
            //       ),
            //       MaterialButton(
            //         minWidth: double.infinity,
            //         height: 50,
            //         onPressed: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => editMovies(
            //                       imageUrl: snap['imageUrl'],
            //                       name: snap['name'],
            //                       cast: snap['cast'],
            //                       director: snap['director'],
            //                       movieid: snap['movieid'])));
            //         },
            //         elevation: 0,
            //         child: Text(
            //           'Edit',
            //           style: TextStyle(
            //               fontSize: 25,
            //               fontFamily: 'IbarraRealNova',
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white),
            //         ),
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(20)),
            //         color: Colors.redAccent[400],
            //       ),
            //       MaterialButton(
            //         minWidth: double.infinity,
            //         height: 50,
            //         onPressed: () async {
            //           FireStoreMethods().deleteMovie(snap['movieid']);
            //         },
            //         child: Text(
            //           'Delete',
            //           style: TextStyle(
            //               fontFamily: 'IbarraRealNova',
            //               fontSize: 25,
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold),
            //         ),
            //         elevation: 0,
            //         color: Colors.redAccent[400],
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(20)),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
