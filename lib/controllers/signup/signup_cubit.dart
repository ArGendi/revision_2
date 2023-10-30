import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision_2/controllers/signup/signup_state.dart';
import 'package:revision_2/local/shared_prference.dart';
import 'package:revision_2/models/user.dart';
import 'package:revision_2/screens/home_screen.dart';
import 'package:revision_2/services/firebase_auth.dart';
import 'package:revision_2/services/firestore_services.dart';

class SignupCubit extends Cubit<SignupState>{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user = User();
  bool hidden = true;

  SignupCubit() : super(InitSignupState());

  static SignupCubit get(context) => BlocProvider.of(context);

  void onSignup(BuildContext context) async{
    bool valid = formKey.currentState!.validate();
    if(valid){
      formKey.currentState!.save();
      emit(LoadingSignupState());
      MyFirebaseAuth myFirebaseAuth = MyFirebaseAuth();
      String? error = await myFirebaseAuth.signUp(user.email!, user.password!);
      if(error == null){
        FireStoreServcies fireStoreServcies = FireStoreServcies();
        await fireStoreServcies.setUser(user);
        // save in cache
        await Cache.setEmail(user.email!);
        await Cache.setName(user.name!);
        await Cache.setPhone(user.phone!);
        
        emit(SuccessSignupState());
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      }
      else{
         emit(FailSignupState());
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
    emit(HiddenChangedSignupState());
  }

}