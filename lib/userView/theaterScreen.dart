import 'package:cinemafinder/model/theaterModel.dart';
import 'package:flutter/material.dart';

class theaterScreen extends StatefulWidget {
  const theaterScreen({Key? key}) : super(key: key);

  @override
  State<theaterScreen> createState() => _theaterScreenState();
}

class _theaterScreenState extends State<theaterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // context function

        backgroundColor: Colors.redAccent[400],
        title: Text(
          'Now showing',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
    );
  }
}
