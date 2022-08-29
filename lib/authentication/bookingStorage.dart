import 'package:cloud_firestore/cloud_firestore.dart';

class bookingStorageMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> bookingStorage(
    String movieDate,
    String movieTime,
    String movieid,
    String numberOfSeats,
    // int numberOfSeats,
    String theaterid,
    String totalPayment,
    // int totalPayment,
    String uid,
  ) async {
    String res = "An error occured";

    try {
      if (movieDate.isNotEmpty &&
          movieTime.isNotEmpty &&
          movieid.isNotEmpty &&
          numberOfSeats.isNotEmpty &&
          //  (numberOfSeats != null) &&
          theaterid.isNotEmpty &&
          totalPayment.isNotEmpty &&
          //  (totalPayment != null) &&
          uid.isNotEmpty) {
        final bookingid = _firestore.collection('booking').doc();

        await _firestore.collection('booking').doc(bookingid.id).set({
          'movieDate': movieDate,
          'movieTime': movieTime,
          'movieid': movieid,
          'numberOfSeats': numberOfSeats,
          'theaterid': theaterid,
          'totalPayment': '\$' + totalPayment,
          'uid': uid,
        });
        res = "booking saved";
        print("Success res is " + res);
        
      } else {
        res = "booking not saved";
        print("fail res is " + res);
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
