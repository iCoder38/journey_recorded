// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, file_names

// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// base URL
var application_base_url =
    'https://demo4.evirtualservices.net/journey/services/index/';

// var application_base_url = 'https://app.journey-recorded.com/services/index';

var navigation_color = Color.fromRGBO(2, 25, 75, 1);

// app yellow color
var app_yellow_color = Color.fromRGBO(254, 228, 10, 1);

// FONT NAME
var font_style_name = 'Avenir Next';

// LODAER TITLE
var str_loader_title = 'Awaiting result...';

// NAVIGATION TITLE
var navigation_title_login = 'Login';
var navigation_title_registration = 'Registration';
var navigation_title_goal = 'Goals';
var navigation_title_edit_goals = 'Edit goals';
var navigation_title_edit_goals_task = 'Edit Goals/Task';
var navigation_title_goal_details = 'Goals Details';
var navigation_title_sub_goal = 'Sub-Goals';
var navigation_title_sub_goal_details = 'Sub-Goals Details';
var navigation_title_quest = 'Quest';
var navigation_title_quest_details = 'Quest Details';
var navigation_title_missions = 'Missions';
var navigation_title_mission_details = 'Mission Details';
var navigation_title_notes = 'Notes';
var navigation_title_all_task = 'All Task';
var navigation_title_reward = 'Rewards';
var navigation_title_create_goal = 'Create goal';
var navigation_title_invite_friends = 'Invite Friends';
var navigation_title_create_user = 'Create user';
var navigation_title_active_team = 'Active Team';
var navigation_title_request = 'Request';
var navigation_title_physical = 'Physical';
var navigation_title_shops = 'Shops';
var navigation_title_nevada_insurance = 'Nevada Insurance';
var navigation_title_insurace_details = 'Nevada Insurance';
var navigation_title_inventory = 'Inventory';
var navigation_title_edit_inventory = 'Edit Inventory';
var navigation_title_house_1 = 'House 1';
var navigation_title_finance = 'Finance';
var navigation_title_grind = 'Grinds';
var navigation_title_habits = 'Habits';
var navigation_title_habits_info = 'Habits Info';
var navigation_title_create_new_habit = 'Create new habit';
var navigation_title_skills = 'Skills';
var navigation_title_add_sub_goal = 'Add Sub goal';
var navigation_title_create_grind = 'Create Grind'.toUpperCase();

/* ================================================================ */

// text with regular
Text text_with_regular_style(str) {
  return Text(
    str.toString(),
    style: GoogleFonts.montserrat(
      fontSize: 16.0,
    ),
  );
}

Text text_regular_style_custom(str, color, size) {
  return Text(
    str.toString(),
    style: GoogleFonts.montserrat(
      color: color,
      fontSize: size,
    ),
  );
}

Text text_bold_style_custom(str, color, size) {
  return Text(
    str.toString(),
    style: GoogleFonts.montserrat(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w700,
    ),
  );
}

// text with bold
Text text_with_bold_style(str) {
  return Text(
    str.toString(),
    style: GoogleFonts.montserrat(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  );
}

// text with bold
Text text_with_bold_style_black(str) {
  return Text(
    str.toString(),
    style: GoogleFonts.montserrat(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  );
}

// text with semi bold
Text text_with_semi_bold_style_black(str) {
  return Text(
    str.toString(),
    style: GoogleFonts.montserrat(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  );
}

/* ================================================================ */

/* ================================================================ */

void startLoadingUI(BuildContext context, String message) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: text_regular_style_custom(
                    //,
                    message,
                    Colors.black,
                    14.0,
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              //   child: Text("OK"),
              // )
            ],
          ),
        ),
      );
    },
  );
}

/*
MaterialApp(
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: navigation_color,
            bottom: TabBar(
              // controller: _tabController,
              isScrollable: true,
              indicatorColor: app_yellow_color,
              tabs: const [
                Padding(
                  padding: EdgeInsets.all(
                    10.0,
                  ),
                  child: Text(
                    'Info',
                    style: TextStyle(
                      fontFamily: 'Avenir Next',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    10.0,
                  ),
                  child: Text(
                    'Notes',
                    style: TextStyle(
                      fontFamily: 'Avenir Next',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    10.0,
                  ),
                  child: Text(
                    'Quotes',
                    style: TextStyle(
                      fontFamily: 'Avenir Next',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    10.0,
                  ),
                  child: Text(
                    'Team',
                    style: TextStyle(
                      fontFamily: 'Avenir Next',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    10.0,
                  ),
                  child: Text(
                    'Reward',
                    style: TextStyle(
                      fontFamily: 'Avenir Next',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    10.0,
                  ),
                  child: Text(
                    'Link',
                    style: TextStyle(
                      fontFamily: 'Avenir Next',
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            title: const Text(
              'Dashbaord',
              style: TextStyle(
                fontFamily: 'Avenir Next',
                fontSize: 18.0,
              ),
            ),
          ),
          body: Container(
            child: Column(
              children: const <Widget>[
                DefaultTabController(
                  length: 4,
                  child: TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                /*TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.person),
                    ),
                    Tab(
                      icon: Icon(Icons.person),
                    ),
                    Tab(
                      icon: Icon(Icons.person),
                    ),
                    Tab(
                      icon: Icon(Icons.person),
                    ),
                    Tab(
                      icon: Icon(Icons.person),
                    ),
                    Tab(
                      icon: Icon(Icons.person),
                    ),
                  ],
                )*/
              ],
            ),
          ),
        ),
      ),
    );
*/