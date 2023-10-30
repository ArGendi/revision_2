import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageServices{
  void uploadImage(File file){
    String id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseStorage.instance.ref().child("$id.jpg").putFile(file);
  }

  Future<String> getProfileImage() async{
    String id = FirebaseAuth.instance.currentUser!.uid;
    String url = await FirebaseStorage.instance.ref().child("$id.jpg").getDownloadURL();
    return url;
  }
}