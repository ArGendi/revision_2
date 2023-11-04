import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:revision_2/main.dart';
import 'package:revision_2/screens/home_screen.dart';

class FirebaseNotification{

  static void init() async{
    FirebaseMessaging.instance.requestPermission();
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    await pushNotification();
  }

  static void handleMessage(RemoteMessage? message){
    if(message != null){
      navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  static Future<void> pushNotification() async{
    RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
    handleMessage(remoteMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((event) { 
      handleMessage(event);
    });
  }
}