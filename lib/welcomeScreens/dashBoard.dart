import 'package:cinemafinder/authentication/loginUI.dart';
import 'package:cinemafinder/authentication/signUp.dart';
import 'package:flutter/material.dart';

class dashBored extends StatefulWidget {
  const dashBored({Key? key}) : super(key: key);

  @override
  State<dashBored> createState() => _dashBoredState();
}

class _dashBoredState extends State<dashBored> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[400],
      /*
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Cinema Finder',
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Colors.red,
        ),
        */
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'Cinema Finder',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IbarraRealNova',
                      color: Colors.white),
                ),
              ),
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 450,
                  //width: 350,
                  child: Image.asset('assets/Acharya.jpeg')),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => createAcount()),
                  );
                },
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.redAccent[400],
                      fontFamily: 'IbarraRealNova'),
                ),
              ),
            ),
            Divider(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => loginAcount()),
                  );
                },
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.redAccent[400],
                    fontFamily: 'IbarraRealNova',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
