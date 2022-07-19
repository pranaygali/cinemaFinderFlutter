import 'package:cinemafinder/welcomeScreens/dashBoard.dart';
import 'package:flutter/material.dart';

//void main() => runApp(splash());

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => dashBored()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,

          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(
              height: 120,
            ),
            CircleAvatar(
              radius: 74,
              backgroundImage: AssetImage('assets/movies.jpg'),
            ),
            Text(
              'Cinema Finder',
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Padding(
                padding: EdgeInsets.only(top: 350),
                child: Text(
                  'From',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Team 3',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            )
          ],
        ),
      ),
    );
  }
}

