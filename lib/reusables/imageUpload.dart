import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Image source is being provided by the ImagePicker. Image picker is a plugin used to choose photos from the library
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }

  print('No Image Selected');
}
