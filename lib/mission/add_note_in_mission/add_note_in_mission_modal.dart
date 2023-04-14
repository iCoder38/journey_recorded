// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Add_Note_Mission_Status {
  final String success_alert;
  final String message;
  //final String professional_type;
  // final String ;

  const Add_Note_Mission_Status(
      {required this.success_alert, required this.message});

  factory Add_Note_Mission_Status.fromJson(Map<String, dynamic> json) {
    return Add_Note_Mission_Status(
      success_alert: json['status'],
      message: json['msg'],
    );
  }
}

class AddNoteMissionModal {
  Future<Add_Note_Mission_Status> add_note_WB(
    String message,
    String professional_id,
    String profession_type,
  ) async {
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
          'action': 'addnote',
          'userId': prefs.getInt('userId').toString(),
          'message': message.toString(),
          'profesionalId': professional_id.toString(),
          'profesionalType': profession_type.toString(),
        },
      ),
    );
    // print();

    if (response.statusCode == 201) {
      print('=========> 201');
      print(response.body);

      return Add_Note_Mission_Status.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 200) {
      print('==========> 200');
      print(response.body);

      Map<String, dynamic> success_status = jsonDecode(response.body);

      var success_text = success_status['status'].toString().toLowerCase();

      // after SUCCESS
      if (success_text == "success") {
        print('=========> Notes Add Successfully <===========');

        // save login data locally
        Map<String, dynamic> get_data = jsonDecode(response.body);

        return Add_Note_Mission_Status(
            success_alert: get_data['status'], message: get_data['msg']);
      } else {
        print('========> SUCCESS WORD FROM SERVER IS WRONG <=========');
        return Add_Note_Mission_Status(
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
