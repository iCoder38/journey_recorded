// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/habits/create_new_habit/create_new_habit.dart';
import 'package:journey_recorded/custom_files/language_translate_texts/language_translate_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class HabitsInfoScreen extends StatefulWidget {
  const HabitsInfoScreen({
    super.key,
    required this.str_habit_id,
    required this.str_get_name_your_habit,
    required this.str_get_category_id,
    required this.str_get_category_name,
    required this.str_get_user_name,
    required this.str_get_priority,
    required this.str_get_reminder_date,
    required this.str_get_reminder_time,
    required this.str_get_start,
    required this.str_get_trigger,
    required this.str_get_why,
    required this.str_get_danger,
    required this.str_get_pro,
    required this.str_get_specify,
    required this.str_get_time_name,
    required this.str_get_skill_name,
    required this.str_get_skill_id,
    required this.str_get_class,
  });

  final String str_habit_id;

  final String str_get_name_your_habit;
  final String str_get_category_id;
  final String str_get_category_name;
  final String str_get_user_name;
  final String str_get_priority;

  final String str_get_reminder_date;
  final String str_get_reminder_time;

  final String str_get_time_name;
  final String str_get_skill_name;
  final String str_get_skill_id;

  final String str_get_start;
  final String str_get_trigger;
  final String str_get_why;
  final String str_get_danger;
  final String str_get_pro;
  final String str_get_specify;

  final String str_get_class;

  @override
  State<HabitsInfoScreen> createState() => _HabitsInfoScreenState();
}

class _HabitsInfoScreenState extends State<HabitsInfoScreen> {
  //
  var str_name = 'please wait...';
  var str_trigger = 'please wait...';
  var str_why = 'please wait...';
  var str_danger = 'please wait...';
  var str_pro = 'please wait...';
  var str_specify = 'please wait...';
  //
  @override
  void initState() {
    super.initState();

    get_habits_details_WB();
  }

// habit details
  get_habits_details_WB() async {
    print('=====> POST : HABIT DETAILS');

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
          'action': 'habitdetail',
          'habitId': widget.str_habit_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        func_habits_fetch(get_data['data']);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          habits_info_EN,
          Colors.white,
          16.0,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: navigation_color,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: Center(
                child: Text(
                  //
                  str_name.toString(),
                  //
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //
            Container(
              // height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    color: Colors.transparent,
                    height: 30.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        //
                        'Trigger',
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          //
                          str_trigger.toString(),
                          //
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
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 12,
            ),
            //
            Container(
              // height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    color: Colors.transparent,
                    height: 30.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        //
                        'Why',
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          //
                          str_why.toString(),
                          //
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
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 12,
            ),
            //
            Container(
              // height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    color: Colors.transparent,
                    height: 30.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        //
                        'Danger',
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          //
                          str_danger.toString(),
                          //
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
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 12,
            ),
            //
            Container(
              // height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    color: Colors.transparent,
                    height: 30.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        //
                        'Pro',
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          //
                          str_pro.toString(),
                          //
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
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              // height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    color: Colors.transparent,
                    height: 30.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        //
                        'Specify',
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          //
                          str_specify.toString(),
                          //
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
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              // height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    color: Colors.transparent,
                    height: 30.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        //
                        'Select Class',
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          //
                          widget.str_get_class.toString(),
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
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
            const SizedBox(
              height: 12,
            ),
            /*Container(
              // height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    color: Colors.transparent,
                    height: 30.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        //
                        '1',
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          //
                          '2',
                          //
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
            ),*/
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                print('object');
                push_to_edit_habits(
                  context,
                  widget.str_habit_id.toString(),
                  widget.str_get_name_your_habit.toString(),
                  widget.str_get_user_name.toString(),
                  widget.str_get_category_id.toString(),
                  widget.str_get_category_name.toString(),
                  widget.str_get_priority.toString(),
                  widget.str_get_reminder_date.toString(),
                  widget.str_get_reminder_time.toString(),
                  widget.str_get_start.toString(),
                  widget.str_get_trigger.toString(),
                  widget.str_get_why.toString(),
                  widget.str_get_danger.toString(),
                  widget.str_get_pro.toString(),
                  widget.str_get_specify.toString(),
                  widget.str_get_class.toString(),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(
                    250,
                    42,
                    18,
                    1,
                  ),
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Edit Habit',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  func_habits_fetch(fetched) {
    //
    str_name = fetched['name'].toString();
    str_trigger = fetched['tiggerPoint'].toString();
    str_why = fetched['why'].toString();
    str_danger = fetched['danger'].toString();
    str_pro = fetched['pro'].toString();
    str_specify = fetched['specificDetails'].toString();

    setState(() {});
    //
  }

  Future<void> push_to_edit_habits(
    BuildContext context,
    String str_habit_id,
    String str_name,
    String str_category_id,
    String str_category_name,
    String str_user_name,
    String str_priority,
    String str_reminder_date,
    String str_reminder_time,
    String str_start,
    String str_trigger,
    String str_why,
    String str_danger,
    String str_pro,
    String str_specify,
    String str_class,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateNewHabitScreen(
          str_fetch_get_name_your_habit: str_name.toString(),
          str_fetch_get_user_name: str_user_name.toString(),
          str_fetch_get_priority: str_priority.toString(),
          str_fetch_get_reminder_date: str_reminder_date.toString(),
          str_fetch_get_reminder_time: str_reminder_time.toString(),
          str_fetch_get_start: str_start.toString(),
          str_fetch_get_trigger: str_trigger.toString(),
          str_fetch_get_why: str_why.toString(),
          str_fetch_get_danger: str_danger.toString(),
          str_fetch_get_pro: str_pro.toString(),
          str_fetch_get_specify: str_specify.toString(),
          str_fetch_get_habit_id: str_habit_id.toString(),
          str_fetch_get_category_id: widget.str_get_category_id.toString(),
          str_fetch_get_category_name: widget.str_get_category_name.toString(),
          str_fetch_get_skill: widget.str_get_skill_name,
          str_fetch_get_time: widget.str_get_time_name,
          str_fetched_select_class: str_class.toString(),
        ),
      ),
    );

    print('result =====> ' + result);

    if (!mounted) return;

    setState(() {});
  }
}
