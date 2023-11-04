import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:revision_2/controllers/login/login_cubit.dart';
import 'package:revision_2/controllers/profile/profile_cubit.dart';
import 'package:revision_2/controllers/signup/signup_cubit.dart';
import 'package:revision_2/firebase_options.dart';
import 'package:revision_2/local/shared_prference.dart';
import 'package:revision_2/screens/login_screen.dart';
import 'package:revision_2/screens/map_screen.dart';
import 'package:revision_2/screens/notification_screen.dart';
import 'package:revision_2/screens/profile_screen.dart';
import 'package:revision_2/services/firebase_messaging.dart';
import 'package:revision_2/services/local_notification.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  await Cache.init();
  LocalNotificationServices.init();
  FirebaseNotification.init();
  Geolocator.requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignupCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MapScreen(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}