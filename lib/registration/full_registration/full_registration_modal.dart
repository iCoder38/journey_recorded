// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration_Status {
  final String success_alert;
  final String message;
  // final String ;

  const Registration_Status(
      {required this.success_alert, required this.message});

  factory Registration_Status.fromJson(Map<String, dynamic> json) {
    return Registration_Status(
      success_alert: json['status'],
      message: json['msg'],
    );
  }
}

class RegistrationModal {
  Future<Registration_Status> create_user_WB(
    String full_name,
    String username,
    String email,
    String contact_number,
    String password,
    String role,
  ) async {
    //
    if (kDebugMode) {
      print('full name =====> $full_name');
      print('Username =====> $username');
      print('email =====> $email');
      print('phone =====> $contact_number');
      print('password =====> $password');
      print('role =====> $role');
    }

    //
    final response = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      /*
action:registration
fullName:
username:  //unique
email:  //unique
contactNumber:
password:
role:Member / Business
*/
      body: jsonEncode(
        <String, String>{
          'action': 'registration',
          'fullName': full_name.toString(),
          'username': username,
          'email': email,
          'contactNumber': (Random().nextInt(900000) + 100000).toString(),
          'password': password,
          'role': role,
        },
      ),
    );
    // print();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 201) {
      print('=========> 201');
      print(response.body);

      return Registration_Status.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 200) {
      print('==========> 200');
      print(response.body);

      Map<String, dynamic> success_status = jsonDecode(response.body);
      Map<String, dynamic> user = success_status['data'];
      await prefs.setInt('userId', user['userId']);

      var success_text = success_status['status'].toString().toLowerCase();

      // after SUCCESS
      if (success_text == "success") {
        print('=========> USER SUCCESSFULLY REGISTERED <===========');

        // convert data to dict
        Map<String, dynamic> get_data = jsonDecode(response.body);

        return Registration_Status(
            success_alert: get_data['status'], message: get_data['msg']);
      } else {
        print('========> SUCCESS WORD FROM SERVER IS WRONG <=========');
        return Registration_Status(
          success_alert: success_text,
          message: success_status['msg'].toString(),
        );
      }
      // throw Exception('SOMETHING WENT WRONG. PLEASE CHECK');
    } else {
      print("============> ERROR");
      print(response.body);

      throw Exception('Failed to create album.');
    }
  }
}
