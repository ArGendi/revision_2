import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:revision_2/controllers/login/login_state.dart';
import 'package:revision_2/local/shared_prference.dart';
import 'package:revision_2/models/user.dart';
import 'package:revision_2/screens/home_screen.dart';
import 'package:revision_2/services/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision_2/services/firestore_services.dart';

class LoginCubit extends Cubit<LoginState>{
  String? email;
  String? pass;
  bool hidden = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginCubit() : super(InitLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);

  void onLogin(BuildContext context) async{
    bool valid = formKey.currentState!.validate();
    if(valid){
      formKey.currentState!.save();
      emit(LoadingLoginState());
      MyFirebaseAuth myFirebaseAuth = MyFirebaseAuth();
      String? error = await myFirebaseAuth.login(email!.trim().toLowerCase(), pass!);
      if(error == null){
        FireStoreServcies fireStoreServcies = FireStoreServcies();
        User? user = await fireStoreServcies.getUserData();
        if(user != null){
          // save in cache
          await Cache.setEmail(user.email!);
          await Cache.setName(user.name!);
          await Cache.setPhone(user.phone!);

          emit(SuccessLoginState());
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      }
      else{
        emit(FailLoginState());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
        
      }
    }
  }

  void changeHidden(){
    hidden = !hidden;
    emit(HiddenChangedLoginState());
  }

}