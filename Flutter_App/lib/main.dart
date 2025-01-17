import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:iot_app/Layout/layout.dart';
import 'package:iot_app/screen/wellcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iot_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter has initialized.
  await Firebase.initializeApp(); // Initialize Firebase
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'fwTech',
        channelName: 'System Notifications',
        channelDescription: 'Notification channel for system updates',
        defaultColor: Colors.deepPurple,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      )
    ],
  );

  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    print("Requesting permission to send notifications");
    await AwesomeNotifications().requestPermissionToSendNotifications();
  } else {
    print("Notification permission already granted");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          try {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            final prefs = snapshot.data;
            //print(prefs?.getString('userID'));
            final isLoggedIn = prefs?.getString('userID1') ?? "1";
            if (isLoggedIn == "1") {
              return WellcomeScreen();
            } else {
              return Layout();
            }
          } catch (e) {
            return WellcomeScreen();
          }
        });
  }
}
