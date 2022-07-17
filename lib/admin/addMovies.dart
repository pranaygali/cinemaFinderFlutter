import 'package:cinemafinder/admin/adminHome.dart';
import 'package:cinemafinder/reusables/textFields.dart';
import 'package:flutter/material.dart';

class addMovie extends StatefulWidget {
  const addMovie({Key? key}) : super(key: key);

  @override
  State<addMovie> createState() => _addMovieState();
}

class _addMovieState extends State<addMovie> {
  final TextEditingController movieNameController = TextEditingController();

  final TextEditingController castDetailsController = TextEditingController();

  final TextEditingController directorNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        centerTitle: true,
        title: Text(
          'Add a movie',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/Acharya.jpeg'),
                radius: 94,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: textFields(
                    textEditingController: movieNameController,
                    labalText: 'Enter Movie Name',
                    textInputType: TextInputType.text),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: textFields(
                    textEditingController: castDetailsController,
                    labalText: 'Enter Cast Details',
                    textInputType: TextInputType.text),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: textFields(
                    textEditingController: directorNameController,
                    labalText: "Enter Director's Name",
                    textInputType: TextInputType.text),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => adminHomeScreen()));
                  },
                  color: Colors.redAccent[400],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'IbarraRealNova',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
