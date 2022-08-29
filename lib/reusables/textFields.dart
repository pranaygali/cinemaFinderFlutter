import 'package:flutter/material.dart';

class textFields extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isObscure;
  final String labalText;
  final TextInputType textInputType;

  const textFields(
      {Key? key,
      required this.textEditingController,
      this.isObscure = false,
      required this.labalText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        // hintText: hintText,
        // labelText: hintText,
        border: OutlineInputBorder(
          borderSide: Divider.createBorderSide(context),
        ),
        filled: false,
        labelText: labalText,
        contentPadding: EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isObscure,

    );
  }
}
