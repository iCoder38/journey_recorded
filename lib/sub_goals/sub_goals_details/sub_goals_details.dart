// ignore_for_file: non_constant_identifier_names, slash_for_doc_comments, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/goals/edit_notes_in_goal/edit_notes_in_goal.dart';

import 'package:http/http.dart' as http;
import 'package:journey_recorded/goals/goals_details/goal_info/goal_info.dart';
import 'package:journey_recorded/goals/goals_details/goal_notes/goal_notes.dart';
import 'package:journey_recorded/goals/goals_details/goal_quotes/goal_quotes.dart';
import 'package:journey_recorded/mission/add_note_in_mission/add_note_in_mission.dart';
import 'package:journey_recorded/quotes/add_quotes/add_quotes.dart';
import 'package:journey_recorded/quotes/edit_quotes/edit_quotes.dart';
import 'package:journey_recorded/single_classes/single_class.dart';
import 'package:journey_recorded/team/team.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubGoalsDetailsScreen extends StatefulWidget {
  const SubGoalsDetailsScreen(
      {super.key,
      required this.str_get_goal_id,
      required this.str_get_sub_goal_goal_id,
      required this.str_get_sub_goal_category_id,
      required this.str_get_sub_goal_description,
      required this.str_get_sub_goal_category_name,
      required this.str_get_sub_goal_goal_name,
      required this.str_get_sub_goal_user_name,
      required this.str_deadline});

  final String str_get_goal_id;

  final String str_get_sub_goal_goal_id;
  final String str_get_sub_goal_category_id;
  final String str_get_sub_goal_description;
  final String str_get_sub_goal_category_name;
  final String str_get_sub_goal_goal_name;
  final String str_get_sub_goal_user_name;
  final String str_deadline;

  @override
  State<SubGoalsDetailsScreen> createState() => _SubGoalsDetailsScreenState();
}

class _SubGoalsDetailsScreenState extends State<SubGoalsDetailsScreen> {
  //
  final GetDifferenceBetweenDate parse_days_left = GetDifferenceBetweenDate();
  //
  // slider
  double _currentSliderValue = 0;
  //
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
  // notes
  var str_notes_loader_status = '0';
  var arr_notes_list = [];
  var str_get_message;
  var str_note_id;
  var str_profession_id;
  var str_professional_type;
  var str_user_id;

  //quotes
  var str_quotes = '0';
  var arr_quotes_list = [];
  var str_get_quote_id;
  var str_category_name;
  var str_category_id;
  var str_description;
  var str_quote_type;
  var str_name;
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('object');
    print(widget.str_deadline);
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
              isScrollable: true,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Info'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
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
                if (value == 1) {
                  print('NOTES BUTTON CLICK FROM BAR');
                  //

                  GoalNotesScreen(
                    str_get_goal_id: widget.str_get_sub_goal_goal_id.toString(),
                    str_get_due_date: widget.str_deadline.toString(),
                    str_get_parse_name:
                        widget.str_get_sub_goal_goal_name.toString(),
                    str_professional_type: 'Goal',
                  );
                } else if (value == 2) {
                  //
                  print('QUOTES BUTTON CLICK FROM BAR');

                  // tab 2
                  GoalNotesScreen(
                    str_get_goal_id: widget.str_get_sub_goal_goal_id.toString(),
                    str_get_due_date: widget.str_deadline.toString(),
                    str_get_parse_name:
                        widget.str_get_sub_goal_goal_name.toString(),
                    str_professional_type: 'Goal',
                  );
                } else if (value == 3) {
                  print('click team');
                  TeamScreen(
                    str_get_goal_id: widget.str_get_goal_id.toString(),
                    str_get_parse_name: widget.str_get_sub_goal_goal_name,
                    str_get_due_date: widget.str_deadline,
                    str_professional_type: 'Goal',
                  );
                }
              },
            ),
            backgroundColor: navigation_color,
            title: Text(
              ///
              navigation_title_sub_goal_details,

              ///
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            actions: [
              // Padding(
              //   padding: const EdgeInsets.only(
              //     right: 20.0,
              //   ),
              //   child: CircleAvatar(
              //     radius: 16,
              //     backgroundColor: app_yellow_color,
              //     child: const Icon(
              //       Icons.add,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: app_yellow_color,
                  child: const Icon(
                    Icons.question_mark,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: app_yellow_color,
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          /*floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showMyDialog();
            },
            backgroundColor: navigation_color,
            child: const Icon(
              Icons.add,
            ),
          ),*/
          body: TabBarView(children: <Widget>[
            //
            //tabbar_info_UI(context),

            // tab 1
            GoalInfoScreen(
              str_get_category_name:
                  widget.str_get_sub_goal_category_name.toString(),
              str_get_action_name: 'Sub-Goal',
              str_get_due_date: widget.str_deadline.toString(),
              str_about_goals: widget.str_get_sub_goal_description.toString(),
              str_goal_name: widget.str_get_sub_goal_goal_name,
              str_get_goal_id: widget.str_get_goal_id.toString(),
            ),

            // tab 2
            GoalNotesScreen(
              str_get_goal_id: widget.str_get_sub_goal_goal_id.toString(),
              str_get_due_date: widget.str_deadline.toString(),
              str_get_parse_name: widget.str_get_sub_goal_goal_name.toString(),
              str_professional_type: 'Goal',
            ),

            // tab 3
            GoalQuotesScreen(
              str_get_goal_id: widget.str_get_goal_id.toString(),
              str_get_parse_name: widget.str_get_sub_goal_goal_name,
              str_get_due_date: widget.str_deadline.toString(),
              str_professional_type: 'Goal',
            ),

            // tab 4
            TeamScreen(
              str_get_goal_id: widget.str_get_goal_id.toString(),
              str_get_parse_name: widget.str_get_sub_goal_goal_name,
              str_get_due_date: widget.str_deadline,
              str_professional_type: 'Goal',
            ),

            // tab 5
            Container(
              color: Colors.pink,
            ),

            // tab 6
            Container(
              color: Colors.pink,
            ),
          ]),
        ),
      ),
    );
  }

/******************************** NOTES UI ***********************************/
/***************************************************************************/

  SingleChildScrollView goals_details_NOTES_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          sub_goal_header_UI(context),
          //
          if (str_notes_loader_status == '0') ...[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Awaiting result...',
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              //scrollDirection: Axis.vertical,
              //shrinkWrap: true,
              itemCount: arr_notes_list.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // print('mission => notes => click');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 0.0,
                    ),
                    // height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: ListTile(
                      // leading: const FlutterLogo(size: 72.0),
                      title: Text(
                        //
                        arr_notes_list[index]['created'].toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      subtitle: Container(
                        margin: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        child: Text(
                          //
                          arr_notes_list[index]['message'].toString(),
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      /*trailing: Icon(
                        Icons.more_vert,
                      ),*/
                      isThreeLine: true,
                      trailing: Column(
                        children: <Widget>[
                          Expanded(
                            child: IconButton(
                              onPressed: (() {
                                print('mission => notes => setting => click');
                                print(index);

                                str_get_message =
                                    arr_notes_list[index]['message'].toString();
                                str_note_id =
                                    arr_notes_list[index]['noteId'].toString();
                                str_profession_id = widget.str_get_goal_id;
                                str_professional_type = 'Goal';

                                gear_popup(
                                  'Manage Notes',
                                  arr_notes_list[index]['noteId'].toString(),
                                );
                              }),
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  SingleChildScrollView tabbar_info_UI(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          sub_goal_header_UI(context),
          //
          Container(
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
              ],
            ),
          ),
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

  Container sub_goal_header_UI(BuildContext context) {
    return Container(
      height: 200,
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
                            widget.str_get_sub_goal_goal_name.toString(),
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
                                    'Due : 450 Days'.toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: Container(
                                height: 40,
                                width: 40,
                                color: Colors.purple,
                              ),
                            ),
                            SizedBox(
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
        ],
      ),
    );
  }

  /******************************** ALERT : POPUP ***********************************/
  /***************************************************************************/

  // ALERT
  Future<void> gear_popup(
    String str_title,
    String note_id_is,
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
                    print('edit 2');
                    Navigator.pop(context);

                    _navigateAndDisplaySelection(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.edit,
                            size: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Edit Note',
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
                    print(' delete note');

                    Navigator.pop(context);

                    delete_notes_WB(
                      note_id_is,
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.delete_forever,
                            size: 16.0,
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: ' Delete Note',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.red,
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

  /******************************** PUSH : EDIT NOTE **************************/
/***************************************************************************/

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    print('its me');
    print(str_professional_type);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotesInGoalScreen(
          str_message: str_get_message.toString(),
          str_note_id: str_note_id.toString(),
          str_professional_id: str_profession_id.toString(),
          str_professional_type: str_professional_type.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_edit_notes') {
      arr_notes_list.clear();
      setState(() {
        func_notes_WB();
      });
    }
  }

  /******************************** API : QUOTE LIST **************************/
/***************************************************************************/

  SingleChildScrollView tabbar_quotes_UI(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          //
          sub_goal_header_UI(context),
          //
          if (str_quotes == '0') ...[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(str_loader_title.toString()),
                  ),
                ],
              ),
            ),
          ] else ...[
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              //scrollDirection: Axis.vertical,
              //shrinkWrap: true,
              itemCount: arr_quotes_list.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 0.0,
                    ),
                    // height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: ListTile(
                      // leading: const FlutterLogo(size: 72.0),
                      title: Text(
                        //
                        arr_quotes_list[index]['name'].toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      subtitle: Container(
                        margin: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        child: Text(
                          //
                          arr_quotes_list[index]['description'].toString(),
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      /*trailing: Icon(
                        Icons.more_vert,
                      ),*/
                      isThreeLine: true,
                      trailing: Column(
                        children: <Widget>[
                          Expanded(
                            child: IconButton(
                              onPressed: (() {
                                // print(index);
                                str_get_quote_id = arr_quotes_list[index]
                                        ['quoteId']
                                    .toString();
                                str_category_name = arr_quotes_list[index]
                                        ['categoryName']
                                    .toString();
                                str_category_id = arr_quotes_list[index]
                                        ['categoryId']
                                    .toString();
                                str_description = arr_quotes_list[index]
                                        ['description']
                                    .toString();
                                str_quote_type = arr_quotes_list[index]
                                        ['quoteId']
                                    .toString();
                                str_name =
                                    arr_quotes_list[index]['name'].toString();

                                gear_mission_popup(
                                    arr_quotes_list[index]['name'].toString(),
                                    arr_quotes_list[index]['quoteId']
                                        .toString());
                              }),
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  /******************************** API : QUOTE LIST **************************/
/***************************************************************************/

  // QUOTES
  Future func_quotes_WB() async {
    print('=====> POST : QUOTES');

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
          'action': 'quotlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'profesionalId': widget.str_get_goal_id.toString(),
          'profesionalType': 'Goal',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      arr_quotes_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          // print('object');

          arr_quotes_list.add(i);
        }

        setState(() {
          str_quotes = '1';
        });
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

/******************************** PUSH : ADD QUOTE FOR MISSION *************/
/***************************************************************************/

  Future<void> add_quotes_push_via_future(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddQuotesScreen(
          str_add_quotes_main_id: widget.str_get_goal_id.toString(),
          str_profession_type: 'Goal'.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_add_quotes') {
      str_quotes = '0';
      setState(() {});
      print('YES I CAME FROM ADD QUOTE');
      // func_quotes_WB();
    }
  }

/******************************** API : DELETE GOAL *************************/
/***************************************************************************/

  // delete goal
  delete_goal_WB(
    String quote_id,
  ) async {
    print('=====> POST : DELETE QUOTES');

    str_quotes = '0';
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
          'action': 'quotedelete',
          'userId': prefs.getInt('userId').toString(),
          'quoteId': quote_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_quotes_list = [];
        //
        // func_quotes_WB();
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

                    push_to_edit_quotes_in_mission(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.edit,
                            size: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Edit Quote',
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
                    delete_goal_WB(goal_id_is);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.delete_forever,
                            size: 16.0,
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: ' Delete Quotes',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.red,
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

  Future<void> push_to_edit_quotes_in_mission(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditQuotesScreen(
          str_quotes_id: str_get_quote_id.toString(),
          categoryId: str_category_id.toString(),
          description: str_description.toString(),
          quote_type_id: str_quote_type.toString(),
          quote_type_name: str_name.toString(),
          category_name: str_category_name.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == '1') {
      //
      arr_quotes_list.clear();

      setState(() {
        // func_quotes_WB();
      });
    }
  }

  /******************************** API : DELETE NOTE ***********************************/
/***************************************************************************/

  delete_notes_WB(
    String note_id,
  ) async {
    print('=====> POST : DELETE NOTES');

    str_notes_loader_status = '0';
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
          'action': 'notedelete',
          'userId': prefs.getInt('userId').toString(),
          'noteId': note_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_notes_list = [];
        //
        func_notes_WB();
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

/******************************** API : NOTE LISTING ***********************************/
/***************************************************************************/

// note list WB
// NOTES
  Future func_notes_WB() async {
    print('=====> POST : NOTES 1');

    setState(() {
      str_notes_loader_status = '0';
    });
    //
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
          'action': 'notelist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'profesionalId': widget.str_get_goal_id.toString(),
          'profesionalType': 'Goal',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      arr_notes_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          // print('object');

          arr_notes_list.add(i);
        }

        setState(() {
          str_notes_loader_status = '1';
        });
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  /******************************** ALERT : OPEN DIALOG ***********************************/
/***************************************************************************/

  // ALERT
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add',
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
                    print('notes');
                    Navigator.pop(context);

                    add_note_push_via_future(context);
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
                          text: ' Add Notes',
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
                    print('quotes');

                    Navigator.pop(context);

                    add_quotes_push_via_future(context);
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
                          text: ' Add Quotes',
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

  /******************************** PUSH : ADD NOTE ***********************************/
  /***************************************************************************/

  Future<void> add_note_push_via_future(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNoteInMission(
          str_profession_id: widget.str_get_goal_id.toString(),
          str_profession_type: 'Goal',
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_add_notes') {
      arr_notes_list.clear();
      setState(() {
        func_notes_WB();
      });
    }
  }
}
