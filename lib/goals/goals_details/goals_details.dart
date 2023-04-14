// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

// import 'dart:ui';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/goals/add_notes_in_goal/add_notes_in_goal.dart';
// import 'package:journey_recorded/goals/edit_goals/edit_goals.dart';
// import 'package:journey_recorded/mission/mission_details/mission_details.dart';

import 'package:http/http.dart' as http;
import 'package:journey_recorded/goals/edit_notes_in_goal/edit_notes_in_goal.dart';
import 'package:journey_recorded/goals/goals_details/goal_info/goal_info.dart';
import 'package:journey_recorded/goals/goals_details/goal_notes/goal_notes.dart';
import 'package:journey_recorded/goals/goals_details/goal_quotes/goal_quotes.dart';
import 'package:journey_recorded/inventory/edit_inventory/edit_inventory.dart';
import 'package:journey_recorded/mission/add_mission/add_mission.dart';
import 'package:journey_recorded/quotes/add_quotes/add_quotes.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:journey_recorded/single_classes/single_class.dart';
import 'package:journey_recorded/sub_goals/add_sub_goal/add_sub_goal.dart';
import 'package:journey_recorded/sub_goals/sub_goals.dart';
import 'package:journey_recorded/team/team.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalsDetailsScreen extends StatefulWidget {
  const GoalsDetailsScreen(
      {super.key,
      required this.str_category_name,
      required this.str_name,
      required this.str_due_date,
      required this.str_get_about_goal,
      required this.str_get_goal_id,
      required this.str_category_id});

  final String str_category_id;
  final String str_category_name;
  final String str_name;
  final String str_due_date;
  final String str_get_about_goal;
  final String str_get_goal_id;

  @override
  State<GoalsDetailsScreen> createState() => _GoalsDetailsScreenState();
}

class _GoalsDetailsScreenState extends State<GoalsDetailsScreen> {
  // loader status
  var str_notes_loader_status = '0';
  var arr_notes_list = [];

  var str_quotes_loader_status = '0';

  //
  var arr_task_list = [];
  //
  var show_sub_goals = '0';
  //
  var str_parse_name = '';
  //
  // slider
  double _currentSliderValue = 0;
  //
  var str_panel_number;
  //
  var str_get_message;
  var str_note_id;
  var str_profession_id;
  var str_professional_type;
  var str_user_id;

  var arr_sub_goal_details = [
    'Goals:',
    'Sub Goal:',
    'Quest:',
    'Mission:',
  ];
  //
  var arr_sub_goal_value = [
    'Insurance Business',
    '',
    '',
    '',
  ];
  //
//
  final GetDifferenceBetweenDate parse_days_left = GetDifferenceBetweenDate();
  //
  var arr_inventory_header = [
    {'name': 'ASSETS'},
    {'name': 'LIABILITIES'},
    {'name': 'OTHER'},
  ];
  var arr_inventory_sub_tiles = [
    {'name': '2014 dodge ram'},
    {'name': 'Rent house 1'},
    {'name': 'Job'},
  ];

  //
  var str_loader_start = 'team_loader_start';
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // func_a();

    str_profession_id = widget.str_get_goal_id;

    str_parse_name = widget.str_name;

    parse_days_left.func_difference_between_date(widget.str_due_date);

// hit webservice
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: TabBar(
              indicatorColor: Colors.lime,
              isScrollable: true,
              // labelColor: Colors.amber,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Info'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Notes'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Quotes'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Team'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Reward'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Link'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
              onTap: (value) {
                print(value);
                if (value == 1) {
                  print('NOTES BUTTON CLICK FROM BAR');
                  GoalNotesScreen(
                    str_get_goal_id: widget.str_get_goal_id.toString(),
                    str_get_parse_name: widget.str_name,
                    str_get_due_date: widget.str_due_date,
                    str_professional_type: 'Goal',
                  );
                } else if (value == 2) {
                  print('click quotes');
                  GoalQuotesScreen(
                      str_get_goal_id: widget.str_get_goal_id.toString(),
                      str_get_parse_name: widget.str_name,
                      str_get_due_date: widget.str_due_date,
                      str_professional_type: 'Goal');
                } else if (value == 3) {
                  print('click team');

                  str_loader_start = 'team_loader_start';
                  // setState(() {});
                  // get_task_list_WB(
                  //   widget.str_get_goal_id,
                  //   'Goal',
                  // );
                  TeamScreen(
                    str_get_goal_id: widget.str_get_goal_id.toString(),
                    str_get_parse_name: widget.str_name,
                    str_get_due_date: widget.str_due_date,
                    str_professional_type: 'Goal',
                  );
                  // setState(() {});
                }
              },
            ),
            backgroundColor: navigation_color,
            title: Text(
              ///
              navigation_title_goal_details,

              ///
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 14.0,
                ),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: app_yellow_color,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 16,
                    ),
                    onPressed: () {
                      print('object');
                      gear_mission_popup('', widget.str_get_goal_id);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 14.0,
                ),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: app_yellow_color,
                  child: const Icon(
                    Icons.question_mark,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 14.0,
                ),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: app_yellow_color,
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            color: Colors.transparent,
            child: TabBarView(
              children: <Widget>[
                // tab 1
                GoalInfoScreen(
                  str_get_category_name: widget.str_category_name.toString(),
                  str_get_action_name: 'Goal',
                  str_get_due_date: widget.str_due_date.toString(),
                  str_about_goals: widget.str_get_about_goal.toString(),
                  str_goal_name: widget.str_name,
                  str_get_goal_id: widget.str_get_goal_id.toString(),
                ),

                // tab 2
                GoalNotesScreen(
                  str_get_goal_id: widget.str_get_goal_id.toString(),
                  str_get_parse_name: widget.str_name,
                  str_get_due_date: widget.str_due_date,
                  str_professional_type: 'Goal',
                ),

                // tab 3
                GoalQuotesScreen(
                    str_get_goal_id: widget.str_get_goal_id.toString(),
                    str_get_parse_name: widget.str_name,
                    str_get_due_date: widget.str_due_date,
                    str_professional_type: 'Goal'),

                // tab 4
                TeamScreen(
                  str_get_goal_id: widget.str_get_goal_id.toString(),
                  str_get_parse_name: widget.str_name,
                  str_get_due_date: widget.str_due_date,
                  str_professional_type: 'Goal',
                ),

                // tab 4

                // tab_4_team_UI(context),
                /*Column(
                  children: <Widget>[
                    // loader start when team click
                    if (str_loader_start == 'team_loader_start')
                      const CustomeLoaderPopUp(
                        str_custom_loader: 'please wait...',
                        str_status: '3',
                      )
                    else
                      for (var i = 0; i < arr_inventory_header.length; i++) ...[
                        ExpansionTile(
                          title: Text(
                            //
                            arr_inventory_header[i]['name'].toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 18.0,
                            ),
                          ),
                          // subtitle: Text('Trailing expansion arrow icon'),

                          children: <Widget>[
                            for (var j = 0;
                                j < arr_inventory_sub_tiles.length;
                                j++) ...[
                              ListTile(
                                leading: const FlutterLogo(size: 72.0),
                                title: Text(
                                  arr_inventory_sub_tiles[j]['name'].toString(),
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: const Text(
                                    'A sufficiently long subtitle warrants three lines.'),
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
                                        250,
                                        0,
                                        60,
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
                  ],
                ),*/

                // tab 5
                goals_details_REWARD_ui(context),
                goals_details_LINK_ui(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column tab_4_team_UI(BuildContext context) {
    return Column(
      children: <Widget>[
        // loader start when team click
        if (str_loader_start == 'team_loader_start')
          const CustomeLoaderPopUp(
            str_custom_loader: 'please wait...',
            str_status: '3',
          )
        else
          for (var i = 0; i < arr_inventory_header.length; i++) ...[
            ExpansionTile(
              title: Text(
                //
                arr_inventory_header[i]['name'].toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                ),
              ),
              // subtitle: Text('Trailing expansion arrow icon'),

              children: <Widget>[
                for (var j = 0; j < arr_inventory_sub_tiles.length; j++) ...[
                  ListTile(
                    leading: const FlutterLogo(size: 72.0),
                    title: Text(
                      arr_inventory_sub_tiles[j]['name'].toString(),
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                        'A sufficiently long subtitle warrants three lines.'),
                    trailing: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(
                            250,
                            0,
                            60,
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
      ],
    );
  }

  SingleChildScrollView goals_details_LINK_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          header_widget_UI(context),
          //

          Column(
            children: [
              for (var i = 0; i < arr_sub_goal_details.length; i++) ...[
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        arr_sub_goal_details[i].toString(),
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        ' Insurance Business ',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }

  Container header_widget_UI(BuildContext context) {
    return Container(
      // height: 280,
      width: MediaQuery.of(context).size.width,
      color: Colors.amber,
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
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(
                        0,
                        3,
                      ), // changes position of shadow
                    ),
                  ],
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
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(
                          0,
                          3,
                        ), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Text(
                            //
                            str_parse_name.toString(),
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
                              color: Colors.amber,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                //mainAxisAlignment:
                                //MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Complete',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '50%',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
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
                              color: Colors.purple,
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
                                            widget.str_due_date),

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
                                color: Colors.purple,
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
            height: 100,
            // width: 40,
            // height: 60,
            // width: me,
            color: const Color.fromRGBO(1, 27, 82, 1),
            // show_sub_goals
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
                            'Quest 2',
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
                Expanded(
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
                            'Complete 2',
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
          ),
        ],
      ),
    );
  }

  SingleChildScrollView goals_details_REWARD_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          header_widget_UI(context),
          //

          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            //scrollDirection: Axis.vertical,
            //shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 0.0,
                  ),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Card(
                    child: ListTile(
                      leading: const FlutterLogo(size: 72.0),
                      title: Text(
                        'Three-line ListTile',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Text(
                          'A sufficiently long subtitle warrants three lines.'),
                      /*trailing: Icon(
                        Icons.more_vert,
                      ),*/
                      isThreeLine: true,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> add_quotes_push_via_future(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddQuotesScreen(
          str_add_quotes_main_id: str_profession_id.toString(),
          str_profession_type: 'Goal'.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_add_quotes') {
      // arr_notes_list.clear();
      print('YES I CAME FROM ADD QUOTE');
    }
  }

  /******************************** ALERT : MISSION GEAR POPUP *************************/
/***************************************************************************/

  // ALERT
  Future<void> gear_mission_popup(
    String str_title,
    String goal_id_is,
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
                    push_to_add_sub_goal(context);
                    // sss
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.add,
                            size: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Add Sub-Goal',
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
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    print('delete quotes');

                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddMissionScreen(
                          str_category_id: widget.str_category_id.toString(),
                          str_goal_id: goal_id_is.toString(),
                          str_edit_status: '0',
                          str_deadline: widget.str_due_date.toString(),
                          str_mission_text: widget.str_get_about_goal,
                          str_mission_id: '',
                          str_navigation_title: 'Mission',
                        ),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.add,
                            size: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' Add Mission',
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
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> push_to_add_sub_goal(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSubGoalScreen(
          str_goal_id: widget.str_get_goal_id.toString(),
        ),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

// back_after_add_sub_goal

    if (!mounted) return;

    // if (result)
    setState(() {
      GoalInfoScreen(
        str_get_category_name: widget.str_category_name.toString(),
        str_get_action_name: 'Goal',
        str_get_due_date: widget.str_due_date.toString(),
        str_about_goals: widget.str_get_about_goal.toString(),
        str_goal_name: widget.str_name,
        str_get_goal_id: widget.str_get_goal_id.toString(),
      );
    });
  }

  // tab 4
  tab_4_UI() {
    Column(
      children: <Widget>[
        for (var i = 0; i < arr_inventory_header.length; i++) ...[
          ExpansionTile(
            title: Text(
              //
              arr_inventory_header[i]['name'].toString(),
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            // subtitle: Text('Trailing expansion arrow icon'),

            children: <Widget>[
              for (var j = 0; j < arr_inventory_sub_tiles.length; j++) ...[
                ListTile(
                  leading: const FlutterLogo(size: 72.0),
                  title: Text(
                    arr_inventory_sub_tiles[j]['name'].toString(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                          250,
                          0,
                          60,
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
      ],
    );
  }

  get_task_list_WB(
      String str_professional_id, String str_professional_type) async {
    print('=====> POST : TEAM LIST');

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
          'action': 'teamlist',
          // 'userId': prefs.getInt('userId').toString(),
          'mainProfesionalId': str_professional_id.toString(),
          'mainProfesionalType': str_professional_type.toString(),
          // 'pageNo': ''
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_task_list.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_task_list.add(get_data['data'][i]);
        }

        print('m');
        str_loader_start == 'team_loader_stop';

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
