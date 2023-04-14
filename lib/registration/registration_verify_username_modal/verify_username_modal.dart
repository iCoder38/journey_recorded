// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journey_recorded/Utils.dart';

class Verify_Username_Status {
  final String success_alert;
  final String message;
  // final String ;

  const Verify_Username_Status(
      {required this.success_alert, required this.message});

  factory Verify_Username_Status.fromJson(Map<String, dynamic> json) {
    return Verify_Username_Status(
      success_alert: json['status'],
      message: json['msg'],
    );
  }
}

class VerifyUsernameModal {
  Future<Verify_Username_Status> verify_usename_WB(
    String user_name,
  ) async {
    print('Username =====> $user_name');
    final response = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'checkusername',
          'username': user_name,
        },
      ),
    );
    // print();

    if (response.statusCode == 201) {
      print('=========> 201');
      print(response.body);

      return Verify_Username_Status.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 200) {
      print('==========> 200');
      print(response.body);

      Map<String, dynamic> success_status = jsonDecode(response.body);

      var success_text = success_status['status'].toString().toLowerCase();

      // after SUCCESS
      if (success_text == "success") {
        print('=========> USER SUCCESSFULLY REGISTERED <===========');

        // convert data to dict
        Map<String, dynamic> get_data = jsonDecode(response.body);

        return Verify_Username_Status(
            success_alert: get_data['status'], message: get_data['msg']);
      } else {
        print('========> SUCCESS WORD FROM SERVER IS WRONG <=========');
        return Verify_Username_Status(
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
