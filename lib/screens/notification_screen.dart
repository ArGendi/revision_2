import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:revision_2/services/firebase_messaging.dart';
import 'package:revision_2/services/local_notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                LocalNotificationServices.showPeriodNotification(3, "Drink water", "don't forget to drink 2 liters of water");
              }, 
              child: Text("Show notification"),
            ),
            TextButton(
              onPressed: (){
                LocalNotificationServices.cancel(3);
              }, 
              child: Text("Cancel notification"),
            ),
            TextButton(
              onPressed: (){
                FirebaseNotification.init();
              }, 
              child: Text("get Firebase token"),
            ),
          ],
        ),
      ),
    );
  }
}