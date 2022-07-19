import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FileStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // adding images to the storage
  Future<String> uploadImage(
      String childName, Uint8List file, bool isPost) async {
    //ref is a reference to the file that either exists or doesn't exists,
    // if it exists, adds the files in to the folder or creates the folder
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    // it will give the download URL, to access the images
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
