// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Create_Task_Status {
  final String success_alert;
  final String message;
  // final String ;

  const Create_Task_Status(
      {required this.success_alert, required this.message});

  factory Create_Task_Status.fromJson(Map<String, dynamic> json) {
    return Create_Task_Status(
      success_alert: json['status'],
      message: json['msg'],
    );
  }
}

class CreateTaskModal {
  Future<Create_Task_Status> create_task_WB(
    String name,
    String description,
    String due_date,
    String experiencePoint,
    String experiencePointDeduct,
    String Assigment,
    String skill,
    String addreminder,
    String reminderWarning,
    String profesionalId,
    String profesionalType,
    //new
    String reward_type,
    String group_id_main,
    String group_id_sub,
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
          'action': 'addtask',
          'userId': prefs.getInt('userId').toString(),
          'name': name,
          'description': description,
          'due_date': due_date,
          'experiencePoint': experiencePoint,
          'experiencePointDeduct': experiencePointDeduct,
          'Assigment': Assigment,
          'skill': skill,
          'addreminder': 'saddreminder',
          'reminderWarning': reminderWarning,
          'profesionalId': profesionalId.toString(),
          'profesionalType': profesionalType,
          // new
          'categoryId': '5',
          'groupId_Main': group_id_main.toString(),
          'groupId_Sub': group_id_sub.toString(),
          'rewardType': reward_type.toString(),
        },
      ),
    );

    if (response.statusCode == 201) {
      if (kDebugMode) {
        print('=========> 201');
        print(response.body);
      }

      return Create_Task_Status.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 200) {
      if (kDebugMode) {
        print('==========> 200');
        print(response.body);
      }

      Map<String, dynamic> success_status = jsonDecode(response.body);

      var success_text = success_status['status'].toString().toLowerCase();

      // after SUCCESS
      if (success_text == "success") {
        print('=========> USER SUCCESSFULLY REGISTERED <===========');

        // save login data locally
        Map<String, dynamic> get_data = jsonDecode(response.body);
        // Map<String, dynamic> user = get_data['data'];

        return Create_Task_Status(
            success_alert: get_data['status'], message: get_data['msg']);
      } else {
        print('========> SUCCESS WORD FROM SERVER IS WRONG <=========');
        return Create_Task_Status(
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
