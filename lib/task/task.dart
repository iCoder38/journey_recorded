// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
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
  var str_main_loader = '0';
  var arr_task_list = [];

  var str_selected_category_id = '';
  var str_selected_category_name = 'All';
  var arr_get_category_list = [];
  var str_category_loader = '0';

  //

  @override
  void initState() {
    super.initState();

    get_category_list_WB();
  }

  get_category_list_WB() async {
    print('=====> POST : GET CATEGORY 2');

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
        func_get_task_list_WB();
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  func_get_task_list_WB() async {
    print('=====> POST : TASKS LIST');

    str_main_loader = 'tasks_loader_start';
    setState(() {});

    SharedPreferences prefs = await SharedPreferences.getInstance();

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
          'pageNo': '1'
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
        arr_task_list.clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Tasks',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 20.0,
          ),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
            // task_in_team_UI(context),
            Column(
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
      height: 200,
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
                      func_get_task_list_WB();
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
                        child: Text(
                          'All',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                          ),
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
                          child: Text(
                            'Category',
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
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
                          child: Text(
                            'Actions',
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
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
                        child: Text(
                          'Filter',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            //
            // widget.str_task_name.toString(),
            '',
            //
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 20.0,
              color: Colors.white,
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
      String str_get_due_date) async {
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

          //
        ),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

// back_from_delete_task

    if (!mounted) return;

    func_get_task_list_WB();
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
              Navigator.pop(context);

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
              Navigator.pop(context);

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
              Navigator.pop(context);
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

    str_main_loader = 'tasks_loader_start';
    setState(() {});

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
        <String, String>{
          'action': 'tasklist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '1',
          'categoryId': str_selected_category_id.toString(),
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
        arr_task_list.clear();
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
    print('=====> POST : TASKS LIST');

    print('category id===========>');
    print(str_selected_category_id);
    if (str_selected_category_id == '') {
      func_get_action_with_cat_id_list_WB(str_get_action_name);
    } else {
      str_main_loader = 'tasks_loader_start';
      setState(() {});

      SharedPreferences prefs = await SharedPreferences.getInstance();

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
            'pageNo': '1',
            'profesionalType': str_get_action_name.toString(),
            'categoryId': str_selected_category_id.toString()
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
          arr_task_list.clear();
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
    }
  }

  func_get_action_with_cat_id_list_WB(
    String professinal_type,
  ) async {
    print('=====> POST : TASKS LIST');

    str_main_loader = 'tasks_loader_start';
    setState(() {});

    SharedPreferences prefs = await SharedPreferences.getInstance();

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
          'pageNo': '1',
          'profesionalType': professinal_type.toString(),
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
        arr_task_list.clear();
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
