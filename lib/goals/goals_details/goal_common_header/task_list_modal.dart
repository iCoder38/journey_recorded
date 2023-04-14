// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Goal_Tasks_Status {
  final String success_alert;
  final String message;
  // final String ;

  const Goal_Tasks_Status({required this.success_alert, required this.message});

  factory Goal_Tasks_Status.fromJson(Map<String, dynamic> json) {
    return Goal_Tasks_Status(
      success_alert: json['status'],
      message: json['msg'],
    );
  }
}

class GoalTaskModal {
  Future<Goal_Tasks_Status> task_list_WB(
    String professional_id,
    String professional_type,
  ) async {
    //

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
          'action': 'tasklist',
          'userId': prefs.getInt('userId').toString(),
          'profesionalId': professional_id.toString(),
          'profesionalType': professional_type.toString(),
          'pageNo': ''
        },
      ),
    );
    // print();

    if (response.statusCode == 201) {
      print('=========> 201');
      print(response.body);

      return Goal_Tasks_Status.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 200) {
      print('==========> 200');
      // print(response.body);

      Map<String, dynamic> success_status = jsonDecode(response.body);

      var success_text = success_status['status'].toString().toLowerCase();

      // after SUCCESS
      if (success_text == "success") {
        print('=========> LIST OF ALL TASKS <===========');

        // save login data locally
        Map<String, dynamic> get_data = jsonDecode(response.body);
        print(get_data);
        Map<String, dynamic> user = get_data['data'];
        print(user);

        /*await prefs.setInt('userId', user['userId']);
        await prefs.setString('fullName', user['fullName']);
        await prefs.setString('email', user['email']);
        await prefs.setString('username', user['username']);
        await prefs.setString('contactNumber', user['contactNumber']);*/

        return Goal_Tasks_Status(
            success_alert: get_data['status'], message: get_data['msg']);
      } else {
        print('========> SUCCESS WORD FROM SERVER IS WRONG <=========');
        return Goal_Tasks_Status(
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

/*
class Goal_Tasks_List_Status {
  final String success_alert;
  final String message;
  // final String ;

  const Goal_Tasks_List_Status(
      {required this.success_alert, required this.message});

  factory Goal_Tasks_List_Status.fromJson(Map<String, dynamic> json) {
    return Goal_Tasks_List_Status(
      success_alert: json['status'],
      message: json['msg'],
    );
  }
}

class GoalListModal {
  Future<Goal_Tasks_List_Status> asas(
    String professional_id,
    String professional_type,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getInt('userId').toString());
    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'tasklist',
          'userId': prefs.getInt('userId').toString(),
          'profesionalId': professional_id.toString(),
          'profesionalType': professional_type.toString(),
          'pageNo': ''
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        // arr_task_list.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          // arr_task_list.add(get_data['data'][i]);
        }

        /*if (arr_task_list.isEmpty) {
          str_task_in_team = '4';
        } else {
          str_task_in_team = '1';
        }

        setState(() {});*/
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
      print('something went wrong');
    }
  }
}

// get_task_list_WB(
//     String str_professional_id, String str_professional_type) async {
//   print('=====> POST : TASK LIST');

  
// }
*/