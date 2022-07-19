import 'package:cinemafinder/admin/adminHome.dart';
import 'package:cinemafinder/authentication/authMethods.dart';
import 'package:cinemafinder/authentication/forgotPassword.dart';
import 'package:cinemafinder/authentication/loginMethod.dart';
import 'package:cinemafinder/authentication/signUp.dart';
import 'package:cinemafinder/reusables/textFields.dart';
import 'package:cinemafinder/userView/homeScreen.dart';
import 'package:flutter/material.dart';

class loginAcount extends StatefulWidget {
  const loginAcount({Key? key}) : super(key: key);

  @override
  State<loginAcount> createState() => _loginAcountState();
}

class _loginAcountState extends State<loginAcount> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    String res = await LoginMethod().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == "logged in" &&
        emailController.text == "admin@gmail.com" &&
        passwordController.text == "12345678") {
      print('logged in but not going');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => adminHomeScreen()),
      );
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
          content: Text('LOGIN SUCCESSFULL'),
        ),
      );
    } else if (res == "logged in") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => movieHomeScreen()));
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
          content: Text('LOGIN SUCCESSFULL'),
        ),
      );
    } else {
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
          title: Text('WARNING'),
          contentPadding: EdgeInsets.all(20),
          content: Text('KINDLY CHECK THE DETAILS ENTERED'),
        ),
      );
    }
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
                  height: 40,
                ),
                Text(
                  'Cinema Finder',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'IbarraRealNova',
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/movies.jpg',
                  height: 180,
                ),
                SizedBox(
                  height: 60,
                ),
                textFields(
                    textEditingController: emailController,
                    labalText: 'Enter your email',
                    textInputType: TextInputType.emailAddress),
                SizedBox(
                  height: 20,
                ),
                textFields(
                  textEditingController: passwordController,
                  labalText: 'Enter your password',
                  textInputType: TextInputType.text,
                  isObscure: true,
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: loginUser,
                  /* () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => newLogin()),
                          );
                          
                    },
                    */
                  color: Colors.redAccent[400],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'IbarraRealNova',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => forgotPassword()),
                        );
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            fontFamily: 'IbarraRealNova',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Don't have an account?",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IbarraRealNova',
                          )),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => createAcount()),
                        );
                      },
                      child: Container(
                        child: Text(
                          " Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'IbarraRealNova',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
