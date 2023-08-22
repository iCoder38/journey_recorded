// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:ui';

// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/goals/goals_details/goal_common_header/goal_common_header.dart';
import 'package:journey_recorded/goals/goals_details/goal_common_header/task_list_modal.dart';
import 'package:journey_recorded/inventory/edit_inventory/edit_inventory.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:journey_recorded/single_classes/single_class.dart';
import 'package:journey_recorded/sub_goals/sub_goals.dart';
import 'package:journey_recorded/task/create_task/create_task.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TeamScreen extends StatefulWidget {
  const TeamScreen(
      {super.key,
      required this.str_get_goal_id,
      required this.str_get_due_date,
      required this.str_get_parse_name,
      required this.str_professional_type});

  final String str_get_goal_id;
  final String str_get_due_date;
  final String str_get_parse_name;
  final String str_professional_type;

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  var str_UI_set_up_for = 'team';
  //
  var arr_task_list = [];
  var arr_team_list = [];
  // slider
  double _currentSliderValue = 0;
  //
  var arr_sub_goal_list = [];
  var str_task_in_team = '0';
  //
  final GetDifferenceBetweenDate parse_days_left = GetDifferenceBetweenDate();
  //
  GoalTaskModal goal_task_service = GoalTaskModal();
  //
  var str_sub_goal_show = '0';
  //
  var arr_send_teammate_request = [];
  var arr_approve_teammate = [];
  var str_send_teammate_count = '0';
  var str_approved_teammate_count = '0';
  //
  var team_task_loader = '0';
  //
  var str_task_count = '0';
  //
  @override
  void initState() {
    super.initState();

    print('ini titit');

    func_get_goals_list_WB();

    get_TEAM_list_WB(
      widget.str_get_goal_id,
      widget.str_professional_type,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('data'),
      ),*/
      floatingActionButton: FloatingActionButton(
        backgroundColor: navigation_color,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          //
          push_to_create_task(context);
          //
        },
      ),
      body: header_widget_UI(context),
    );
  }

  Container header_widget_UI(BuildContext context) {
    return Container(
      // height: 280,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 0,
            ),
            //
            // common header
            /*GoalCommonHeaderScreen(
              str_get_parse_name: widget.str_get_parse_name,
              str_get_due_date: widget.str_get_due_date.toString(),
              str_goal_id: widget.str_get_goal_id.toString(),
            ),*/
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            Container(
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
                                    widget.str_get_parse_name
                                        .toString()
                                        .toUpperCase(),
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
                                        label: _currentSliderValue
                                            .round()
                                            .toString(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            str_from_goal_id: widget
                                                .str_get_goal_id
                                                .toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  16.0,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  //
                                                  arr_sub_goal_list.length
                                                      .toString(),
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
                                //
                                team_task_loader = '1';
                                str_UI_set_up_for = 'tasks';
                                setState(() {});
                                //
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
                                            str_task_count.toString(),
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
            ),
            //

            if (team_task_loader == '0')
              const CustomeLoaderPopUp(
                str_custom_loader: 'please wait',
                str_status: '3',
              )
            else if (team_task_loader == '1')
              (str_UI_set_up_for == 'team')
                  ? Column(
                      children: <Widget>[
                        for (var i = 0; i < 1; i++) ...[
                          ExpansionTile(
                            title: Text(
                              //
                              '${'send a teammate request'.toString().toUpperCase()} ($str_send_teammate_count)',
                              //
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 18.0,
                              ),
                            ),
                            // subtitle: Text('Trailing expansion arrow icon'),

                            children: <Widget>[
                              for (var j = 0;
                                  j < arr_send_teammate_request.length;
                                  j++) ...[
                                ListTile(
                                  leading: Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.yellow,
                                    child: Image.network(
                                      arr_send_teammate_request[j]
                                              ['From_profile_picture']
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    //

                                    arr_send_teammate_request[j]['To_userName']
                                        .toString(),
                                    //
                                    style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    'skills : ${arr_send_teammate_request[j]['skill']}\nTask name : ${arr_send_teammate_request[j]['taskName']}',
                                  ),
                                  trailing: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const EditInventoryScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                          255,
                                          255,
                                          255,
                                          1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '\$500',
                                          style: TextStyle(
                                            fontFamily: font_style_name,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  isThreeLine: true,
                                ),
                              ]
                            ],
                          ),
                        ],
                        for (var i = 0; i < 1; i++) ...[
                          ExpansionTile(
                            title: Text(
                              //

                              '${'approve teammate'.toString().toUpperCase()} ($str_approved_teammate_count)',
                              //
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 18.0,
                              ),
                            ),
                            // subtitle: Text('Trailing expansion arrow icon'),

                            children: <Widget>[
                              for (var j = 0;
                                  j < arr_approve_teammate.length;
                                  j++) ...[
                                ListTile(
                                  leading: Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.yellow,
                                    child: Image.network(
                                      arr_approve_teammate[j]
                                              ['From_profile_picture']
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    //

                                    arr_approve_teammate[j]['To_userName']
                                        .toString(),
                                    //
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'skills : ${arr_send_teammate_request[j]['skill']}\nTask name : ${arr_send_teammate_request[j]['taskName']}',
                                  ),
                                  trailing: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 40,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                          255,
                                          255,
                                          255,
                                          1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                      ),
                                      /*child: Center(
                                  child: Text(
                                    '\$500',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),*/
                                    ),
                                  ),
                                  isThreeLine: true,
                                ),
                              ]
                            ],
                          ),
                        ]
                      ],
                    )
                  : task_in_team_UI(context),

            //
          ],
        ),
      ),
    );
  }

/*if (str_task_in_team == '0')
              const Text(
                'team',
              )
            else if (str_task_in_team == '2')
              const CustomeLoaderPopUp(
                str_custom_loader: 'deleting...',
                str_status: '3',
              )
            else if (str_task_in_team == 'please_wait')
              const CustomeLoaderPopUp(
                str_custom_loader: 'please wait...',
                str_status: '3',
              )
            else if (str_task_in_team == '4')
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: const Center(
                  child: Text(
                    'No task found. Please add task.',
                  ),
                ),
              )
            else
              task_in_team_UI(context),*/

  Column task_in_team_UI(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < arr_task_list.length; i++) ...[
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                  ),
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
                Container(
                  margin: const EdgeInsets.only(
                    right: 10.0,
                  ),
                  height: 50,
                  // width: 200,
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      ElevatedButton(
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
                          print('object');
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
                      ),
                    ],
                  ),
                ),
              ],
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

  /*Container quest_task_complete_ui() {
    return Container(
      height: 100,
      // width: 40,
      // height: 60,
      // width: me,
      color: const Color.fromRGBO(1, 27, 82, 1),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              // width: 40,
              color: Colors.transparent,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Quest',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: font_style_name,
                        fontSize: 18.0,
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
                          '8',
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
          InkWell(
            onTap: () {
              print('click task 7');

              str_task_in_team = '1';

              get_task_list_WB(
                widget.str_get_goal_id,
                widget.str_professional_type,
              );

              setState(() {});
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
                      'Tasks',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: font_style_name,
                        fontSize: 18.0,
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
                          '7',
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
          Expanded(
            child: Container(
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
                      'Complete',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: font_style_name,
                        fontSize: 18.0,
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
                          '11',
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
        ],
      ),
    );
  }*/

  Future<void> push_to_create_task(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskScreen(
          str_professional_id: widget.str_get_goal_id.toString(),
          str_professional_type: widget.str_professional_type.toString(),
        ),
      ),
    );

    print('result =====> ' + result);

    if (!mounted) return;

    team_task_loader = '0';
    setState(() {});
    get_TEAM_list_WB(
      widget.str_get_goal_id,
      widget.str_professional_type,
    );
  }

// ALERT
  Future<void> _showMyDialog(
    String str_message,
    String str_delete_task_id,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete',
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  //
                  '$str_message',
                  //
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Dismiss',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'yes,delete',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                delete_task_WB(
                  str_delete_task_id,
                );
              },
            ),
          ],
        );
      },
    );
  }

// delete task
  delete_task_WB(
    String str_task_id,
  ) async {
    print('=====> POST : DELETE TASK');

    str_task_in_team = '2';
    setState(() {});

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
          'action': 'taskdelete',
          'userId': prefs.getInt('userId').toString(),
          'taskId': str_task_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        // get_task_list_WB(
        //   widget.str_get_goal_id,
        //   widget.str_professional_type,
        // );
        //
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
          'parentGoalId': widget.str_get_goal_id.toString(),
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
        get_task_list_WB();

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

  get_TEAM_list_WB(
      String str_professional_id, String str_professional_type) async {
    print('=====> POST : TEAM LIST');

    // SharedPreferences prefs = await SharedPreferences.getInstance();
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
          'action': 'teamlist',
          'mainProfesionalId': str_professional_id.toString(),
          'mainProfesionalType': str_professional_type.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print('task list ');
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_team_list.clear();
        arr_send_teammate_request.clear();
        arr_approve_teammate.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_team_list.add(get_data['data'][i]);
          arr_send_teammate_request.add(get_data['data'][i]);
        }

        for (var i = 0; i < get_data['acceptData'].length; i++) {
          // print(get_data['data'][i]);
          // arr_team_list.add(get_data['data'][i]);
          arr_approve_teammate.add(get_data['data'][i]);
        }

        print('count start');
        // print(arr_send_teammate_request.length);
        str_send_teammate_count = arr_send_teammate_request.length.toString();
        // print(arr_approve_teammate.length);
        str_approved_teammate_count = arr_approve_teammate.length.toString();
        // print('count end');

        team_task_loader = '1';

        get_task_list_WB();
        // setState(() {});
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

  get_task_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : TASK LIST 2.0');
    }

    // team_task_loader = '0';
    // setState(() {});
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
          'profesionalId': widget.str_get_goal_id.toString(),
          'profesionalType': widget.str_professional_type.toString(),
          'pageNo': ''
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

        if (arr_task_list.isEmpty) {
          // str_goal_loader = '1';
        } else {
          // str_goal_loader = '2';
        }
        // team_task_loader = '1';
        // str_UI_set_up_for = 'tasks';
        str_task_count = arr_task_list.length.toString();

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
