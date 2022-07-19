import 'package:cinemafinder/authentication/loginUI.dart';
import 'package:cinemafinder/authentication/signOutMethod.dart';
import 'package:cinemafinder/userView/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class movieHomeScreen extends StatefulWidget {
  const movieHomeScreen({Key? key}) : super(key: key);

  @override
  State<movieHomeScreen> createState() => _movieHomeScreenState();
}

class _movieHomeScreenState extends State<movieHomeScreen> {
  String fullName = "";

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    print(snap.data());

    setState(() {
      fullName = (snap.data() as Map<String, dynamic>)['fullName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.person),
          );
        } // context function
            ),
        backgroundColor: Colors.redAccent[400],
        title: Text(
          'Now Showing',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.redAccent[400],
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/Acharya.jpeg'),
                radius: 94,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text(
                '$fullName',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => userProfile()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'logout',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () async {
                await SignOutMethod().signOutUser();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => loginAcount()));
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
