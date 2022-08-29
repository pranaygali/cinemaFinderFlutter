//This file deals with the screen that displays date and time to book the movie

import 'package:cinemafinder/authentication/bookingStorage.dart';
import 'package:cinemafinder/userView/payConfirm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ticketBooking extends StatefulWidget {
  final String movieName;
  final String movieId;
  final String theaterName;
  final String theaterId;
  const ticketBooking(
      {Key? key,
      required this.movieName,
      required this.theaterName,
      required this.movieId,
      required this.theaterId})
      : super(key: key);

  @override
  State<ticketBooking> createState() => _ticketBookingState();
}

class _ticketBookingState extends State<ticketBooking> {
  late Razorpay _razorpay;
  late DateTime _dateTime;
  String time = DateTime.now().toString();
  int dating = 0; // used for the number of tickets counter
  int ticketPrice = 15;
  int totalTicketPrice = 0; // used to calculate the total tickets price
  int selectedDate = 0; // to navigate to the next page
  bool selectedSeats = false; // to navigate to the next page
  int paymentTotal = 0;
  String movieTiming = ""; // used for show timing

  bool sevenPM = false;
  bool eightPM = false;
  bool ninePM = false;

  // String moneyContact = "4385097570";
  // String moneyEmail = "ready@gmail.com";
  // String moneyDetails = "CAD 100";

  String email = "";
  String contactNumber = "";

  String userUid = FirebaseAuth.instance.currentUser!.uid;

  void getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    print(snap.data());

    setState(() {
      contactNumber = (snap.data() as Map<String, dynamic>)['contactNumber'];
      email = (snap.data() as Map<String, dynamic>)['email'];
    });
  }

  int sendMoney() {
    setState(() {
      paymentTotal = totalTicketPrice;
    });
    return paymentTotal;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();

    _razorpay = new Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openPaymentGateway() {
    var options = {
      'key': "rzp_test_SFxEqBDo1xFlnr",
      'currency': "CAD",
      'amount': (totalTicketPrice * 100).toString(),
      'name': 'Cinema Finder',
      'description': 'Movie Ticket',
      'timeout': 300, // in seconds
      'prefill': {'contact': contactNumber, 'email': email}
    };
    try {
      _razorpay.open(options);
    } catch (err) {
      print("Error message is " + err.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done " +
        response.toString() +
        ", Payment Id:" +
        response.paymentId.toString());
    addBooking();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => payConfirm(
                  movieDate: time,
                  movieTime: movieTiming,
                  movieId: widget.movieId,
                  numberOfSeats: dating.toString(),
                  theaterid: widget.theaterId,
                  totalPayment: totalTicketPrice.toString(),
                  movieName: widget.movieName,
                  theaterName: widget.theaterName,
                )));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment not processed");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(
                  fontFamily: 'IbarraRealNova',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ],
        title: Text(
          'Alert',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        contentPadding: EdgeInsets.all(20),
        content: Text(
          'Payment not processed',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  void addBooking() async {
    try {
      String res = await bookingStorageMethods().bookingStorage(
          time.toString(),
          movieTiming,
          widget.movieId,
          dating.toString(),
          //  dating,
          widget.theaterId,
          totalTicketPrice.toString(),
          //  totalTicketPrice,
          userUid);
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Select date and time',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              widget.movieName,
              style: TextStyle(
                  fontFamily: 'IbarraRealNova',
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(height: 5),
            // Text(
            //   'at',
            //   style: TextStyle(
            //       fontFamily: 'IbarraRealNova',
            //       fontWeight: FontWeight.bold,
            //       fontSize: 30),
            // ),
            Text(
              widget.theaterName,
              style: TextStyle(
                  fontFamily: 'IbarraRealNova',
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 80,
            ),
            MaterialButton(
              onPressed: () async {
                _dateTime = (await (showDatePicker(
                    context: context,
                    // User can only select the date for upto 7 days, as the schedule changes everyweek.
                    initialDate: DateTime.now().add(Duration(days: 0)),
                    firstDate: DateTime.now().add(Duration(days: 0)),
                    lastDate: DateTime.now().add(Duration(days: 7)))))!;
                setState(() {
                  //  final now = DateTime.now();

                  //time = _dateTime.toString();
                  //  time = DateFormat.yMMMEd().format(_dateTime);
                  time = DateFormat.yMMMMd('en_US').format(_dateTime);
                  //  DateFormat.yMMMEd().format(DateTime.now());
                  selectedDate = 1;
                });
              },
              child: Text(
                'Select a date',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'IbarraRealNova',
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              color: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              height: 60,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              //"${time}".split(' ')[0],
              "${time}",
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'IbarraRealNova',
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 20,
                child: Divider(
                  height: 20,
                  color: Colors.red,
                ),
              ),
            ),
            Text(
              'Select number of Tickets',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'IbarraRealNova',
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 50,
              width: 150,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (dating != 0) {
                            dating -= 1;
                            totalTicketPrice = dating * ticketPrice;
                            selectedSeats = true;
                          }
                        });
                      },
                      icon: Icon(Icons.remove)),
                  Text(
                    '${dating}',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'IbarraRealNova',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (dating != 5) {
                            dating += 1;
                            totalTicketPrice = dating * ticketPrice;

                            selectedSeats = true;
                          }
                        });
                      },
                      icon: Icon(Icons.add)),
                ],
              ),
            ),
            Text(
              'Total Ticket Price: ${totalTicketPrice} CAD',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'IbarraRealNova',
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 20,
                child: Divider(
                  height: 20,
                  color: Colors.red,
                ),
              ),
            ),
            Text(
              'Select show timings',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'IbarraRealNova',
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      movieTiming = "07:00 PM";
                      sevenPM = true;
                      eightPM = false;
                      ninePM = false;
                    });
                  },
                  child: Text(
                    '07:00 PM',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'IbarraRealNova',
                        fontWeight: FontWeight.bold,
                        color: sevenPM ? Colors.red : Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      movieTiming = "08:00 PM";
                      eightPM = true;
                      ninePM = false;
                      sevenPM = false;
                    });
                  },
                  child: Text(
                    '08:00 PM',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'IbarraRealNova',
                        fontWeight: FontWeight.bold,
                        color: eightPM ? Colors.red : Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      movieTiming = "09:00 PM";
                      ninePM = true;
                      sevenPM = false;
                      eightPM = false;
                    });
                  },
                  child: Text(
                    '09:00 PM',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'IbarraRealNova',
                        fontWeight: FontWeight.bold,
                        color: ninePM ? Colors.red : Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 60,
              minWidth: 280,
              child: Text(
                'Book',
                style: TextStyle(
                    fontFamily: 'IbarraRealNova',
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (selectedSeats == true &&
                    selectedDate == 1 &&
                    totalTicketPrice != 0 &&
                    movieTiming.isNotEmpty) {
                  // openCheckout();
                  openPaymentGateway();
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'IbarraRealNova',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      title: Text('WARNING',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IbarraRealNova',
                            fontWeight: FontWeight.bold,
                          )),
                      contentPadding: EdgeInsets.all(20),
                      content: Text(
                        'PLEASE SELECT DATE, NUMBER OF SEATS, AND SHOW TIMINGS',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IbarraRealNova',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
                print("The time is " + time);
                print("show timings are " + movieTiming);
              },
              color: Colors.redAccent[400],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            // SizedBox(height: 20),
            // IconButton(
            //   onPressed: () {
            //     print('Movie id is ' + widget.movieId);
            //     print('Theater id is ' + widget.theaterId);
            //     print('Time is ' + time);
            //     print('Timing is ' + movieTiming);
            //   },
            //   icon: Icon(Icons.ac_unit),
            // )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }
}
