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

  
      ),
    );
  }
}
