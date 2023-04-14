// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/login/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard/dashboard.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

RemoteMessage? initialMessage;
FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //
  Timer? timer;
  //
  String? notifTitle, notifBody;
  //
  @override
  void initState() {
    super.initState();
    func_remember_me();

    ///
    ///
    ///
    ///
    func_get_device_token();
    func_get_full_data_of_notification();
    func_click_on_notification();

    ///
    ///
    ///
    ///
  }

  func_get_device_token() async {
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
  }

  //
  // get notification in foreground
  func_get_full_data_of_notification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('=====> GOT NOTIFICATION IN FOREGROUND <=====');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        setState(() {
          notifTitle = message.notification!.title;
          notifBody = message.notification!.body;
        });
      }
    });
  }
  //

  func_click_on_notification() {
// FirebaseMessaging.configure

    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      if (kDebugMode) {
        print('=====> CLICK NOTIFICATIONs <=====');
        print(remoteMessage.data);
      }

      if (remoteMessage.data['type'].toString() == 'audioCall') {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => AudioCallScreen(
        //       str_start_pick_end_call: 'get_a_call',
        //       str_friend_image: remoteMessage.data['image'].toString(),
        //       str_friend_name: remoteMessage.data['name'].toString(),
        //       str_device_token: '',
        //       str_channel_name: remoteMessage.data['channel'].toString(),
        //       str_get_device_name: remoteMessage.data['device'].toString(),
        //     ),
        //   ),
        // );
      } else if (remoteMessage.data['type'].toString() == 'videoCall') {
        //
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'SPLASH SCREEN',
        ),
      ),
    );
  }

  // REMEMBER ME
  func_remember_me() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // SharedPreferences preferences =
    // await SharedPreferences.getInstance();
    // await prefs.clear();
    if (kDebugMode) {
      print('=====> SAVED VALUES <=======');
    }
    // print(prefs.getInt('userId'));

    if (prefs.getInt('userId').toString() == 'null') {
      // print('value is empty');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      // print('value is empty 2');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    }
  }
}
