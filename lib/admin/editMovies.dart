import 'dart:typed_data';

import 'package:cinemafinder/admin/addMoviesMethod.dart';
import 'package:cinemafinder/reusables/imageUpload.dart';
import 'package:cinemafinder/reusables/textFields.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class editMovies extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String cast;
  final String director;
  final String movieid;
  const editMovies(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.cast,
      required this.director,
      required this.movieid})
      : super(key: key);

  @override
  State<editMovies> createState() => _editMoviesState();
}

class _editMoviesState extends State<editMovies> {
  Uint8List? _file;
  bool isUploading = false;
  Uint8List? _finalImage;
  TextEditingController updateMovieNameController = TextEditingController();
  TextEditingController updateMovieCastController = TextEditingController();
  TextEditingController updateMovieDirectorController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateMovieNameController.text = widget.name;
    updateMovieCastController.text = widget.cast;
    updateMovieDirectorController.text = widget.director;
  }

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
                    isUploading = true;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        title: Text(
          'Edit Movie',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.center,
            //  mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // SizedBox(
              //   height: 30,
              // ),
              Stack(children: [
                isUploading
                    ? CircleAvatar(
                        backgroundImage: MemoryImage(_file!),
                        radius: 84,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(widget.imageUrl),
                        radius: 84,
                      ),
                Positioned(
                  bottom: -10,
                  right: 10,
                  child: IconButton(
                    onPressed: () => _selectImage(context),
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.redAccent[400],
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 30,
              ),
              textFields(
                  textEditingController: updateMovieNameController,
                  labalText: 'edit movie name',
                  textInputType: TextInputType.text),
              SizedBox(
                height: 30,
              ),
              textFields(
                  textEditingController: updateMovieCastController,
                  labalText: 'edit movie cast',
                  textInputType: TextInputType.text),
              SizedBox(
                height: 30,
              ),
              textFields(
                  textEditingController: updateMovieDirectorController,
                  labalText: 'edit movie director',
                  textInputType: TextInputType.text),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () async {
                  if (updateMovieNameController != null &&
                      updateMovieCastController != null &&
                      updateMovieDirectorController != null) {
                    setState(() {
                      if (_file != null) {
                        _finalImage = _file;
                      }
                      if (_file == null) {
                        _finalImage = widget.imageUrl as Uint8List?;
                      }
                    });
                    FireStoreMethods().updateMovie(
                        updateMovieNameController.text,
                        updateMovieCastController.text,
                        updateMovieDirectorController.text,
                        _finalImage!,
                        widget.movieid);
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
                        content: Text('Updates saved'),
                      ),
                    );
                  }
                  if (updateMovieNameController == null &&
                      updateMovieCastController == null &&
                      updateMovieDirectorController == null) {
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
                        content: Text(
                          'Fields cannot be empty',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'IbarraRealNova',
                          ),
                        ),
                      ),
                    );
                  }
                },
                elevation: 0,
                height: 50,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.redAccent[400],
                child: Text(
                  'Save Changes',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IbarraRealNova',
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
