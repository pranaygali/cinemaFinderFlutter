import 'dart:typed_data';

import 'package:cinemafinder/authentication/authMethods.dart';
import 'package:cinemafinder/authentication/loginUI.dart';
import 'package:cinemafinder/reusables/imageUpload.dart';
import 'package:cinemafinder/reusables/snackbars.dart';
import 'package:cinemafinder/reusables/textFields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class createAcount extends StatefulWidget {
  const createAcount({Key? key}) : super(key: key);

  @override
  State<createAcount> createState() => _createAcountState();
}

class _createAcountState extends State<createAcount> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  Uint8List? _image;
  // RegExp regex =
  //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    contactNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void signUpUser() async {
    String res = await AuthMethods().signUpUser(
      fullName: fullNameController.text,
      contactNumber: contactNumberController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      //  file: _image!
    );
    //res is from the authmethods class
    if (res == "signup success") {
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

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => loginAcount()));

      //  showSnackBar(res, context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('SORRY'),
            ),
          ],
          title: Text('WARNING'),
          contentPadding: EdgeInsets.all(20),
          content: Text(res),
        ),
      );
    }
    print(res);
  }

// function to select the image, during the signup
  void selectImage() async {
    Uint8List photo =
        await chooseImage(ImageSource.gallery, ImageSource.camera);

    setState(() {
      _image = photo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*
                  Flexible(
                    child: Container(),
                    flex: 1,
                  ),
                  */
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Cinema Finder',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IbarraRealNova'),
                ),
                SizedBox(
                  height: 10,
                ),

                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            backgroundImage: AssetImage('assets/avatar.jpeg'),
                            radius: 64,
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(Icons.add_a_photo),
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 5,
                ),
                Text('Create an account',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IbarraRealNova')),
                SizedBox(
                  height: 30,
                ),
                textFields(
                    textEditingController: fullNameController,
                    labalText: 'Enter your fullname',
                    textInputType: TextInputType.text),
                SizedBox(
                  height: 20,
                ),
                textFields(
                  textEditingController: contactNumberController,
                  labalText: 'Enter your contact number',
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                textFields(
                  textEditingController: emailController,
                  labalText: 'Enter your email',
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                // TextFormField(
                //   validator: (value) => value == null || value.length < 8
                //       ? 'Enter minimum 8 characters'
                //       : !regex.hasMatch(value)
                //           ? 'Should contain \nOne Upper Case, \nOne Lower Case, \nOne Digit, \nOne Special Character'
                //           : null,
                //   controller: passwordController,
                //   decoration: InputDecoration(
                //     // hintText: hintText,
                //     // labelText: hintText,
                //     border: OutlineInputBorder(
                //       borderSide: Divider.createBorderSide(context),
                //     ),
                //     filled: false,
                //     labelText: 'Enter your password',
                //     contentPadding: EdgeInsets.all(8),
                //   ),
                //   keyboardType: TextInputType.text,
                //   obscureText: true,
                // ),

                // textFields(
                //   textEditingController: passwordController,
                //   labalText: 'Enter your password',
                //   textInputType: TextInputType.text,
                //   isObscure: true,
                // ),
                SizedBox(
                  height: 20,
                ),
                // TextFormField(
                //   validator: (value) => value == null || value.length < 8
                //       ? 'Enter minimum 8 characters'
                //       : !regex.hasMatch(value)
                //           ? 'Should contain \nOne Upper Case, \nOne Lower Case, \nOne Digit, \nOne Special Character'
                //           : null,
                //   controller: confirmPasswordController,
                //   decoration: InputDecoration(
                //     // hintText: hintText,
                //     // labelText: hintText,
                //     border: OutlineInputBorder(
                //       borderSide: Divider.createBorderSide(context),
                //     ),
                //     filled: false,
                //     labelText: 'Enter your password',
                //     contentPadding: EdgeInsets.all(8),
                //   ),
                //   keyboardType: TextInputType.text,
                //   obscureText: true,
                // ),
                // textFields(
                //   textEditingController: confirmPasswordController,
                //   labalText: 'confirm your password',
                //   textInputType: TextInputType.text,
                //   isObscure: true,
                // ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: signUpUser,

                  /* 
                    {
                       Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => newLogin()),
                          );
                          
                    },
                    */
                  color: Colors.red,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: 'IbarraRealNova'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Flexible(child: Container(), flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Already have an account?",
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'IbarraRealNova')),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => loginAcount()),
                        );
                      },
                      child: Container(
                        child: Text(
                          " login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'IbarraRealNova'),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
