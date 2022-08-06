import 'dart:typed_data';

import 'package:cinemafinder/admin/addMoviesMethod.dart';
import 'package:cinemafinder/admin/adminHome.dart';
import 'package:cinemafinder/reusables/imageUpload.dart';
import 'package:cinemafinder/reusables/textFields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addMovie extends StatefulWidget {
  const addMovie({Key? key}) : super(key: key);

  @override
  State<addMovie> createState() => _addMovieState();
}

class _addMovieState extends State<addMovie> {
  String uid = "";
  Uint8List? _file;
  bool isUploading = false;

  final TextEditingController movieNameController = TextEditingController();
  final TextEditingController castDetailsController = TextEditingController();
  final TextEditingController directorNameController = TextEditingController();

  void getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    print(snap.data());

    setState(() {
      uid = (snap.data() as Map<String, dynamic>)['uid'];
    });
  }

  //to post Movie to the database
  void postMovie(uid) async {
    setState(() {
      isUploading = true;
    });
    try {
      String res = await FireStoreMethods().uploadMovie(
          movieNameController.text,
          castDetailsController.text,
          directorNameController.text,
          _file!,
          uid);

      print("Res after adding the movie is " + res);
      // String res = await FireStoreMethods().uploadMovie(
      //     movieNameController.text,
      //     castDetailsController.text,
      //     directorNameController.text,
      //     _file!,
      //     uid,);
      if (res == "Movie uploaded") {
        setState(() {
          isUploading = false;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
            title: Text('ALERT'),
            contentPadding: EdgeInsets.all(20),
            content: Text(res),
          ),
        );
        setState(() {
          _file = null;
        });
      } else {
        isUploading = false;
        res = "Movie Notuploaded";
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
            title: Text('ALERT'),
            contentPadding: EdgeInsets.all(20),
            content: Text(res),
          ),
        );
      }
    } catch (err) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
          title: Text('ALERT'),
          contentPadding: EdgeInsets.all(20),
          content: Text(err.toString()),
        ),
      );
    }
  }

  // This function is used to slect movie image from the gallery
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              'Choose a photo',
              style: TextStyle(
                  fontFamily: 'IbarraRealNova',
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'From gallery',
                  style: TextStyle(
                      fontFamily: 'IbarraRealNova',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blueAccent),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.only(left: 160),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        fontFamily: 'IbarraRealNova',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.redAccent),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    movieNameController.dispose();
    castDetailsController.dispose();
    directorNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'Add a movie',
                style: TextStyle(
                    fontFamily: 'IbarraRealNova',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.redAccent[400],
            ),
            body: Center(
              child: IconButton(
                icon: Icon(Icons.cloud_upload),
                onPressed: () => _selectImage(context),
              ),
            ),
          )
        : Scaffold(
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
                    isUploading
                        ? LinearProgressIndicator(
                            color: Colors.redAccent[400],
                          )
                        : Padding(padding: EdgeInsets.only(top: 0)),
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      backgroundImage: MemoryImage(_file!),
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
                        onPressed: () => postMovie(uid),
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
