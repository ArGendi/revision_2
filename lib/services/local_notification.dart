import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationServices{
  static FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async{
    AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (a,b,c,d){}
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );
    await notificationsPlugin.initialize(initializationSettings);
  }

  static NotificationDetails getNotificationDetails(){
    return NotificationDetails(
      android: AndroidNotificationDetails("channelId", "channelName", importance: Importance.max, priority: Priority.high),
      iOS: DarwinNotificationDetails(),
    );
  }

  static void showNotification(int id, String title, String body){
    notificationsPlugin.show(id, title, body, getNotificationDetails());
  }

  static void showPeriodNotification(int id, String title, String body){
    notificationsPlugin.periodicallyShow(id, title, body, RepeatInterval.everyMinute, getNotificationDetails());
  }

  static Future<void> scheduleNotification() async{
    tz.initializeTimeZones();
    var now = tz.TZDateTime.now(tz.local);
    await notificationsPlugin.zonedSchedule(
    0,
    'scheduled title',
    'scheduled body',
    tz.TZDateTime(tz.local, now.year, now.month, now.day + 1, 14), // appears tommorrow at 2 PM
    const NotificationDetails(
        android: AndroidNotificationDetails(
            'your channel id', 'your channel name',
            channelDescription: 'your channel description')),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  static void cancel(int id){
    notificationsPlugin.cancel(id);
  }

  static void cancelAll(int id){
    notificationsPlugin.cancelAll();
  }


}


void test(){
  DateTime now = DateTime.now();
  now.day + 1;
  now.add(Duration(hours: 2));
}

// tz.TZDateTime(tz.local, now.year, now.month + 1, now.day, now.hour);
// tz.TZDateTime(tz.local, 2023, 11, 4, 10); 3/11/2023
// tz.TZDateTime(tz.local, now.year, 10, 6, 10);