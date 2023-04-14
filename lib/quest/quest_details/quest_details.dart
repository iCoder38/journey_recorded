// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class QuestDetailsScreen extends StatefulWidget {
  const QuestDetailsScreen({super.key});

  @override
  State<QuestDetailsScreen> createState() => _QuestDetailsScreenState();
}

class _QuestDetailsScreenState extends State<QuestDetailsScreen> {
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    'Info',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
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
              navigation_title_quest_details,

              ///
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: app_yellow_color,
                  child: const Icon(
                    Icons.add,
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
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
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
                                        'The British Museum',
                                        style: TextStyle(
                                          fontFamily: font_style_name,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
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
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                                  Color.fromRGBO(
                                                      250, 220, 10, 1),
                                                  Color.fromRGBO(
                                                      252, 215, 10, 1),
                                                  Color.fromRGBO(
                                                      251, 195, 11, 1),
                                                  Color.fromRGBO(
                                                      250, 180, 10, 1),
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
                ),
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
          ),
        ),
      ),
    );
  }
}
