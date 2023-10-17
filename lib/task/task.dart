// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/language_translate_texts/language_translate_text.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:journey_recorded/task/create_task/create_task.dart';
import 'package:journey_recorded/task/task_header_ui.dart';
import 'package:journey_recorded/task_details/task_details.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  //
  var strUserSelectLanguage = 'en';
  final ConvertLanguage languageTextConverter = ConvertLanguage();
  //
  var str_main_loader = '0';
  var arr_task_list = [];

  var str_selected_category_id = '';
  var str_selected_category_name = '';
  var str_selected_action_name = '';
  var arr_get_category_list = [];
  var str_category_loader = '0';
  // pagenumber
  var pageNumber = 1;

  @override
  void initState() {
    super.initState();

    //
    funcSelectLanguage();
    //
    get_category_list_WB();
  }

// /********** LANGUAGE SELECTED **********************************************/
  funcSelectLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strUserSelectLanguage = prefs.getString('language').toString();
    if (kDebugMode) {
      print('user already selected ====> $strUserSelectLanguage');
    }
    setState(() {});
  }
// /********** LANGUAGE SELECTED **********************************************/

  get_category_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : GET CATEGORY 2');
    }

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'category',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //

        for (var i = 0; i < get_data['data'].length; i++) {
          arr_get_category_list.add(get_data['data'][i]);
        }
        // setState(() {});
        str_category_loader = '1';
        funcAllTasksListWB();
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  funcAllTasksListWB() async {
    if (kDebugMode) {
      print('=====> POST : TASKS LIST => ALL');
    }

    if (pageNumber == 1) {
      setState(() {
        str_main_loader = 'tasks_loader_start';
      });
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'action': 'tasklist',
          'userId': prefs.getInt('userId').toString(),
          'complete': '0,1,2',
          'pageNo': pageNumber,
          // 'profesionalType': str_selected_action_name,
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
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          //
          arr_task_list.add(get_data['data'][i]);
        }
        //
        if (arr_task_list.isEmpty) {
          str_main_loader = 'tasks_data_empty';
        } else {
          str_main_loader = 'tasks_loader_stop';
        }

        setState(() {});
        // pageNumber = 2;
        // func_get_task_list_page_two_WB();
        //
      } else {
        if (kDebugMode) {
          print(
            '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
          );
        }
      }
    } else {
      // return postList;
      if (kDebugMode) {
        print('something went wrong');
      }
    }
  }

  /*func_get_task_list_page_two_WB() async {
    if (kDebugMode) {
      print('=====> POST : TASKS LIST 2.0');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'action': 'tasklist',
          'userId': prefs.getInt('userId').toString(),
          'complete': '0,1,2',
          'pageNo': pageNumber
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
        //
        // arr_task_list.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_task_list.add(get_data['data'][i]);
        }

        // str_task_count = arr_task_list.length.toString();

        if (arr_task_list.isEmpty) {
          str_main_loader = 'tasks_data_empty';
        } else {
          str_main_loader = 'tasks_loader_stop';
        }

        setState(() {});
      } else {
        if (kDebugMode) {
          print(
            '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
          );
        }
      }
    } else {
      // return postList;
      if (kDebugMode) {
        print('something went wrong');
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          'All Tasks',
          Colors.white,
          16.0,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(
            'sub_goal',
          ),
        ),
        backgroundColor: navigation_color,
      ),
      body: NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification is UserScrollNotification) {
            final metrics = notification.metrics;
            if (metrics.atEdge) {
              bool isTop = metrics.pixels == 0;
              if (isTop) {
                if (kDebugMode) {
                  print('At the top new');
                  // print(metrics.pixels);
                }
                //
                // strScrollOnlyOneTime = '0';
              } else if (notification.direction == ScrollDirection.forward) {
                //
                if (kDebugMode) {
                  print('scroll down');
                }
                //
              } else if (notification.direction == ScrollDirection.reverse) {
                // Handle scroll up.
                if (kDebugMode) {
                  print('scroll up');
                }
              } else {
                //

                if (kDebugMode) {
                  print('Bottom');
                  print(str_selected_category_name);
                  print(str_selected_action_name);
                  // print(metrics.pixels);
                }
                //
                pageNumber += 1;
                if (kDebugMode) {
                  print(pageNumber);
                }
                //
                //
                if (str_selected_category_name == 'SPIRITUAL') {
                  func_get_category_list_WB();
                } else if (str_selected_category_name == 'PHYSICAL') {
                  func_get_category_list_WB();
                } else if (str_selected_category_name == 'MIND') {
                  func_get_category_list_WB();
                } else if (str_selected_category_name == 'SOCIAL') {
                  func_get_category_list_WB();
                } else if (str_selected_category_name == 'FINANCIAL') {
                  func_get_category_list_WB();
                } else if (str_selected_action_name == 'Goal') {
                  func_call_main_api_WB(
                    'Goal',
                  );
                } else if (str_selected_action_name == 'Quest') {
                  func_call_main_api_WB(
                    'Quest',
                  );
                } else if (str_selected_action_name == 'Mission') {
                  func_call_main_api_WB(
                    'Mission',
                  );
                } else if (str_selected_category_name == 'All') {
                  funcAllTasksListWB();
                }

                // if someone's data is greater than 9 then pagination call only
                /*if (arrAllInOneArray.length > 9) {
                  allInOneWB();
                }*/

                //
                // strScrollOnlyOneTime = '1';
              }
            }
          }

          return true;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              // task_in_team_UI(context),
              Column(
            children: [
              //
              task_header_UI(context),
              //
              if (str_main_loader == 'tasks_loader_start')
                if (strUserSelectLanguage == 'en') ...[
                  CustomeLoaderPopUp(
                    str_custom_loader: alert_please_wait_en,
                    str_status: '3',
                  ),
                ] else ...[
                  CustomeLoaderPopUp(
                    str_custom_loader: alert_please_wait_sp,
                    str_status: '3',
                  ),
                ]
              else if (str_main_loader == 'tasks_data_empty')
                const CustomeLoaderPopUp(
                  str_custom_loader: 'Task not Added yet.',
                  str_status: '4',
                )
              else
                for (int i = 0; i < arr_task_list.length; i++) ...[
                  GestureDetector(
                    onTap: () {
                      //
                      func_push_to_task(
                          context,
                          arr_task_list[i]['name'].toString(),
                          arr_task_list[i]['experiencePoint'].toString(),
                          arr_task_list[i]['experiencePointDeduct'].toString(),
                          '\$',
                          arr_task_list[i]['taskId'].toString(),
                          arr_task_list[i]['reminderWarning'].toString(),
                          arr_task_list[i]['addreminder'].toString(),
                          arr_task_list[i]['description'].toString(),
                          arr_task_list[i]['due_date'].toString(),
                          arr_task_list[i]['rewardType'].toString(),
                          arr_task_list[i]);
                    },
                    child: ListTile(
                      title: text_bold_style_custom(
                        //
                        // 'qwerty qwert qwer qwe qw q qrweq qrw qeq qw q',
                        arr_task_list[i]['name'].toString(),
                        Colors.black,
                        14.0,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (func_difference_between_date(
                                arr_task_list[i]['due_date'].toString(),
                              ) ==
                              'overdue') ...[
                            Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ),
                              ),
                              child: Center(
                                child: text_bold_style_custom(
                                  'overdue',
                                  Colors.black,
                                  14.0,
                                ),
                              ),
                            )
                          ] else ...[
                            if (func_difference_between_date(
                                      arr_task_list[i]['due_date'].toString(),
                                    ) ==
                                    '2 days left' ||
                                func_difference_between_date(
                                      arr_task_list[i]['due_date'].toString(),
                                    ) ==
                                    '3 days left' ||
                                func_difference_between_date(
                                      arr_task_list[i]['due_date'].toString(),
                                    ) ==
                                    '4 days left' ||
                                func_difference_between_date(
                                      arr_task_list[i]['due_date'].toString(),
                                    ) ==
                                    '5 days left' ||
                                func_difference_between_date(
                                      arr_task_list[i]['due_date'].toString(),
                                    ) ==
                                    '6 days left' ||
                                func_difference_between_date(
                                      arr_task_list[i]['due_date'].toString(),
                                    ) ==
                                    '7 days left' ||
                                func_difference_between_date(
                                      arr_task_list[i]['due_date'].toString(),
                                    ) ==
                                    '8 days left' ||
                                func_difference_between_date(
                                      arr_task_list[i]['due_date'].toString(),
                                    ) ==
                                    '9 days left') ...[
                              Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green[400],
                                  borderRadius: BorderRadius.circular(
                                    12.0,
                                  ),
                                ),
                                child: Center(
                                  child: text_bold_style_custom(
                                    func_difference_between_date(
                                      arr_task_list[i]['due_date'].toString(),
                                    ),
                                    Colors.white,
                                    12.0,
                                  ),
                                ),
                              )
                            ] else ...[
                              Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(
                                    12.0,
                                  ),
                                ),
                                child: Center(
                                  child: text_bold_style_custom(
                                    func_difference_between_date(
                                      arr_task_list[i]['due_date'].toString(),
                                    ),
                                    Colors.black,
                                    12.0,
                                  ),
                                ),
                              ),
                            ]
                          ]
                        ],
                      ),
                      /*Container(
                        child: text_regular_style_custom(
                          func_difference_between_date(
                            arr_task_list[i]['due_date'].toString(),
                          ),
                          Colors.black,
                          14.0,
                        ),
                      ),*/
                    ),
                  ),
                  /*
                  ListTile(title: text_regular_style_custom(arr_task_list[i]['name'].toString(), Colors.black, 14.0,),)
                  InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print('fd 2');
                      }
      
                      func_push_to_task(
                        context,
                        arr_task_list[i]['name'].toString(),
                        arr_task_list[i]['experiencePoint'].toString(),
                        arr_task_list[i]['experiencePointDeduct'].toString(),
                        '\$',
                        arr_task_list[i]['taskId'].toString(),
                        arr_task_list[i]['reminderWarning'].toString(),
                        arr_task_list[i]['addreminder'].toString(),
                        arr_task_list[i]['description'].toString(),
                        arr_task_list[i]['due_date'].toString(),
                      );
                    },
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              if (kDebugMode) {
                                print('object');
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 10.0,
                              ),
                              child: Expanded(
                                child: Text(
                                  //
                                  arr_task_list[i]['name'].toString(),
                                  //
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              right: 10.0,
                            ),
                            height: 50,
                            // width: 200,
                            color: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(
                                      14.0,
                                    ),
                                  ),
                                  child: Align(
                                    child: Text(
                                      func_difference_between_date(
                                        arr_task_list[i]['due_date'].toString(),
                                      ),
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  )
                ],
            ],
          ),
        ),
      ),
    );
  }

  // tasks list
  Column task_in_team_UI(BuildContext context) {
    return Column(
      children: [
        //
        task_header_UI(context),
        //
        if (str_main_loader == 'tasks_loader_start')
          const CustomeLoaderPopUp(
            str_custom_loader: 'please wait...',
            str_status: '3',
          )
        else if (str_main_loader == 'tasks_data_empty')
          const CustomeLoaderPopUp(
            str_custom_loader: 'Task not Added yet.',
            str_status: '4',
          )
        else
          for (int i = 0; i < arr_task_list.length; i++) ...[
            InkWell(
              onTap: () {
                if (kDebugMode) {
                  print('fd 2');
                }

                func_push_to_task(
                    context,
                    arr_task_list[i]['name'].toString(),
                    arr_task_list[i]['experiencePoint'].toString(),
                    arr_task_list[i]['experiencePointDeduct'].toString(),
                    '\$',
                    arr_task_list[i]['taskId'].toString(),
                    arr_task_list[i]['reminderWarning'].toString(),
                    arr_task_list[i]['addreminder'].toString(),
                    arr_task_list[i]['description'].toString(),
                    arr_task_list[i]['due_date'].toString(),
                    arr_task_list[i]['rewardType'].toString(),
                    arr_task_list[i]);
              },
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        if (kDebugMode) {
                          print('object');
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: Expanded(
                          child: Text(
                            //
                            arr_task_list[i]['name'].toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 10.0,
                      ),
                      height: 50,
                      // width: 200,
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(
                                14.0,
                              ),
                            ),
                            child: Align(
                              child: Text(
                                func_difference_between_date(
                                  arr_task_list[i]['due_date'].toString(),
                                ),
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          /*ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(
                                  235,
                                  0,
                                  65,
                                  1,
                                ),
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(0)),
                            child: const Icon(
                              Icons.edit,
                              size: 18,
                            ),
                            onPressed: () {
                              //
                              // print('object 2');
                              //
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(0)),
                            child: const Icon(
                              Icons.close,
                              size: 18,
                            ),
                            onPressed: () {
                              _showMyDialog(
                                'Are you sure your want to delete ${arr_task_list[i]['name']} ?',
                                arr_task_list[i]['taskId'].toString(),
                              );
                            },
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            )
          ],
      ],
    );
  }

  Container task_header_UI(BuildContext context) {
    return Container(
      height: 260,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(
            0.0,
          ),
        ),
        image: DecorationImage(
          image: AssetImage(
            // image name
            'assets/images/task_bg.png',
          ),
          fit: BoxFit.cover,
          //opacity: .4,
        ),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            // color: Colors.green,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(
                    54,
                    30,
                    107,
                    1,
                  ),
                  Color.fromRGBO(
                    92,
                    21,
                    93,
                    1,
                  ),
                  Color.fromRGBO(
                    138,
                    0,
                    70,
                    1,
                  ),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      pageNumber = 1;
                      arr_task_list.clear();
                      //
                      str_selected_category_name = 'All';
                      str_selected_action_name = '';
                      funcAllTasksListWB();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                      ),
                      height: 50,
                      width: 90,
                      decoration: BoxDecoration(
                        // color: Colors.amber,
                        borderRadius: BorderRadius.circular(
                          14.0,
                        ),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/btn_round.png'),
                          fit: BoxFit.fill,
                        ),
                        // shape: BoxShape.circle,
                      ),
                      child: Align(
                        child: text_regular_style_custom(
                          //
                          languageTextConverter.funcConvertLanguage(
                            'all_tasks_all',
                            strUserSelectLanguage,
                          ),
                          Colors.black,
                          14.0,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      open_category_list(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 0.0,
                      ),
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/btn_round.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(
                          14.0,
                        ),
                      ),
                      child: Align(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            child: text_regular_style_custom(
                              //
                              languageTextConverter.funcConvertLanguage(
                                'all_tasks_category',
                                strUserSelectLanguage,
                              ),
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      open_action_list(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 0.0,
                      ),
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/btn_round.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(
                          14.0,
                        ),
                      ),
                      child: Align(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            child: text_regular_style_custom(
                              //
                              languageTextConverter.funcConvertLanguage(
                                'all_tasks_actions',
                                strUserSelectLanguage,
                              ),
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 0.0,
                    ),
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/btn_round.png'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(
                        14.0,
                      ),
                    ),
                    child: Align(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: text_regular_style_custom(
                          //
                          languageTextConverter.funcConvertLanguage(
                            'all_tasks_filters',
                            strUserSelectLanguage,
                          ),
                          Colors.black,
                          14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: text_bold_style_custom(
                str_selected_category_name,
                Colors.orange,
                16.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: text_bold_style_custom(
                str_selected_action_name,
                Colors.orange,
                16.0,
              ),
            ),
          ),
          Container(
            height: 40,
            width: 140,
            decoration: BoxDecoration(
              // color: const Color.fromRGBO(
              //   250,
              //   180,
              //   12,
              //   1,
              // ),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(
                14.0,
              ),
            ),
            child: Align(
              child: Text(
                //
                // func_difference_between_date(
                //   widget.str_due_date.toString(),
                // ),
                '14',
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // how many days left
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

  Future<void> func_push_to_task(
      BuildContext context,
      String str_get_task_name,
      String str_get_experince,
      String str_get_deduct_experince,
      String str_get_price,
      String str_get_professional_id,
      String str_get_reminder_warning,
      String str_get_add_warning,
      String str_get_task_details,
      String str_get_due_date,
      String strRewardType,
      data) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailsScreen(
            str_task_name: str_get_task_name.toString(),
            str_experince: str_get_experince.toString(),
            str_deduct_experince: str_get_deduct_experince.toString(),
            str_price: str_get_price.toString(),
            str_professional_id: str_get_professional_id.toString(),
            str_reminder_warning: str_get_reminder_warning.toString(),
            str_add_reminder: str_get_add_warning.toString(),
            str_task_details: str_get_task_details.toString(),
            str_due_date: str_get_due_date.toString(),
            str_reward_type: strRewardType,
            str_profile_access: 'yes',
            dictTaskFullDetails: data
            //
            ),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

    if (!mounted) return;

    funcAllTasksListWB();
  }

  // open action sheet
  void open_action_list(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Actions',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 16.0,
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              pageNumber = 1;
              Navigator.pop(context);
              str_selected_action_name = 'Goal';
              func_call_main_api_WB(
                'Goal',
              );
            },
            child: Text(
              //
              'Goal',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              pageNumber = 1;
              Navigator.pop(context);
              str_selected_action_name = 'Quest';
              func_call_main_api_WB(
                'Quest',
              );
            },
            child: Text(
              //
              'Quest',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              pageNumber = 1;
              Navigator.pop(context);
              str_selected_action_name = 'Mission';
              func_call_main_api_WB(
                'Mission',
              );
            },
            child: Text(
              //
              'Mission',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
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

  // open action sheet
  void open_category_list(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Categories',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 16.0,
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          //

          //
          for (int i = 0; i < arr_get_category_list.length; i++) ...[
            CupertinoActionSheetAction(
              onPressed: () async {
                pageNumber = 1;
                Navigator.pop(context);

                str_selected_category_name =
                    arr_get_category_list[i]['name'].toString();
                setState(() {});

                str_selected_category_id =
                    arr_get_category_list[i]['id'].toString();

                func_get_category_list_WB();
              },
              child: Text(
                //
                arr_get_category_list[i]['name'].toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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

  func_get_category_list_WB() async {
    print('=====> POST : TASKS LIST');

    if (pageNumber == 1) {
      setState(() {
        str_main_loader = 'tasks_loader_start';
      });
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      /*
      [action] => tasklist
    [userId] => 29
    [categoryId] => 3
    [pageNo] => 1
    */
      body: jsonEncode(
        <String, dynamic>{
          'action': 'tasklist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': pageNumber,
          'categoryId': str_selected_category_id.toString(),
          'completed': '0,1,2',
          'profesionalType': str_selected_action_name,
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        //
        if (pageNumber == 1) {
          arr_task_list.clear();
        }

        //
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_task_list.add(get_data['data'][i]);
        }

        // str_task_count = arr_task_list.length.toString();

        if (arr_task_list.isEmpty) {
          str_main_loader = 'tasks_data_empty';
        } else {
          str_main_loader = 'tasks_loader_stop';
        }

        setState(() {});

        // mission_info_list_WB();

        // get_mission_list_WB();
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

  func_call_main_api_WB(
    String str_get_action_name,
  ) async {
    print('=====> POST : TASK => ACTION => $str_get_action_name');

    print('category id ==> $str_selected_category_id');

    // if (str_selected_category_id == '') {
    //
    //   funcActionWithNoCategoryIdWB(str_get_action_name);
    // } else {
    if (pageNumber == 1) {
      str_main_loader = 'tasks_loader_start';
      setState(() {});
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'action': 'tasklist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': pageNumber,
          'profesionalType': str_get_action_name.toString(),
          'categoryId': str_selected_category_id.toString(),
          'completed': '0,1,2'
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        //

        if (pageNumber == 1) {
          arr_task_list.clear();
        }

        //
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_task_list.add(get_data['data'][i]);
        }

        // str_task_count = arr_task_list.length.toString();

        if (arr_task_list.isEmpty) {
          str_main_loader = 'tasks_data_empty';
        } else {
          str_main_loader = 'tasks_loader_stop';
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
    // }
  }

  funcActionWithNoCategoryIdWB(
    String professinal_type,
  ) async {
    print('=====> POST : TASKS LIST');

    if (pageNumber == 1) {
      str_main_loader = 'tasks_loader_start';
      setState(() {});
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'action': 'tasklist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': pageNumber,
          'profesionalType': professinal_type.toString(),
          'completed': '0,1,2'
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
        //
        if (pageNumber == 1) {
          arr_task_list.clear();
        }

        //
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_task_list.add(get_data['data'][i]);
        }

        // str_task_count = arr_task_list.length.toString();

        if (arr_task_list.isEmpty) {
          str_main_loader = 'tasks_data_empty';
        } else {
          str_main_loader = 'tasks_loader_stop';
        }

        setState(() {});

        // mission_info_list_WB();

        // get_mission_list_WB();
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
