import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revision_2/models/user.dart' as myApp;

class FireStoreServcies{

  Future<void> addUser(myApp.User user) async{
    await FirebaseFirestore.instance.collection('users').add(user.toMap());
  }

  Future<void> setUser(myApp.User user) async{
    String id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(id).set(user.toMap());
  }

  Future<myApp.User?> getUserData() async{
    String id = FirebaseAuth.instance.currentUser!.uid;
    var snapshot = await FirebaseFirestore.instance.collection('users').doc(id).get();
    if(snapshot.exists){
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      myApp.User user = myApp.User.fromMap(data);
      return user;
    }
    return null;
  }
}