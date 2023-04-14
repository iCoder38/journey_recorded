// ignore_for_file: non_constant_identifier_names

// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/goals/goals_details/goal_common_header/goal_common_header.dart';
import 'package:journey_recorded/single_classes/single_class.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:http/http.dart' as http;

class GoalInfoScreen extends StatefulWidget {
  const GoalInfoScreen(
      {super.key,
      required this.str_get_category_name,
      required this.str_get_action_name,
      required this.str_get_due_date,
      required this.str_about_goals,
      required this.str_goal_name,
      required this.str_get_goal_id});

  final String str_get_goal_id;
  final String str_get_category_name;
  final String str_get_action_name;
  final String str_get_due_date;
  final String str_about_goals;
  final String str_goal_name;

  @override
  State<GoalInfoScreen> createState() => _GoalInfoScreenState();
}

class _GoalInfoScreenState extends State<GoalInfoScreen> {
  //
  final GetDifferenceBetweenDate parse_days_left = GetDifferenceBetweenDate();
  //
  // slider
  double _currentSliderValue = 0;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //
            // header
            GoalCommonHeaderScreen(
              str_get_parse_name: widget.str_goal_name.toString(),
              str_get_due_date: widget.str_get_due_date.toString(),
              str_goal_id: widget.str_get_goal_id.toString(),
            ),
            //

            Container(
              margin: const EdgeInsets.only(
                left: 40.0,
                top: 20,
                right: 20.0,
              ),
              height: 20,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(
                  22.0,
                ),
              ),
              child: Text(
                'Category',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 14.0,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(
                left: 20.0,
                top: 0,
                right: 20.0,
              ),
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(
                  22.0,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    top: 0,
                    right: 20.0,
                  ),
                  child: Text(
                    //
                    widget.str_get_category_name.toString(),
                    //
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // action
            Container(
              margin: const EdgeInsets.only(
                left: 40.0,
                top: 20,
                right: 20.0,
              ),
              height: 20,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(
                  22.0,
                ),
              ),
              child: Text(
                'Action',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 14.0,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(
                left: 20.0,
                top: 0,
                right: 20.0,
              ),
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(
                  22.0,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    top: 0,
                    right: 20.0,
                  ),
                  child: Text(
                    //
                    widget.str_get_action_name.toString(),
                    //
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            /*Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 10.0,
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Container(
                    height: 40,
                    width: 40,
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                              color: const Color.fromRGBO(
                                235,
                                235,
                                235,
                                1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  18.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Category',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                              color: const Color.fromRGBO(
                                235,
                                235,
                                235,
                                1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(
                                  18.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                //
                                widget.str_get_category_name.toString(),
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
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 0.0,
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Container(
                    height: 40,
                    width: 40,
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                              color: const Color.fromRGBO(
                                255,
                                255,
                                255,
                                1,
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(
                                  18.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Action',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                              color: const Color.fromRGBO(
                                255,
                                255,
                                255,
                                1,
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(
                                  18.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Goal',
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
            ),*/
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
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'STRONG WHY:',
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
              // height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: TextFormField(
                initialValue: widget.str_about_goals.toString(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  // hintText: 'Tell us about yourself',
                  // helperText: 'Keep it short, this is just a demo.',
                  labelText: 'Specific details',
                ),
                maxLines: 3,
              ),
            ),
            /*Container(
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
                'Edit',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),*/
          ],
        ),
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
                            widget.str_get_action_name.toString(),
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
                                '82',
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
        ],
      ),
    );
  }
}
