import 'package:firebase_auth/firebase_auth.dart';
class MyFirebaseAuth{

  Future<String?> login(String email, String pass) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
      return null;
    }
    on FirebaseAuthException catch(_){
      return 'Wrong email or password';
    }
    catch(e){
      return 'Try another time';
    }
  }

  Future<String?> signUp(String email, String password) async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    }
    on FirebaseAuthException catch(e){
      return e.code.replaceAll('-', ' ');
    }
    catch(e){
       return 'Try another time';
    }
  }
}