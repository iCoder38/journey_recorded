// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/language_translate_texts/language_translate_text.dart';
import 'package:journey_recorded/inventory/edit_inventory/edit_inventory.dart';
import 'package:journey_recorded/request/request_accept_Decline/request_accept_decline.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:journey_recorded/task_details/task_details.dart';

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
  var strCategoryId = '';
  var strCategoryName = '';
  var strFilterName = '';
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
        title: text_bold_style_custom(
          'Assigned Tasks',
          Colors.white,
          16.0,
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
            //
            Container(
              color: navigation_color,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          //
                          openCategoryListSheet(context);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Center(
                            child: (strCategoryName == '')
                                ? text_bold_style_custom(
                                    'Category',
                                    Colors.black,
                                    14.0,
                                  )
                                : text_bold_style_custom(
                                    'Category ( $strCategoryName )',
                                    Colors.black,
                                    14.0,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    //
                    const SizedBox(
                      width: 20.0,
                    ),
                    //
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          //
                          openFilterSheet(context);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Center(
                            child: (strFilterName == '')
                                ? text_bold_style_custom(
                                    'Filter',
                                    Colors.black,
                                    14.0,
                                  )
                                : text_bold_style_custom(
                                    'Filter ( $strFilterName )',
                                    Colors.black,
                                    14.0,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ),
            //
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
                    if (arr_request_list[i]['status'].toString() == '1') {
                      //
                      add_quotes_push_via_future(
                        context,
                        arr_request_list[i]['inviteId'].toString(),
                        arr_request_list[i]['taskName'].toString(),
                        arr_request_list[i]['deadline'].toString(),
                        arr_request_list[i]['description'].toString(),
                        arr_request_list[i]['From_userName'].toString(),
                        arr_request_list[i]['To_userName'].toString(),
                      );
                      //
                    } else if (arr_request_list[i]['status'].toString() ==
                        '3') {
                      var snackdemo = SnackBar(
                        content: text_regular_style_custom(
                          //
                          task_is_already_accepted_EN,
                          Colors.white,
                          14.0,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                    } else {
                      if (kDebugMode) {
                        print('===============');
                        print('Open Task Panel');
                        print('===============');
                        print(arr_request_list[i]);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailsScreen(
                            str_task_name:
                                arr_request_list[i]['taskName'].toString(),
                            str_experince: arr_request_list[i]
                                    ['experiencePoint']
                                .toString(),
                            str_deduct_experince: arr_request_list[i]
                                    ['experiencePointDeduct']
                                .toString(),
                            str_price:
                                arr_request_list[i]['rewardType'].toString(),
                            str_professional_id:
                                arr_request_list[i]['profesionalId'].toString(),
                            str_reminder_warning: arr_request_list[i]
                                    ['reminderWarning']
                                .toString(),
                            str_add_reminder:
                                arr_request_list[i]['addreminder'].toString(),
                            str_task_details:
                                arr_request_list[i]['taskName'].toString(),
                            str_due_date:
                                arr_request_list[i]['due_date'].toString(),
                            str_reward_type:
                                arr_request_list[i]['rewardType'].toString(),
                            dictTaskFullDetails: arr_request_list[i],
                            str_profile_access: 'no',
                            //
                          ),
                        ),
                      );
                    }
                  },
                  child: ListTile(
                    title: text_bold_style_custom(
                      //
                      arr_request_list[i]['taskName'].toString(),
                      Colors.black,
                      16.0,
                    ),
                    // 'skills :${arr_request_list[i]['skill'].toString()}',
                    subtitle: text_regular_style_custom(
                      //
                      'skills : ${arr_request_list[i]['skill'].toString()}',
                      Colors.black,
                      14.0,
                    ),
                    trailing: (arr_request_list[i]['due_date']
                                .toString()
                                .substring(0, 4) ==
                            '1970')
                        ? Container(
                            height: 40,
                            width: 120,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  25.0,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    //
                                    'n.a.',
                                    //
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : (func_difference_between_date(arr_request_list[i]
                                        ['due_date']
                                    .toString()) ==
                                'overdue')
                            ? Container(
                                height: 40,
                                width: 120,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      12.0,
                                    ),
                                  ),
                                ),
                                child: Align(
                                  child: Text(
                                    //
                                    //
                                    'overdue',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 40,
                                width: 120,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      12.0,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    child: Text(
                                      //
                                      func_difference_between_date(
                                          arr_request_list[i]['due_date']
                                              .toString()),
                                      //
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
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
    if (kDebugMode) {
      print('=====> POST : REQUEST LIST');
    }
    //
    setState(() {
      str_loader = '0';
    });
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

  //
  // API : REQUEST LIST -
  funcCategoryAndFilterWB() async {
    if (kDebugMode) {
      print('=====> POST : Cat and Filter');
      print('Categoru id ====>$strCategoryId');
      print('filter name ====>$strFilterName');
    }
    setState(() {
      str_loader = '0';
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var resposne;
    //
    if (strCategoryId != '' && strFilterName == '') {
      if (kDebugMode) {
        print('================================================');
        print('CATEGORY IS NOT BLANK BUT FILTER IS BLANK');
        print('=================================================');
      }

      resposne = await http.post(
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
            'categoryId': strCategoryId.toString(),
          },
        ),
      );
    } else if (strCategoryId != '' && strFilterName != '') {
      if (kDebugMode) {
        print('================================================');
        print('CATEGORY and FILTER BOTH ARE NOT BLANK');
        print('=================================================');
      }

      resposne = await http.post(
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
            'categoryId': strCategoryId.toString(),
            'profesionalType': strFilterName.toString(),
          },
        ),
      );
    } else if (strCategoryId == '' && strFilterName != '') {
      if (kDebugMode) {
        print('================================================');
        print('CATEGORY IS BLANK BUT FILTER IS NOT BLANK');
        print('=================================================');
      }

      resposne = await http.post(
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
            // 'categoryId': strCategoryId.toString(),
            'profesionalType': strFilterName.toString(),
          },
        ),
      );
    } else if (strCategoryId == '' && strFilterName == '') {
      if (kDebugMode) {
        print('================================================');
        print('CATEGORY and FILTER BOTH ARE BLANK');
        print('=================================================');
      }

      resposne = await http.post(
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
            // 'categoryId': strCategoryId.toString(),
            // 'profesionalType': strFilterName.toString(),
          },
        ),
      );
    }

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(get_data);
    }

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

  //
  void openCategoryListSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: text_bold_style_custom(
          'Category',
          Colors.black,
          14.0,
        ),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strCategoryId = '1';
              strCategoryName = 'Spritual';
              //
              funcCategoryAndFilterWB();
            },
            child: text_regular_style_custom(
              'Spritual',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strCategoryId = '2';
              strCategoryName = 'Physical'; //
              funcCategoryAndFilterWB();
            },
            child: text_regular_style_custom(
              'Physical',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strCategoryId = '3';
              strCategoryName = 'Mind'; //
              funcCategoryAndFilterWB();
            },
            child: text_regular_style_custom(
              'Mind',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strCategoryId = '4';
              strCategoryName = 'Social'; //
              funcCategoryAndFilterWB();
            },
            child: text_regular_style_custom(
              'Social',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strCategoryId = '5';
              strCategoryName = 'Financial'; //
              funcCategoryAndFilterWB();
            },
            child: text_regular_style_custom(
              'Financial',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strCategoryId = ''; //
              strCategoryName = '';
              //
              funcCategoryAndFilterWB();
              // request_list_WB();
            },
            child: text_regular_style_custom(
              'All Category',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  } //

  void openFilterSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: text_bold_style_custom(
          'Filter',
          Colors.black,
          14.0,
        ),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strFilterName = 'Goal';
              //
              funcCategoryAndFilterWB();
            },
            child: text_regular_style_custom(
              'Goal',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strFilterName = 'Task';
              funcCategoryAndFilterWB();
            },
            child: text_regular_style_custom(
              'Task',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strFilterName = 'Quest';
              funcCategoryAndFilterWB();
            },
            child: text_regular_style_custom(
              'Quest',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strFilterName = 'Mission';
              funcCategoryAndFilterWB();
            },
            child: text_regular_style_custom(
              'Mission',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strFilterName = 'Training';
              funcCategoryAndFilterWB();
            },
            child: text_regular_style_custom(
              'Training',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strFilterName = 'Profile';

              funcCategoryAndFilterWB();
            },
            child: text_regular_style_custom(
              'Profile',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              strFilterName = '';
              //
              funcCategoryAndFilterWB();
              // request_list_WB();
            },
            child: text_regular_style_custom(
              'All',
              Colors.black,
              14.0,
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
  //
}
