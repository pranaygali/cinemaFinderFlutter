import 'package:cinemafinder/userView/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class payConfirm extends StatefulWidget {
  final String movieDate;
  final String movieTime;
  final String movieId;
  final String numberOfSeats;
  final String theaterid;
  final String totalPayment;
  final String movieName;
  final String theaterName;
  const payConfirm(
      {Key? key,
      required this.movieDate,
      required this.movieTime,
      required this.movieId,
      required this.numberOfSeats,
      required this.theaterid,
      required this.totalPayment,
      required this.movieName,
      required this.theaterName})
      : super(key: key);

  @override
  State<payConfirm> createState() => _payConfirmState();
}

class _payConfirmState extends State<payConfirm> {
  TextEditingController sendMailController = TextEditingController();

  String userUid = FirebaseAuth.instance.currentUser!.uid;

  String emailMatter = "Get ready to enjoy your show";

  Future sendEmail() async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_0kj0rsc";
    const templateId = "XXXXXXXXXXXXX";
    const userId = "xxxxxxxxxxxxxx";
    const accessToken = "XXXXXXXXXXXXXXX";

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "accessToken": accessToken,
          "template_params": {
            "subject": "Booking confirmation",
            "message": "Movie: " +
                widget.movieName +
                ", Theater: " +
                widget.theaterName +
                ", Movie Date: " +
                widget.movieDate +
                ", Show Timing: " +
                widget.movieTime +
                ", Price: \$" +
                widget.totalPayment +
                ", No.of Seats: " +
                widget.numberOfSeats,
            //"Thank you for your purchase today, enjoy your movie!",
            "user_email": sendMailController.text,
            "to_email": sendMailController.text,
          }
        }));
    print(
        "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!??????????????????????????????????!!!!!!!!!!!!!!!!!!!!!");
    print("The response is " + response.body.toString());
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent[400],
        title: Text(
          'Payment done',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => movieHomeScreen()));
            },
            icon: Icon(
              Icons.home_filled,
              size: 30,
            )),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: TextField(
                controller: sendMailController,
                decoration: InputDecoration(
                  hintText: 'Confirm your mail id',
                  border: OutlineInputBorder(),
                  labelText: 'confirm your mail id',
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                sendEmail();
              },
              child: Text(
                'Send confirmation',
                style: TextStyle(color: Colors.white),
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
            IconButton(
              onPressed: () {
                print("The current user uid is " + userUid);
                print("The movie date is " + widget.movieDate);
                print("The movieTime is " + widget.movieTime);
                print("The movieId is " + widget.movieId);
                print("The numberofseats are " + widget.numberOfSeats);
                print("The theaterid is " + widget.theaterid);
                print("The totalpayment is " + widget.totalPayment);
              },
              icon: Icon(Icons.swipe_outlined),
              iconSize: 40,
            ),
          ],
        ),
      ),
    );
  }
}
