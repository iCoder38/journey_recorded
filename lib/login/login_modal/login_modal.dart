// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_Status {
  final String success_alert;
  final String message;
  // final String ;

  const Login_Status({required this.success_alert, required this.message});

  factory Login_Status.fromJson(Map<String, dynamic> json) {
    return Login_Status(
      success_alert: json['status'],
      message: json['msg'],
    );
  }
}

class LoginModal {
  Future<Login_Status> login_WB(
    String email,
    String password,
  ) async {
    //
    print('Username =====> $email');
    print('Username =====> $password');

    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    final response = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'login',
          'username': email.toString(),
          'password': password.toString(),
        },
      ),
    );
    // print();

    if (response.statusCode == 201) {
      print('=========> 201');
      print(response.body);

      return Login_Status.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 200) {
      print('==========> 200');
      print(response.body);

      Map<String, dynamic> success_status = jsonDecode(response.body);

      var success_text = success_status['status'].toString().toLowerCase();

      // after SUCCESS
      if (success_text == "success") {
        print('=========> USER SUCCESSFULLY REGISTERED <===========');

        // save login data locally
        Map<String, dynamic> get_data = jsonDecode(response.body);
        Map<String, dynamic> user = get_data['data'];
        await prefs.setInt('userId', user['userId']);
        await prefs.setString('fullName', user['fullName']);
        await prefs.setString('email', user['email']);
        await prefs.setString('username', user['username']);
        await prefs.setString('contactNumber', user['contactNumber']);

        await prefs.setString('role', user['role']);
        await prefs.setString('businessName', user['businessName']);
        await prefs.setString('businessEmail', user['businessEmail']);
        await prefs.setString('businessWebSite', user['businessWebSite']);
        await prefs.setString('businessAddress', user['businessAddress']);
        await prefs.setString('businessFax', user['businessFax']);
        await prefs.setString('businessPhone', user['businessPhone']);
        await prefs.setString('career', user['career']);
        await prefs.setString('favroite_quote', user['favroite_quote']);
        await prefs.setString('image', user['image']);
        await prefs.setInt('totalPoints', user['totalPoints']);
        await prefs.setInt('skill_Lavel', user['skill_Lavel']);
        await prefs.setString('image', user['image']);

        return Login_Status(
            success_alert: get_data['status'], message: get_data['msg']);
      } else {
        print('========> SUCCESS WORD FROM SERVER IS WRONG <=========');
        return Login_Status(
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
