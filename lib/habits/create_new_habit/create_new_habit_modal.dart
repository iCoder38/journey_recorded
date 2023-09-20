// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class create_new_habits_status {
  final String success_alert;
  final String message;
  // final String ;

  const create_new_habits_status(
      {required this.success_alert, required this.message});

  factory create_new_habits_status.fromJson(Map<String, dynamic> json) {
    return create_new_habits_status(
      success_alert: json['status'],
      message: json['msg'],
    );
  }
}

class CreateHabitsModals {
  Future<create_new_habits_status> create_new_habits_WB(
    String habit_id,
    String priority,
    String name,
    String category_id,
    String reminder_date,
    String reminder_time,
    String start,
    String trigger,
    String why,
    String danger,
    String pro,
    String specific,
    String time_to_complete,
    String trainingId,
    String skillClass,
  ) async {
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var reminder_alarm = '$reminder_date $reminder_time';

    if (habit_id == '') {
      final response = await http.post(
        Uri.parse(
          application_base_url,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'action': 'addhabit',
            'userId': prefs.getInt('userId').toString(),
            'priority': '1', //priority,
            'name': name,
            'categoryId': category_id,
            'reminderAlarm': reminder_alarm.toString(),
            'startPercentage': start,
            'tiggerPoint': trigger,
            'why': why,
            'danger': danger,
            'pro': pro.toString(),
            'specificDetails': specific.toString(),
            'time_to_complete': time_to_complete.toString(),
            'trainingId': trainingId.toString(),
            'SkillClass': skillClass.toString(),
          },
        ),
      );
      // print();

      if (response.statusCode == 201) {
        print('=========> 201');
        print(response.body);

        return create_new_habits_status.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 200) {
        print('==========> 200');
        print(response.body);

        // convert response to json
        Map<String, dynamic> success_status = jsonDecode(response.body);

        var success_text = success_status['status'].toString().toLowerCase();

        // after SUCCESS
        if (success_text == "success") {
          print('=========> ADD HABITS SUCCESSFULLY <===========');

          Map<String, dynamic> get_data = jsonDecode(response.body);

          return create_new_habits_status(
            success_alert: get_data['status'],
            message: get_data['msg'],
          );
        } else {
          print('========> SUCCESS WORD FROM SERVER IS WRONG <=========');
          return create_new_habits_status(
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
    } else {
      // edit
      final response = await http.post(
        Uri.parse(
          application_base_url,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'action': 'addhabit',
            'userId': prefs.getInt('userId').toString(),
            'habitId': habit_id.toString(),
            'priority': '1', //priority.toString(),
            'name': name.toString(),
            'categoryId': category_id.toString(),
            'reminderAlarm': reminder_alarm.toString(),
            'startPercentage': start.toString(),
            'tiggerPoint': trigger.toString(),
            'why': why.toString(),
            'danger': danger.toString(),
            'pro': pro.toString(),
            'specificDetails': specific.toString(),
          },
        ),
      );
      // print();

      if (response.statusCode == 201) {
        print('=========> 201');
        print(response.body);

        return create_new_habits_status.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 200) {
        print('==========> 200');
        print(response.body);

        // convert response to json
        Map<String, dynamic> success_status = jsonDecode(response.body);

        var success_text = success_status['status'].toString().toLowerCase();

        // after SUCCESS
        if (success_text == "success") {
          print('=========> ADD HABITS SUCCESSFULLY <===========');

          Map<String, dynamic> get_data = jsonDecode(response.body);

          return create_new_habits_status(
            success_alert: get_data['status'],
            message: get_data['msg'],
          );
        } else {
          print('========> SUCCESS WORD FROM SERVER IS WRONG <=========');
          return create_new_habits_status(
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
}
