// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journey_recorded/Utils.dart';
// import 'package:journey_recorded/sub_goals/sub_goals_details/sub_goals_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Add_Goal_Status {
  final String success_alert;
  final String message;
  // final String ;

  const Add_Goal_Status({required this.success_alert, required this.message});

  factory Add_Goal_Status.fromJson(Map<String, dynamic> json) {
    return Add_Goal_Status(
      success_alert: json['status'],
      message: json['msg'],
    );
  }
}

class CreateGoalModals {
  Future<Add_Goal_Status> create_goal_WB(
    String goal_type,
    String name,
    String category_id,
    // String notes,
    String dead_line,
    // String mission,
    String about_goal,
    // String sub_goal,
  ) async {
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'addgoal',
          'userId': prefs.getInt('userId').toString(),
          'goalType': '1', //goal_type.toString(),
          'name': name.toString(),
          'categoryId': category_id.toString(),
          // 'note': notes.toString(),
          'deadline': dead_line.toString(),
          // 'mission': mission.toString(),
          'aboutGoal': about_goal.toString(),
          // 'subGoalName': sub_goal.toString(),
        },
      ),
    );
    // print();

    if (response.statusCode == 201) {
      print('=========> 201');
      print(response.body);

      return Add_Goal_Status.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 200) {
      print('==========> 200');
      print(response.body);

      // convert response to json
      Map<String, dynamic> success_status = jsonDecode(response.body);

      var success_text = success_status['status'].toString().toLowerCase();

      // after SUCCESS
      if (success_text == "success") {
        print('=========> ADD GOAL SUCCESSFULLY <===========');

        Map<String, dynamic> get_data = jsonDecode(response.body);

        return Add_Goal_Status(
          success_alert: get_data['status'],
          message: get_data['msg'],
        );
      } else {
        print('========> SUCCESS WORD FROM SERVER IS WRONG <=========');
        return Add_Goal_Status(
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
