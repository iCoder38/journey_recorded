// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/goals/goals_details/goal_common_header/task_list_modal.dart';
import 'package:journey_recorded/single_classes/single_class.dart';
import 'package:journey_recorded/sub_goals/sub_goals.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GoalCommonHeaderScreen extends StatefulWidget {
  const GoalCommonHeaderScreen(
      {super.key,
      required this.str_get_parse_name,
      required this.str_get_due_date,
      required this.str_goal_id});

  final String str_get_parse_name;
  final String str_get_due_date;
  final String str_goal_id;

  @override
  State<GoalCommonHeaderScreen> createState() => _GoalCommonHeaderScreenState();
}

class _GoalCommonHeaderScreenState extends State<GoalCommonHeaderScreen> {
  //
  final GetDifferenceBetweenDate parse_days_left = GetDifferenceBetweenDate();
  //
  var arr_sub_goal_list = [];
  //
  // slider
  double _currentSliderValue = 0;
  //
  var str_sub_goal_show = '0';
  //
  GoalTaskModal goal_task_service = GoalTaskModal();
  //
  @override
  void initState() {
    super.initState();
    //
    func_get_goals_list_WB();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 280,
      width: MediaQuery.of(context).size.width,
      // color: Colors.pink,
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
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                ),
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  /*boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(
                        0,
                        3,
                      ), // changes position of shadow
                    ),
                  ],*/
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  height: 160,
                  //  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    /*boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(
                          0,
                          3,
                        ), // changes position of shadow
                      ),
                    ],*/
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Text(
                            //
                            widget.str_get_parse_name.toString().toUpperCase(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 20,
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Complete',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '50%',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 20,
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width,
                              child: Slider(
                                value: _currentSliderValue,
                                max: 100,
                                divisions: 5,
                                label: _currentSliderValue.round().toString(),
                                onChanged: (double value) {
                                  setState(
                                    () {
                                      _currentSliderValue = value;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.only(
                                  bottom: 6.0,
                                  left: 2.0,
                                ),
                                height: 60,
                                width: 80,
                                // width: MediaQuery.of(context).size.width,

                                decoration: const BoxDecoration(
                                  // color: Colors.orange,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      60.0,
                                    ),
                                    bottomLeft: Radius.circular(
                                      10.0,
                                    ),
                                    bottomRight: Radius.circular(
                                      60.0,
                                    ),
                                    topRight: Radius.circular(
                                      10.0,
                                    ),
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(250, 220, 10, 1),
                                      Color.fromRGBO(252, 215, 10, 1),
                                      Color.fromRGBO(251, 195, 11, 1),
                                      Color.fromRGBO(250, 180, 10, 1),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    //

                                    parse_days_left
                                        .func_difference_between_date(
                                            widget.str_get_due_date),
                                    //
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  // color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromRGBO(250, 220, 10, 1),
                                      Color.fromRGBO(252, 215, 10, 1),
                                      Color.fromRGBO(251, 195, 11, 1),
                                      Color.fromRGBO(250, 180, 10, 1),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.chat,
                                  ),
                                  onPressed: () {
                                    print('chat click');
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(1, 27, 82, 1),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 80,
                // width: MediaQuery.of(context).size.width,
                // height: 60,
                // width: me,
                color: const Color.fromRGBO(1, 27, 82, 1),
                child: Row(
                  children: <Widget>[
                    (str_sub_goal_show == '1')
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubGoalsScreen(
                                    str_from_goal_id:
                                        widget.str_goal_id.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              // width: 40,
                              color: Colors.transparent,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Sub-Goal'.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.pink,
                                        borderRadius: BorderRadius.circular(
                                          16.0,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          //
                                          arr_sub_goal_list.length.toString(),
                                          //
                                          style: TextStyle(
                                            fontFamily: font_style_name,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Text(''),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: 1,
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                    ),
                    Container(
                      // width: 40,
                      color: Colors.transparent,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Quest'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: font_style_name,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(
                                  16.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '0',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: 1,
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        goal_task_service.task_list_WB(
                          widget.str_goal_id.toString(),
                          'Goal',
                        );
                      },
                      child: Container(
                        // width: 40,
                        color: Colors.transparent,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(
                                8.0,
                              ),
                              child: Text(
                                'Tasks'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: font_style_name,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                8.0,
                              ),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(
                                    16.0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '0',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: 1,
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                    ),
                    Container(
                      // width: 40,
                      color: Colors.transparent,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(
                              4.0,
                            ),
                            child: Text(
                              'Complete'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: font_style_name,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                              4.0,
                            ),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(
                                  16.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '0',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 18.0,
                                  ),
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
            ),
          ),
        ],
      ),
    );
  }

  //

  // get cart
  func_get_goals_list_WB() async {
    print('=====> POST : GOAL LIST');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getInt('userId').toString());
    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      /*
      action: goallist
    userId: //OPTIONAL
    pageNo:
    parentGoalId:
    subGoal: //OPTIONAL 1 /2 1= Sub Goal, 2= Only Parent Goal 
      */
      body: jsonEncode(
        <String, String>{
          'action': 'goallist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'parentGoalId': widget.str_goal_id.toString(),
          'subGoal': '1'
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_sub_goal_list.add(get_data['data'][i]);
        }

//
        if (arr_sub_goal_list.isEmpty) {
          str_sub_goal_show = '0';
        } else {
          str_sub_goal_show = '1';
        }

        // func_get_mission_list_WB();

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

  // get cart
  func_get_mission_list_WB() async {
    print('=====> POST : GOAL LIST');

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
          'action': 'goallist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'parentGoalId': widget.str_goal_id.toString(),
          'subGoal': '1'
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_sub_goal_list.add(get_data['data'][i]);
        }

//
        if (arr_sub_goal_list.isEmpty) {
          str_sub_goal_show = '0';
        } else {
          str_sub_goal_show = '1';
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
