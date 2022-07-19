import 'package:cinemafinder/admin/adminHome.dart';
import 'package:cinemafinder/authentication/loginUI.dart';
import 'package:cinemafinder/authentication/signUp.dart';
import 'package:cinemafinder/userView/homeScreen.dart';
import 'package:cinemafinder/welcomeScreens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinemafinder/welcomeScreens/dashBoard.dart';
import 'package:firebase_core/firebase_core.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // if (snapshot.hasData) {
            //   return movieHomeScreen();
            // }
            if (snapshot.hasData) {
              return loginAcount();
            } else if (snapshot.hasError) {
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
    );
  }
}
