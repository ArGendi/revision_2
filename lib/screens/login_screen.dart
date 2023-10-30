import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision_2/controllers/login/login_cubit.dart';
import 'package:revision_2/controllers/login/login_state.dart';
import 'package:revision_2/screens/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: LoginCubit.get(context).formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    onSaved: (value){
                      LoginCubit.get(context).email = value;
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
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state){
                      return TextFormField(
                        onSaved: (value){
                          LoginCubit.get(context).pass = value;
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
                        obscureText: LoginCubit.get(context).hidden,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: (){
                              LoginCubit.get(context).changeHidden();
                            },
                            icon: Icon(
                              LoginCubit.get(context).hidden? Icons.visibility_off : Icons.visibility
                            ),
                          )
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    width: screenSize.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: (){
                        LoginCubit.get(context).onLogin(context);
                      }, 
                      child: BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state){
                          if(state is LoadingLoginState){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(color: Colors.white,),
                            );
                          }
                          else{
                            return Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                        }, 
                        child: Text('Sign up now'),
                      ),
                    ],
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