import 'package:cinemafinder/userView/bookingCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class bookingHistory extends StatefulWidget {
  const bookingHistory({Key? key}) : super(key: key);

  @override
  State<bookingHistory> createState() => _bookingHistoryState();
}

class _bookingHistoryState extends State<bookingHistory> {
  String userUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        title: Text(
          'Booking History',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'IbarraRealNova',
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('booking')
              .where('uid', isEqualTo: userUid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              print('Inside the no data');
              return Center(
                child: Text(
                  "I am empty, please feed me with some bookings",
                  style: TextStyle(fontFamily: 'IbarraRealNova', fontSize: 30),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => bookingCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
            // if (!snapshot.hasData) {
            //   print("Inside the if");
            //   return Center(
            //     child: Text(
            //       'No bookings found',
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontFamily: 'IbarraRealNova',
            //           fontSize: 30,
            //           fontWeight: FontWeight.bold),
            //     ),
            //   );
            // }
            // return Text('Data found',
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontFamily: 'IbarraRealNova',
            //         fontSize: 30,
            //         fontWeight: FontWeight.bold));
          }),
    );
  }
}
