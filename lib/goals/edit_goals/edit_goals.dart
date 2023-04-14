// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/goals/edit_goal_task/edit_goal_task.dart';
import 'package:journey_recorded/quotes/edit_quotes/edit_quotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class EditGoalsScreen extends StatefulWidget {
  const EditGoalsScreen(
      {super.key,
      required this.str_get_edit_category_name,
      required this.str_get_edit_name,
      required this.str_get_edit_date,
      required this.str_get_edit_about_goal,
      required this.str_goals_id});

  final String str_get_edit_category_name;
  final String str_get_edit_name;
  final String str_get_edit_date;
  final String str_get_edit_about_goal;
  final String str_goals_id;

  @override
  State<EditGoalsScreen> createState() => _EditGoalsScreenState();
}

class _EditGoalsScreenState extends State<EditGoalsScreen> {
  // email
  TextEditingController cont_category =
      TextEditingController(text: 'please wait...');
  TextEditingController cont_action =
      TextEditingController(text: 'please wait...');
  TextEditingController cont_add_reminder =
      TextEditingController(text: 'please wait...');
  TextEditingController cont_strong_why =
      TextEditingController(text: 'please wait...');
  TextEditingController cont_about =
      TextEditingController(text: 'please wait...');
  //
  // password

// quotes - category
  TextEditingController cont_quotes_category =
      TextEditingController(text: 'please wait...');
  // quotes - type
  TextEditingController cont_quotes_type =
      TextEditingController(text: 'please wait...');
  // quotes - text
  TextEditingController cont_quotes_text =
      TextEditingController(text: 'please wait...');
  //
  var get_webservice_data;
  //
  var str_info_loader_status = '0';
  //
  var str_notes_loader_status = '0';
  var arr_notes_list = [];
  //
  var arr_quotes_for_edit = [];
  //
  var str_quotes_loader_status = '0';
  //
  var arr_get_category_list = [];
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
  var str_category_id = '';
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    func_goal_details_WB();
    func_difference_between_date(widget.str_get_edit_date);
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
              onTap: (value) {
                if (value == 0) {
                  //
                  func_goal_details_WB();
                  //
                } else if (value == 1) {
                  //
                  func_notes_WB();
                  //
                } else if (value == 2) {
                  //
                  func_quotes_WB();
                  //
                }
              },
              indicatorColor: Colors.lime,
              isScrollable: true,
              // labelColor: Colors.amber,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Info',
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
                    'Notes',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Quotes',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Team',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Reward',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Link',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: navigation_color,
            title: Text(
              ///
              navigation_title_edit_goals,

              ///
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            actions: [
              /*Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: InkWell(
                  onTap: () {
                    //
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const EditGoalsScreen(),
                    //   ),
                    // );
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: app_yellow_color,
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),*/
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
          body: Container(
            color: Colors.transparent,
            child: TabBarView(
              children: <Widget>[
                //
                goals_details_INFO_ui(context),
                //
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      //
                      header_edit_UI(context),
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
                                child: Text('Awaiting result...'),
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
                                    arr_notes_list[index]['userName']
                                        .toString(),
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
                                      arr_notes_list[index]['message']
                                          .toString(),
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
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                //
                goals_details_QUOTES_ui(context),
                //
                goals_details_TEAM_ui(context),
                //
                goals_details_REWARD_ui(context),
                //
                goals_details_LINK_ui(context),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView goals_details_LINK_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          header_edit_UI(context),
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
                  child: InkWell(
                    onTap: () {
                      //
                      print('tasks click');
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditGoalTaskScreen(),
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
                            child: InkWell(
                              onTap: () {
                                print('object');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditGoalTaskScreen(),
                                  ),
                                );
                              },
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
                          ),
                        ],
                      ),
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

  Container header_edit_UI(BuildContext context) {
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
                            widget.str_get_edit_name.toString(),
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
                                    func_difference_between_date(
                                        widget.str_get_edit_date),
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

  ///
  ///
  ///
  ///
  ///
  // INFO
  ///
  ///
  ///
  ///
  ///
  SingleChildScrollView goals_details_INFO_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          header_edit_UI(context),
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
                  child: InkWell(
                    onTap: () {
                      //
                      print('tasks click');
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditGoalTaskScreen(),
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
          /*Container(
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 20.0,
            ),
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: TextFormField(
              controller: cont_category,
              readOnly: true,
              onTap: () {
                print('open category lists');
                category_list_POPUP();
              },
              // keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.category,
                ),
                border: OutlineInputBorder(),

                labelText: 'Category',
                // prefixText: '\$',
                // suffixText: 'USD',
                suffixStyle: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ),*/
          Container(
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 20.0,
            ),
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: TextFormField(
              controller: cont_action,
              // keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Action',
                // prefixText: '\$',
                // suffixText: 'USD',
                suffixStyle: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 20.0,
            ),
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: TextFormField(
              controller: cont_add_reminder,
              // keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add reminders',
                // prefixText: '\$',
                // suffixText: 'USD',
                suffixStyle: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 20.0,
            ),
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: TextFormField(
              controller: cont_strong_why,
              // keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Strong why',
                // prefixText: '\$',
                // suffixText: 'USD',
                suffixStyle: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 20.0,
            ),
            // height: 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: TextFormField(
              controller: cont_about,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // hintText: 'Tell us about yourself',
                // helperText: 'Keep it short, this is just a demo.',
                labelText: 'Give us a Specific details',
              ),
              maxLines: 3,
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  ///
  // QUOTES
  ///
  ///
  ///
  ///
  ///
  SingleChildScrollView goals_details_QUOTES_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          header_edit_UI(context),
          //
          quest_task_complete_UI(context),
          //
          if (str_quotes_loader_status == '0') ...[
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
                    child: Text('Awaiting result...'),
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
              itemCount: arr_quotes_for_edit.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print(index + 1);
                    print('edit goal - quotes click');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditQuotesScreen(
                          str_quotes_id:
                              arr_quotes_for_edit[index]['quoteId'].toString(),
                          categoryId: arr_quotes_for_edit[index]['categoryId']
                              .toString(),
                          description: arr_quotes_for_edit[index]['description']
                              .toString(),
                          // name: arr_quotes_for_edit[index]['name'].toString(),
                          quote_type_id: arr_quotes_for_edit[index]['quoteType']
                              .toString(),
                          quote_type_name:
                              arr_quotes_for_edit[index]['name'].toString(),
                          category_name: arr_quotes_for_edit[index]
                                  ['categoryName']
                              .toString(),
                        ),
                      ),
                    );
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
                        arr_quotes_for_edit[index]['name'].toString(),
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
                          arr_quotes_for_edit[index]['description'].toString(),
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
                    ),
                  ),
                );
              },
            ),
          ],
          /*Container(
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 20.0,
            ),
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: TextFormField(
              controller: cont_quotes_category,
              readOnly: true,
              // keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.category,
                ),
                border: OutlineInputBorder(),
                labelText: 'Category',
                // prefixText: '\$',
                // suffixText: 'USD',
                suffixStyle: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 20.0,
            ),
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: TextFormField(
              controller: cont_quotes_type,
              readOnly: true,
              // keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.merge_type,
                ),
                border: OutlineInputBorder(),
                labelText: 'Quote Type',
                // prefixText: '\$',
                // suffixText: 'USD',
                suffixStyle: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 20.0,
            ),
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: TextFormField(
              controller: cont_quotes_text,
              // keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Text',
                // prefixText: '\$',
                // suffixText: 'USD',
                suffixStyle: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(
              10.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              color: const Color.fromRGBO(
                250,
                42,
                18,
                1,
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
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                'Edit quotes',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),*/
          const SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }

  Container quest_task_complete_UI(BuildContext context) {
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
          Expanded(
            child: InkWell(
              onTap: () {
                //
                print('tasks click');
                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditGoalTaskScreen(),
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
  }

  ///
  ///
  ///
  ///
  ///
  // INFO
  ///
  ///
  ///
  ///
  ///
  SingleChildScrollView goals_details_REWARD_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          header_edit_UI(context),
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
                  child: InkWell(
                    onTap: () {
                      //
                      print('tasks click');
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditGoalTaskScreen(),
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

  ///
  ///
  ///
  ///
  ///
  // INFO
  ///
  ///
  ///
  ///
  ///
  SingleChildScrollView goals_details_TEAM_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          header_edit_UI(context),
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
                  child: InkWell(
                    onTap: () {
                      //
                      print('tasks click');
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditGoalTaskScreen(),
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
      setState(() {});

      return 'overdue';
    } else {
      setState(() {});
      return '$difference days left';
    }
  }

// edit goals
  Future func_goal_details_WB() async {
    print('=====> POST : GOALS DETAILS');

    // setState(() {
    //   str_notes_loader_status = '0';
    // });
    //
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'goalldetails',
          'goalId': widget.str_goals_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    get_webservice_data = get_data['data'];

    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        cont_category.text = get_webservice_data['categoryName'];
        cont_action.text = get_webservice_data['mission'];
        cont_add_reminder.text = 'n.a.'; //get_webservice_data[''];
        cont_strong_why.text = get_webservice_data['subGoalName'];
        cont_about.text = get_webservice_data['aboutGoal'];
        //
        func_category_list_WB();
        //

      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  // edit goals
  Future func_category_list_WB() async {
    print('=====> POST : GOALS DETAILS');

    // setState(() {
    //   str_notes_loader_status = '0';
    // });
    //
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'goalldetails',
          'goalId': widget.str_goals_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    get_webservice_data = get_data['data'];

    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        setState(() {
          str_info_loader_status = '1';
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

// QUOTES
  Future func_quotes_WB() async {
    print('=====> POST : QUOTES 4 EDIT');

    setState(() {
      str_quotes_loader_status = '0';
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
          'action': 'quotlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'profesionalId': '',
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
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //   // print('object');

          arr_quotes_for_edit.add(i);
        }

        setState(() {
          str_quotes_loader_status = '1';
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

  // NOTES
  Future func_notes_WB() async {
    print('=====> POST : NOTES 4 EDIT');

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
          'profesionalId': '',
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

  // ALERT
  Future<void> category_list_POPUP() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Please select Category',
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 16.0,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: ListView.builder(
                    itemCount: arr_get_category_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          //
                          str_category_id =
                              arr_get_category_list[index]['id'].toString();
                          //
                          cont_category.text =
                              arr_get_category_list[index]['name'].toString();
                          //
                          setState(() {});
                        },
                        child: ListTile(
                          leading: const Icon(
                            Icons.category,
                          ),
                          title: Text(
                            //
                            arr_get_category_list[index]['name'].toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
              ],
              //
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
}
