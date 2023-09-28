// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class RequestAcceptDeclineScreen extends StatefulWidget {
  const RequestAcceptDeclineScreen(
      {super.key,
      required this.str_task_name,
      required this.str_description,
      required this.str_date,
      required this.str_invite_id,
      required this.str_from_username,
      required this.str_to_username});

  final String str_from_username;
  final String str_to_username;
  final String str_task_name;
  final String str_description;
  final String str_date;
  final String str_invite_id;

  @override
  State<RequestAcceptDeclineScreen> createState() =>
      _RequestAcceptDeclineScreenState();
}

class _RequestAcceptDeclineScreenState
    extends State<RequestAcceptDeclineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.str_task_name.toString(),
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
        backgroundColor: navigation_color,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  //
                  'Due Date : ${widget.str_date}',
                  //
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  //
                  'Hello ${widget.str_to_username} you have been invited by ${widget.str_from_username} to join him in his goalto Start an ${widget.str_task_name}. \n\nWill you agree to have a meeting with him and discuss the details of the request and compensation.\n\nCan you please respond within 5 business days, because this invitation has gone to a few qualified people. \n\nThanks.',
                  //
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 20.0,
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(
                        32,
                        232,
                        106,
                        1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        gear_mission_popup(
                          'Accept',
                          'Are you sure you want to ACCEPT this task ?',
                          '2',
                        );
                      },
                      child: Center(
                        child: Text(
                          'Accept',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      gear_mission_popup(
                        'Decline',
                        'Are you sure you want to DECLINE this task ?',
                        '3',
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20.0),
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                          250,
                          0,
                          30,
                          1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Decline',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //

  // ALERT
  Future<void> gear_mission_popup(
    String str_title,
    String goal_id_is,
    String str_status,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            str_title.toString(),
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    print('edit');
                    Navigator.pop(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.add,
                            size: 0.0,
                          ),
                        ),
                        TextSpan(
                          text: goal_id_is,
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            if (str_status == '2') ...[
              //accept
              TextButton(
                child: const Text('Dismiss'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Accept',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  func_accept_or_decline_WB(
                    '2',
                  );
                },
              )
            ] else if (str_status == '3') ...[
              // decline
              TextButton(
                child: const Text('Dismiss'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Decline',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  func_accept_or_decline_WB(
                    '3',
                  );
                },
              )
            ]
          ],
        );
      },
    );
  }

  /*

action: inviteaccept
inviteId:
userId:
status:  //2= accept 3=decline
  */
  func_accept_or_decline_WB(
    String get_status,
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
          'action': 'inviteaccept',
          'userId': prefs.getInt('userId').toString(),
          'inviteId': widget.str_invite_id.toString(),
          'status': get_status.toString()
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(get_data);
    }

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data

        Navigator.pop(context, 'yes_from_accept_decline_press');
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
