import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:journey_recorded/dashboard/dashboard.dart';
// import 'package:journey_recorded/login/login.dart';
// import 'package:journey_recorded/registration/registration.dart';
import 'package:journey_recorded/splash/splash_screen.dart';
// import 'package:triple_r_custom/classes/continue_as_a/continue_as_a.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

import 'package:flutter_stripe/flutter_stripe.dart';

RemoteMessage? initialMessage;
FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = '';

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // show notification alert ( banner )
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('User granted permission =====> ${settings.authorizationStatus}');
  }
  //
  //
  final token = await _firebaseMessaging.getToken();

  //
  //
  if (kDebugMode) {
    print('=============> HERE IS MY DEVICE TOKEN <=============');
    print('======================================================');
    print(token);
    print('======================================================');
    print('======================================================');
  }
  // save token locally
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('deviceToken', token.toString());
  //

  // background access
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // foreground access
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // notification data print here
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      // if (kDebugMode) {
      if (kDebugMode) {
        print("notification 2 ====> ${message.notification!.body}");
      }

      if (kDebugMode) {
        print('Handling a foreground message ${message.messageId}');
      }

      // push to audio
      if (message.notification!.body == 'Incoming audio call') {
      } else {}

      if (kDebugMode) {
        print('Notification Message: ${message.data}');
      }

      if (message.notification != null) {
        if (kDebugMode) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
      }

      //
      //.. rest of your code
      // NotificationService.showNotification(message);

      // }
    },
    onDone: () {
      if (kDebugMode) {
        print('am i done');
      }
    },
  );
  //

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('=====> GOT NOTIFICATION IN FOREGROUND <=====');
    }
    if (kDebugMode) {
      print('Message data: ${message.data}');
    }
    if (message.notification != null) {
      if (kDebugMode) {
        print('Message also contained a notification: ${message.notification}');
      }
      // setState(() {
      // notifTitle = message.notification!.title;
      // notifBody = message.notification!.body;
      // });
    }
  });

  //
  //

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}
