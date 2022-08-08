import 'package:cinemafinder/admin/addMovies.dart';
import 'package:flutter/material.dart';

class adminHomeScreen extends StatefulWidget {
  const adminHomeScreen({Key? key}) : super(key: key);

  @override
  State<adminHomeScreen> createState() => _adminHomeScreenState();
}

class _adminHomeScreenState extends State<adminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => addMovie()));
          },
          icon: Icon(
            Icons.add,
            size: 40,
          ),
        ),
        title: Text(
          'Welcome Admin',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.logout,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
