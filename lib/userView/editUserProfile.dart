import 'package:cinemafinder/admin/addMoviesMethod.dart';
import 'package:cinemafinder/authentication/signUpMethod.dart';
import 'package:cinemafinder/reusables/textFields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class editUserProfile extends StatefulWidget {
  final String fullName;
  final String email;
  final String contactNumber;
  const editUserProfile(
      {Key? key,
      required this.fullName,
      required this.email,
      required this.contactNumber})
      : super(key: key);

  @override
  State<editUserProfile> createState() => _editUserProfileState();
}

class _editUserProfileState extends State<editUserProfile> {
  TextEditingController editfullNameController = TextEditingController();
  TextEditingController editemailController = TextEditingController();
  TextEditingController editContactNumberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      editfullNameController.text = widget.fullName;
      editemailController.text = widget.email;
      editContactNumberController.text = widget.contactNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
              fontFamily: 'IbarraRealNova',
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        backgroundColor: Colors.redAccent[400],
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: editfullNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context)),
                filled: false,
                labelText: 'enter fullname',
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 20,
            ),
            // textFields(
            //     textEditingController: editemailController,
            //     labalText: 'enter email',
            //     textInputType: TextInputType.text),
            // SizedBox(
            //   height: 20,
            // ),
            textFields(
                textEditingController: editContactNumberController,
                labalText: 'enter contactNumber',
                textInputType: TextInputType.text),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () async {
                String res = await AuthMethods().updateUserDetails(
                    editfullNameController.text,
                    editemailController.text,
                    editContactNumberController.text);
                if (res == "details updated!") {
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
                      title: Text('ALERT'),
                      contentPadding: EdgeInsets.all(20),
                      content: Text(res),
                    ),
                  );
                }
              },
              color: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Save Changes',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                    fontFamily: 'IbarraRealNova'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
