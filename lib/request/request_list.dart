// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/inventory/edit_inventory/edit_inventory.dart';
import 'package:journey_recorded/request/request_accept_Decline/request_accept_decline.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  var str_loader = '0';
  //
  var arr_request_list = [];
  //
  @override
  void initState() {
    super.initState();
    request_list_WB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request',
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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            if (str_loader == '0')
              const CustomeLoaderPopUp(
                str_custom_loader: 'please wait...',
                str_status: '0',
              )
            else if (str_loader == '1')
              const CustomeLoaderPopUp(
                str_custom_loader: 'no data found',
                str_status: 'str_status',
              )
            else
              for (int i = 0; i < arr_request_list.length; i++) ...[
                InkWell(
                  onTap: () {
                    add_quotes_push_via_future(
                      context,
                      arr_request_list[i]['inviteId'].toString(),
                      arr_request_list[i]['taskName'].toString(),
                      arr_request_list[i]['deadline'].toString(),
                      arr_request_list[i]['description'].toString(),
                      arr_request_list[i]['From_userName'].toString(),
                      arr_request_list[i]['To_userName'].toString(),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      arr_request_list[i]['taskName'].toString(),
                      //
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                    subtitle: Text(
                      'skills :${arr_request_list[i]['skill'].toString()}',
                    ),
                    trailing: Container(
                      // height: 40,
                      // width: 80,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: (arr_request_list[i]['deadline'].toString() ==
                                '')
                            ? Text(
                                'n.a.',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                func_difference_between_date(
                                  arr_request_list[i]['deadline'].toString(),
                                ),
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    // isThreeLine: true,
                  ),
                ),
                Container(
                  height: 0.5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
              ]
          ],
        ),
      ),
    );
  }

  // API : REQUEST LIST -
  request_list_WB() async {
    print('=====> POST : REQUEST LIST');

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
          'action': 'invitedgoal',
          'userId': prefs.getInt('userId').toString(),
          // 'pageNo': '',
          // 'subGoal': '2'
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_request_list.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          arr_request_list.add(get_data['data'][i]);
        }

        if (arr_request_list.isEmpty) {
          str_loader = '1';
        } else {
          str_loader = '2';
        }

        setState(() {});
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

  func_difference_between_date(String get_date) {
    String regex = '-';
    var full_date =
        get_date.substring(0, 10).replaceAll(RegExp(regex, unicode: true), '');

    var year = full_date.substring(0, 4);
    var month = full_date.substring(4, 6);
    var day = full_date.substring(6, 8);

    var year_to_int = int.parse(year);
    var month_to_int = int.parse(month);
    var day_to_int = int.parse(day);

    final birthday = DateTime(year_to_int, month_to_int, day_to_int);
    // final birthday = DateTime(2021, 12, 10);
    final date2 = DateTime.now();
    final difference = birthday.difference(date2).inDays;
    //
    if (difference.toString().substring(0, 1) == '-') {
      // var str_overdue = difference.toString();
      return 'overdue';
    } else {
      return '$difference days left';
    }
  }

  Future<void> add_quotes_push_via_future(
    BuildContext context,
    String str_get_invite_id,
    String str_get_task_name,
    String str_get_due_date,
    String str_get_description,
    String str_get_from,
    String str_get_to,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RequestAcceptDeclineScreen(
          str_invite_id: str_get_invite_id.toString(),
          str_task_name: str_get_task_name.toString(),
          str_date: str_get_due_date.toString(),
          str_description: str_get_description.toString(),
          str_from_username: str_get_from.toString(),
          str_to_username: str_get_to.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'yes_from_accept_decline_press') {
      arr_request_list.clear();
      request_list_WB();
    }
  }
}
