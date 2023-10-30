import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision_2/controllers/signup/signup_cubit.dart';
import 'package:revision_2/controllers/signup/signup_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: SignupCubit.get(context).formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onSaved: (value){
                     SignupCubit.get(context).user.name = value;
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'enter your name';
                      }
                      else return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name'
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    onSaved: (value){
                     SignupCubit.get(context).user.email = value;
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'enter your email';
                      }
                      else if(!value.contains('@') && !value.contains('.com')){
                        return 'invaled email';
                      }
                      else return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email'
                    ),
                  ),
                  SizedBox(height: 15,),
                  BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state){
                      return TextFormField(
                        onSaved: (value){
                          SignupCubit.get(context).user.password = value;
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return 'enter your password';
                          }
                          else if(value.length < 8){
                            return 'weak password';
                          }
                          else return null;
                        },
                        obscureText: SignupCubit.get(context).hidden,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: (){
                              SignupCubit.get(context).changeHidden();
                            },
                            icon: Icon(
                              SignupCubit.get(context).hidden? Icons.visibility_off : Icons.visibility
                            ),
                          )
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    onSaved: (value){
                     SignupCubit.get(context).user.phone = value;
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'enter your phone';
                      }
                      else return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone'
                    ),
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    width: screenSize.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: (){
                        SignupCubit.get(context).onSignup(context);
                      }, 
                      child: BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state){
                          if(state is LoadingSignupState){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(color: Colors.white,),
                            );
                          }
                          else{
                            return Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}