// This file deals with displaying of movies in the database in particular format
import 'package:cinemafinder/userView/theaterScreen.dart';
import 'package:flutter/material.dart';

class movieCard extends StatelessWidget {
  final snap;
  const movieCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => theaterScreen()));
            },
            child: Container(
                height: 270,
                width: 150,
                // width
                // height: MediaQuery.of(context).size.height * 0.35,
                child: Image.network(snap['imageUrl'])
                // child: Image.asset('assets/Acharya.jpeg'),
                ),
          ),
          Container(
            //  width: double.infinity,
            width: 210,
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Movie: ' + snap['name'],
                    style: TextStyle(
                        fontFamily: 'IbarraRealNova',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Divider(
                    height: 20,
                    //  color: Colors.redAccent[400],
                  ),
                  Text(
                    'Cast: ' + snap['cast'],
                    style: TextStyle(
                        fontFamily: 'IbarraRealNova',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Divider(
                    height: 20,
                    //  color: Colors.redAccent[400],
                  ),
                  Text(
                    'Director: ' + snap['director'],
                    style: TextStyle(
                        fontFamily: 'IbarraRealNova',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
