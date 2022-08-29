import 'package:cinemafinder/admin/adminHome.dart';
import 'package:cinemafinder/authentication/loginUI.dart';
import 'package:cinemafinder/authentication/signUp.dart';
import 'package:cinemafinder/provider/userProvider.dart';
import 'package:cinemafinder/userView/homeScreen.dart';
import 'package:cinemafinder/welcomeScreens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinemafinder/welcomeScreens/dashBoard.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(cinemaFinder());
}

class cinemaFinder extends StatefulWidget {
  const cinemaFinder({Key? key}) : super(key: key);

  @override
  State<cinemaFinder> createState() => _cinemaFinderState();
}

class _cinemaFinderState extends State<cinemaFinder> {
  String fullName = "";

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  // to fetch user/admin details from the database
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // if (snapshot.hasData) {
              //   return movieHomeScreen();
              // }
              if (snapshot.hasData && fullName == "admin") {
                print(fullName);
                return adminHomeScreen();
              } else if (snapshot.hasData) {
                return movieHomeScreen(
                  
                );
              }

              // if (snapshot.hasData && fullName == "ADMIN") {
              //   print(fullName);
              //   if (fullName == "ADMIN") {
              //     return adminHomeScreen();
              //   } else{
              //     return loginAcount();
              //   }
              // }
              else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.redAccent[400],
                ),
              );
            }
            return splash();
          },
        ),
      ),
    );
  }
}
