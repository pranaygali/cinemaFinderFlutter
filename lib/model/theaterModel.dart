// This file is used to model the details of a theater to store in the firebase

import 'package:cloud_firestore/cloud_firestore.dart';

class Theater {
  final String name;
  final String address;
//  final String theaterCapacity;
  final String theaterId;
  // final String theaterUrl;

  //constructor
  const Theater({
    required this.name,
    required this.address,
    //  required this.theaterCapacity,
    required this.theaId,
    //required this.theaterUrl
  });

  // this method is used to convert user object from the above to the object

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        //    "theaterCapacity": theaterCapacity,
        "theaterid": theaterId,
        //  "theaterUrl": theaterUrl,
      };

  //This will take document snapshot and returns usermodel
  static Theater fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Theater(
      name: snapshot['name'],
      //  theaterLocation: snapshot['theaterLocation'],
      address: snapshot['address'],
      //  theaterCapacity: snapshot['theaterCapacity'],
      theaterId: snapshot['theaterId'],
      //  theaterUrl: snapshot['theaterUrl']
    );
  }
}
