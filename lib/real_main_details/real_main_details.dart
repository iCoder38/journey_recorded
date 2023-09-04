// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously, unused_element, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings, avoid_print

// all scroll blue 'Container type_UI(BuildContext context)'
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/goals/add_notes_in_goal/add_notes_in_goal.dart';
import 'package:journey_recorded/goals/edit_notes_in_goal/edit_notes_in_goal.dart';
import 'package:journey_recorded/mission/add_mission/add_mission.dart';
import 'package:journey_recorded/quotes/add_quotes/add_quotes.dart';
import 'package:journey_recorded/quotes/edit_quotes/edit_quotes.dart';
import 'package:journey_recorded/real_main_details/edit_details/edit_details.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:journey_recorded/single_classes/single_class.dart';
import 'package:journey_recorded/sub_goals/add_sub_goal/add_sub_goal.dart';
import 'package:journey_recorded/sub_goals/sub_goals.dart';
import 'package:journey_recorded/sub_goals/sub_goals_details/sub_goals_details.dart';
import 'package:journey_recorded/task/create_task/create_task.dart';
import 'package:journey_recorded/task_details/task_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

class RealMainDetailsScreen extends StatefulWidget {
  const RealMainDetailsScreen(
      {super.key,
      required this.str_category_id,
      required this.str_category_name,
      required this.str_name,
      required this.str_due_date,
      required this.str_get_about_goal,
      required this.str_get_goal_id,
      required this.str_navigation_title,
      required this.str_professional_type,
      required this.str_tray_value,
      required this.str_parent_name,
      required this.str_goal_cat_id,
      required this.str_image,
      required this.strFromViewDetails});

  final String str_image;
  final String str_tray_value;
  final String str_navigation_title;
  final String str_category_id;
  final String str_category_name;
  final String str_parent_name;
  final String str_name;
  final String str_due_date;
  final String str_get_about_goal;
  final String str_get_goal_id;
  final String str_professional_type;
  final String str_goal_cat_id;
  final String strFromViewDetails;

  @override
  State<RealMainDetailsScreen> createState() => _RealMainDetailsScreenState();
}

class _RealMainDetailsScreenState extends State<RealMainDetailsScreen>
    with SingleTickerProviderStateMixin {
  var str_tab_press = 'n.a';
  // picker
  // ImagePicker picker = ImagePicker();

  ImagePicker picker = ImagePicker();
  XFile? image;

  File? imageFile;
  File? imageFile_for_profile;
  var str_add_reward_loader = '1';
  //
  late final TextEditingController cont_reward_name;
  late final TextEditingController cont_reward_price;

  //
  var str_which_tab_bar_index_selected = 0;
  var str_show_ui = 'n.a';
  //
  // notes
  var arr_notes_list = [];
  var str_get_message;
  var str_note_id;
  var str_profession_id;
  var str_professional_type;
  var str_user_id;

  // quotes
  var arr_quotes_list = [];
  var str_get_quote_id;
  var str_category_name;
  var str_category_id;
  var str_description;
  var str_quote_type;
  var str_name;

  // team
  var arr_send_teammate_request = [];
  var arr_approve_teammate = [];
  var str_send_teammate_count = '0';
  var str_approved_teammate_count = '0';

  // sub goals
  var str_sub_goal_count = '...';
  var arr_sub_goals = [];

  // tasks
  var str_task_count = '...';
  var arr_task_list = [];

  // tasks
  var str_main_loader = '0';

  // quest
  var str_quest_count = '...';
  var arr_quest_list = [];

  // mission
  var str_mission_info_loader = '0';
  var str_mission_count = '...';
  var arr_mission_list = [];
  var arr_mission_info = [];

  // reward
  var arr_reward = [];
  //
  // slider
  double _currentSliderValue = 50;
  final GetDifferenceBetweenDate parse_days_left = GetDifferenceBetweenDate();
  var str_sub_goal_show = '0';
  //
  late TabController _tabController;
  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      print('========================');
      print('====== GOAL ID  ========');
      print(widget.str_get_goal_id);
      print('========================');
      print('======= VIEW PROFILE =======');
      print(widget.strFromViewDetails);
    }
    cont_reward_name = TextEditingController();
    cont_reward_price = TextEditingController();

    // print(widget.str_get_goal_id);
    _tabController = TabController(vsync: this, length: 6);

    func_get_goal_details_WB();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();

    cont_reward_name.dispose();
    cont_reward_price.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: text_bold_style_custom(
              //
              widget.str_name.toString().toUpperCase(), Colors.white, 16.0,
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
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.lime,
              isScrollable: true,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'Info'.toUpperCase(),
                    Colors.white,
                    14.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'notes'.toUpperCase(),
                    Colors.white,
                    14.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'quotes'.toUpperCase(),
                    Colors.white,
                    14.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'team'.toUpperCase(),
                    Colors.white,
                    14.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'reward'.toUpperCase(),
                    Colors.white,
                    14.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'link'.toUpperCase(),
                    Colors.white,
                    14.0,
                  ),
                ),
              ],
              onTap: (value) {
                if (kDebugMode) {
                  print(value);
                }
                str_show_ui = 'n.a.';
                str_which_tab_bar_index_selected = value;

                str_tab_press = value.toString();

                // _tabController.index.toString();
                if (value == 0) {
                  str_show_ui = 'n.a.';

                  setState(() {});
                } else if (value == 1) {
                  // notes
                  str_show_ui = 'n.a.';

                  str_main_loader = 'notes_loader_start';
                  setState(() {});
                  func_notes_WB();
                } else if (value == 2) {
                  // quotes
                  str_show_ui = 'n.a.';

                  str_main_loader = 'quotes_loader_start';
                  setState(() {});
                  (widget.strFromViewDetails == 'yes')
                      ? func_quotes_WB_without_userId()
                      : func_quotes_WB();
                } else if (value == 3) {
                  // quotes
                  str_show_ui = 'n.a.';

                  str_main_loader = 'team_loader_start';
                  setState(() {});
                  func_team_list_WB();
                } else if (value == 4) {
                  // quotes

                  str_show_ui = 'n.a.';

                  str_main_loader = 'reward_loader_start';
                  setState(() {});
                  func_reward_WB();

                  if (kDebugMode) {
                    print('clicked on reward');
                  }
                } else if (value == 5) {
                  // link
                  str_show_ui = 'n.a.';
                }
              },
            ),
            actions: <Widget>[
              if (widget.str_tray_value == 'goal') ...[
                Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print('action sheet');
                      }
                      //ActionSheetExample();
                      _showActionSheet(context);
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // delete
                      // print(widget.str_tray_value.toString());

                      gear_popup_22(
                        'Delete goal',
                        widget.str_get_goal_id.toString(),
                      );
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditDetailsScreen(
                            str_get_goal_for: 'n.a.',
                            str_get_category_id:
                                widget.str_category_id.toString(),
                            str_get_category_name:
                                widget.str_category_name.toString(),
                            str_get_goal_name: widget.str_name.toString(),
                            str_get_deadline: widget.str_due_date.toString(),
                            str_about_your_goal:
                                widget.str_get_about_goal.toString(),
                            str_goal_id: widget.str_get_goal_id.toString(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ),
              ] else if (widget.str_tray_value == 'sub_goal') ...[
                Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMissionScreen(
                            str_category_id: widget.str_category_id.toString(),
                            str_goal_id: widget.str_get_goal_id.toString(),
                            str_edit_status: '0',
                            str_deadline: '',
                            str_mission_text: '',
                            str_mission_id: '',
                            str_navigation_title: 'Add Mission',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // delete
                      if (kDebugMode) {
                        print(widget.str_tray_value.toString());
                      }

                      gear_popup_22(
                        'Delete goal',
                        widget.str_get_goal_id.toString(),
                      );
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditDetailsScreen(
                            str_get_goal_for: 'n.a.',
                            str_get_category_id:
                                widget.str_category_id.toString(),
                            str_get_category_name:
                                widget.str_category_name.toString(),
                            str_get_goal_name: widget.str_name.toString(),
                            str_get_deadline: widget.str_due_date.toString(),
                            str_about_your_goal:
                                widget.str_get_about_goal.toString(),
                            str_goal_id: widget.str_get_goal_id.toString(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ),
              ] else if (widget.str_tray_value == 'mission') ...[
                Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // delete
                      // print(widget.str_tray_value.toString());

                      gear_popup_22(
                        'Delete',
                        widget.str_get_goal_id.toString(),
                      );
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 20.0,
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMissionScreen(
                            str_category_id: widget.str_category_id.toString(),
                            str_goal_id: widget.str_get_goal_id.toString(),
                            str_edit_status: '1',
                            str_deadline: widget.str_due_date.toString(),
                            str_mission_text: widget.str_get_about_goal,
                            str_mission_id: widget.str_goal_cat_id.toString(),
                            str_navigation_title: 'Add Mission',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              func_push_from_floating_button();
            },
            backgroundColor: navigation_color,
            child: const Icon(Icons.add),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              // tab 1
              if (str_show_ui == 'sub_goal')
                sub_goals_list_UI()
              else if (str_show_ui == 'tasks')
                task_in_team_UI(context)
              else if (str_show_ui == 'mission')
                mission_list_UI()
              else if (str_show_ui == 'quest')
                quest_list_UI()
              else
                tab_1_info_UI(context),

              // tab 2
              if (str_show_ui == 'sub_goal')
                sub_goals_list_UI()
              else if (str_show_ui == 'tasks')
                task_in_team_UI(context)
              else if (str_show_ui == 'mission')
                mission_list_UI()
              else if (str_show_ui == 'quest')
                quest_list_UI()
              else
                tab_2_notes_UI(),

              // tab 3
              if (str_show_ui == 'sub_goal')
                sub_goals_list_UI()
              else if (str_show_ui == 'tasks')
                task_in_team_UI(context)
              else if (str_show_ui == 'mission')
                mission_list_UI()
              else if (str_show_ui == 'quest')
                quest_list_UI()
              else
                tab_3_quotes_UI(),

              // tab 4
              if (str_show_ui == 'sub_goal')
                sub_goals_list_UI()
              else if (str_show_ui == 'tasks')
                task_in_team_UI(context)
              else if (str_show_ui == 'mission')
                mission_list_UI()
              else if (str_show_ui == 'quest')
                quest_list_UI()
              else
                tab_4_team_UI(),

              // tab 5
              if (str_show_ui == 'sub_goal')
                sub_goals_list_UI()
              else if (str_show_ui == 'tasks')
                task_in_team_UI(context)
              else if (str_show_ui == 'mission')
                mission_list_UI()
              else if (str_show_ui == 'quest')
                quest_list_UI()
              else if (str_show_ui == 'add_reward')
                tab_5_add_reward_UI(context)
              else
                reward_list_UI(),

              // tab 6
              if (str_show_ui == 'sub_goal')
                sub_goals_list_UI()
              else if (str_show_ui == 'tasks')
                task_in_team_UI(context)
              else if (str_show_ui == 'mission')
                mission_list_UI()
              else if (str_show_ui == 'quest')
                quest_list_UI()
              else
                // tab_5_add_reward_UI(context)
                // link_
                tab_6_link_UI(context),
            ],
          ),
        ),
      ),
    );
  }

  Column tab_6_link_UI(BuildContext context) {
    return Column(
      children: [
        //
        header_UI(context),
        //
        const SizedBox(
          height: 20,
        ),
        // (widget.str_tray_value == 'goal')

        if (widget.str_tray_value == 'goal') ...[
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Text(
                'Goal'.toUpperCase(),
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                //
                widget.str_name.toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          //
          //
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Text(
                'Sub-Goal'.toUpperCase(),
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                //
                str_sub_goal_count.toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Text(
                'Quest'.toUpperCase(),
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                //
                str_quest_count.toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Text(
                'Mission'.toUpperCase(),
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                //
                str_mission_count.toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),
        ] else if (widget.str_tray_value == 'sub_goal') ...[
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Text(
                'Goal'.toUpperCase(),
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                //
                widget.str_name.toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          //
          //
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Text(
                'Sub-Goal'.toUpperCase(),
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                //
                widget.str_name.toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Text(
                'Quest'.toUpperCase(),
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                //
                str_quest_count.toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Text(
                'Mission'.toUpperCase(),
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                //
                str_mission_count.toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),
        ]
      ],
    );
  }

  SingleChildScrollView reward_list_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          header_UI(context),
          //
          if (str_main_loader == 'reward_loader_start')
            const CustomeLoaderPopUp(
              str_custom_loader: 'please wait...',
              str_status: '3',
            )
          else if (str_main_loader == 'reward_data_empty')
            const CustomeLoaderPopUp(
              str_custom_loader: 'No Reward Added yet.',
              str_status: '4',
            )
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: arr_reward.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print('push to rewards portal');

                    /*push_to_quest_details(
                            context,
                            arr_quest_list[index]['categoryName'].toString(),
                            arr_quest_list[index]['name'].toString(),
                            arr_quest_list[index]['deadline'].toString(),
                            arr_quest_list[index]['description'].toString(),
                            arr_quest_list[index]['goalId'].toString(),
                            arr_quest_list[index]['categoryId'].toString(),
                            arr_quest_list[index]['parentName'].toString(),
                            arr_quest_list[index]['missionId'].toString());*/
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 0.0,
                        ),
                        // height: 80,
                        color: Colors.transparent,
                        child: ListTile(
                          // iconColor: Colors.pink,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loader.gif',
                              image: arr_reward[index]['image'].toString(),
                            ),
                            //  Image.network(
                            //   arr_reward[index]['image'].toString(),
                            //   height: 100.0,
                            //   width: 100.0,
                            // ),
                          ),

                          title: RichText(
                            text: TextSpan(
                              text: arr_reward[index]['reward_name'].toString(),
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' \$${arr_reward[index]['price']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Text(
                          //   //
                          //   arr_reward[index]['reward_name'].toString(),
                          //   //
                          //   style: TextStyle(
                          //     fontFamily: font_style_name,
                          //     fontSize: 18.0,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // subtitle: Text(
                          //   //
                          //   arr_reward[index]['price'].toString(),
                          //   //
                          //   style: TextStyle(
                          //     fontFamily: font_style_name,
                          //     fontSize: 14.0,
                          //     color: const Color.fromRGBO(
                          //       30,
                          //       58,
                          //       118,
                          //       1,
                          //     ),
                          //   ),
                          // ),
                          /*trailing: Container(
                            height: 40,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  25.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                //
                                '12',
                                
                                //
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),*/
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Colors.transparent,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  SingleChildScrollView tab_5_add_reward_UI(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          header_UI(context),
          //

          InkWell(
            onTap: () async {
              _showActionSheet_for_camera_gallery(context);
            },
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              // color: Colors.pinkAccent,
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
              child: Center(
                child: imageFile == null
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 180.0,
                              width: 180,
                              // color: Colors.amber,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(
                                  18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 200 - 20,
                        width: 200 - 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            fit: BoxFit.cover,
                            imageFile!,
                            height: 150.0,
                            width: 100.0,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(
              10.0,
            ),
            child: TextFormField(
              controller: cont_reward_name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(
              10.0,
            ),
            child: TextFormField(
              controller: cont_reward_price,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Price',
              ),
            ),
          ),
          (str_add_reward_loader == '0')
              ? Container(
                  margin: const EdgeInsets.all(
                    10.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                    color: Colors.transparent,
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    upload_image_to_server();
                  },
                  child: Container(
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
                        'Save and Continue',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

// tasks list
  SingleChildScrollView task_in_team_UI(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          header_UI(context),
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
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 40,
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: text_bold_style_custom(
                            //
                            '  ' + arr_task_list[i]['name'].toString(),
                            Colors.black,
                            14.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          color: Colors.transparent,
                          child: Center(
                            child: text_regular_style_custom(
                              //
                              func_difference_between_date(
                                arr_task_list[i]['due_date'].toString(),
                              ),
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                /*child: Row(
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
                            // 'hello',

                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 14.0,
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
                        ],
                      ),
                    ),
                  ],
                ),*/
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
              )
            ],
        ],
      ),
    );
  }

  SingleChildScrollView quest_list_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          header_UI(context),
          //
          if (str_main_loader == 'quest_loader_start')
            const CustomeLoaderPopUp(
              str_custom_loader: 'please wait...',
              str_status: '3',
            )
          else if (str_main_loader == 'quest_data_empty')
            const CustomeLoaderPopUp(
              str_custom_loader: 'Quest not Added yet.',
              str_status: '4',
            )
          //
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: arr_quest_list.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print('LINE NUMBER ====> 1500');
                    print(arr_quest_list[index]);

                    push_to_quest_details(
                      context,
                      arr_quest_list[index]['categoryName'].toString(),
                      arr_quest_list[index]['name'].toString(),
                      arr_quest_list[index]['deadline'].toString(),
                      arr_quest_list[index]['description'].toString(),
                      arr_quest_list[index]['questId'].toString(),
                      arr_quest_list[index]['categoryId'].toString(),
                      arr_quest_list[index]['parentName'].toString(),
                      arr_quest_list[index]['questId'].toString(),
                      arr_quest_list[index]['image'].toString(),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 0.0,
                    ),
                    height: 80,
                    color: Colors.transparent,
                    child: ListTile(
                      // iconColor: Colors.pink,
                      leading: SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                          child: Image.network(
                            arr_quest_list[index]['image'].toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // const CircleAvatar(
                      //   radius: 30,
                      //   backgroundImage: AssetImage(
                      //     'assets/images/3.png',
                      //   ),
                      // ),
                      /*
                       */
                      title: text_bold_style_custom(
                        arr_quest_list[index]['name'].toString(),
                        Colors.black,
                        14.0,
                      ),
                      subtitle: text_regular_style_custom(
                        //
                        arr_quest_list[index]['categoryName'].toString(),
                        Colors.black,
                        12.0,
                      ),
                      trailing: Container(
                        height: 40,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              25.0,
                            ),
                          ),
                        ),
                        child: Center(
                          child: text_regular_style_custom(
                            //
                            parse_days_left.func_difference_between_date(
                                arr_quest_list[index]['deadline'].toString()),
                            Colors.black,
                            12.0,
                          ),
                        ),
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

  /// ******** MISSION LIST UI **************
  /// ***************************************
  SingleChildScrollView mission_list_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          header_UI(context),
          //
          if (str_main_loader == 'mission_loader_start')
            const CustomeLoaderPopUp(
              str_custom_loader: 'please wait...',
              str_status: '3',
            )
          else if (str_main_loader == 'mission_data_empty')
            const CustomeLoaderPopUp(
              str_custom_loader: 'Mission not Added yet.',
              str_status: '4',
            )

          //
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: arr_mission_list.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    if (kDebugMode) {
                      print('push to mission portal');
                    }
                    if (kDebugMode) {
                      print('LINE NUMBER ====> 1632');
                      print(arr_mission_list[index]);
                    }

                    push_to_mission_details(
                        context,
                        arr_mission_list[index]['categoryName'].toString(),
                        arr_mission_list[index]['name'].toString(),
                        arr_mission_list[index]['deadline'].toString(),
                        arr_mission_list[index]['description'].toString(),
                        arr_mission_list[index]['missionId'].toString(),
                        arr_mission_list[index]['categoryId'].toString(),
                        arr_mission_list[index]['parentName'].toString(),
                        arr_mission_list[index]['missionId'].toString(),
                        arr_mission_list[index]['image'].toString());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 0.0,
                    ),
                    height: 80,
                    color: Colors.transparent,
                    child: ListTile(
                      // iconColor: Colors.pink,
                      leading: SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                          child: Image.network(
                            arr_mission_list[index]['image'].toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      title: Text(
                        //
                        arr_mission_list[index]['name'].toString(),
                        // 'test',
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        //
                        arr_mission_list[index]['categoryName'].toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 14.0,
                          color: const Color.fromRGBO(
                            30,
                            58,
                            118,
                            1,
                          ),
                        ),
                      ),
                      trailing: Container(
                        height: 40,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              25.0,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            //
                            parse_days_left.func_difference_between_date(
                                arr_mission_list[index]['deadline'].toString()),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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

  /// ******** SUB - GOAL LIST UI **************
  /// ***************************************
  SingleChildScrollView sub_goals_list_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          header_UI(context),
          //
          if (str_main_loader == 'sub_goal_loader_start')
            const CustomeLoaderPopUp(
              str_custom_loader: 'please wait...',
              str_status: '3',
            )
          else if (str_main_loader == 'sub_goal_data_empty')
            const CustomeLoaderPopUp(
              str_custom_loader: 'Sub-Goal not Added.',
              str_status: '4',
            )

          //
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: arr_sub_goals.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print('object');
                    // print(arr_sub_goals);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RealMainDetailsScreen(
                          str_navigation_title: 'Goal',
                          str_category_name:
                              arr_sub_goals[index]['categoryName'].toString(),
                          str_name: arr_sub_goals[index]['name'].toString(),
                          str_due_date:
                              arr_sub_goals[index]['deadline'].toString(),
                          str_get_about_goal:
                              arr_sub_goals[index]['aboutGoal'].toString(),
                          str_get_goal_id:
                              arr_sub_goals[index]['goalId'].toString(),
                          str_category_id:
                              arr_sub_goals[index]['categoryId'].toString(),
                          str_professional_type: 'Goal',
                          str_tray_value: 'sub_goal',
                          str_parent_name:
                              arr_sub_goals[index]['parentName'].toString(),
                          str_goal_cat_id:
                              arr_sub_goals[index]['goalId'].toString(),
                          str_image: arr_sub_goals[index]['image'].toString(),
                          strFromViewDetails: 'no',
                        ),
                      ),
                    );

                    /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubGoalsDetailsScreen(
                              str_get_goal_id:
                                  arr_sub_goals[index]['goalId'].toString(),
                              str_get_sub_goal_category_id:
                                  arr_sub_goals[index]['categoryId'].toString(),
                              str_get_sub_goal_category_name:
                                  arr_sub_goals[index]['categoryName']
                                      .toString(),
                              str_get_sub_goal_description:
                                  arr_sub_goals[index]['aboutGoal'].toString(),
                              str_get_sub_goal_goal_id:
                                  arr_sub_goals[index]['goalId'].toString(),
                              str_get_sub_goal_goal_name:
                                  arr_sub_goals[index]['name'].toString(),
                              str_get_sub_goal_user_name:
                                  arr_sub_goals[index]['goalId'].toString(),
                              str_deadline:
                                  arr_sub_goals[index]['deadline'].toString(),
                            ),
                          ),
                        );*/
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 0.0,
                    ),
                    height: 80,
                    color: Colors.transparent,
                    child: ListTile(
                      // iconColor: Colors.pink,
                      leading: (arr_sub_goals[index]['image'].toString() == '')
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset('assets/images/logo.png'),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loader.gif',
                                image: arr_sub_goals[index]['image'].toString(),
                              ),
                            ),
                      /*const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          'assets/images/3.png',
                        ),
                      ),*/
                      title: Text(
                        //
                        arr_sub_goals[index]['name'].toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        //
                        arr_sub_goals[index]['categoryName'].toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 14.0,
                          color: const Color.fromRGBO(
                            30,
                            58,
                            118,
                            1,
                          ),
                        ),
                      ),
                      trailing: Container(
                        height: 40,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              25.0,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            //
                            parse_days_left.func_difference_between_date(
                                arr_sub_goals[index]['deadline'].toString()),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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

  /// ******** 4 tabs with BLUE NAVIGATION **************
  /// ***************************************
  ///
// tab 4
  SingleChildScrollView tab_4_team_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          //
          header_UI(context),
          //
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
                for (var j = 0; j < arr_send_teammate_request.length; j++) ...[
                  ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                      color: Colors.yellow,
                      child: Image.network(
                        arr_send_teammate_request[j]['From_profile_picture']
                            .toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      //

                      arr_send_teammate_request[j]['To_userName'].toString(),
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
                for (var j = 0; j < arr_approve_teammate.length; j++) ...[
                  ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                      color: Colors.yellow,
                      child: Image.network(
                        arr_approve_teammate[j]['From_profile_picture']
                            .toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      //

                      arr_approve_teammate[j]['To_userName'].toString(),
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
      ),
    );
  }

  SingleChildScrollView tab_3_quotes_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          // header
          header_UI(context),
          //
          if (str_main_loader == 'quotes_loader_start')
            const CustomeLoaderPopUp(
              str_custom_loader: 'please wait...',
              str_status: '3',
            )
          else if (str_main_loader == 'quotes_data_empty')
            const CustomeLoaderPopUp(
              str_custom_loader: 'Quotes not Added Yet',
              str_status: '4',
            )
          else
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

                                gear_popup_2(
                                  arr_quotes_list[index]['name'].toString(),
                                  arr_quotes_list[index]['quoteId'].toString(),
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
      ),
    );
  }

  ///
  ///
  ///
  ///
// HEADER
  ///
  ///
  ///
  ///
  Container header_UI(BuildContext context) {
    return Container(
      // height: 280,
      width: MediaQuery.of(context).size.width,

      decoration: const BoxDecoration(
        // color: Colors.pink,
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
              InkWell(
                onTap: () {
                  print('object');
                  //
                  camera_gallery_for_profile(context);
                  //
                },
                child: imageFile_for_profile == null
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                top: 20.0,
                                left: 20.0,
                              ),
                              height: 160.0,
                              width: 160,
                              // color: Colors.amber,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(
                                  18.0,
                                ),
                              ),

                              child: (widget.str_image.toString() == '')
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child:
                                          Image.asset('assets/images/logo.png'),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/images/loader.gif',
                                        image: widget.str_image.toString(),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          left: 20.0,
                        ),
                        height: 200 - 40,
                        width: 200 - 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            fit: BoxFit.cover,
                            //
                            imageFile_for_profile!,
                            //
                            height: 150.0,
                            width: 100.0,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                      ),
                /*Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                  ),
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                ),*/
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
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Text(
                            //
                            widget.str_name.toString().toUpperCase(),
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
                              // flex: 1,
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
                                      fontSize: 10.0,
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
                                  icon: const Icon(
                                    Icons.chat,
                                  ),
                                  onPressed: () {
                                    if (kDebugMode) {
                                      print('chat click');
                                    }
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
          type_UI(context),
        ],
      ),
    );
  }

// TAB 1 INFO UI
  SingleChildScrollView tab_1_info_UI(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          header_UI(context),
          //

          Container(
            margin: const EdgeInsets.all(
              20,
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // color: Colors.grey,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(
                12.0,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Category'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      //
                      widget.str_category_name.toString(),
                      //
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                //
                //
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Action'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    (widget.str_tray_value == 'goal')
                        ? Text(
                            //
                            'Goal'.toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                            ),
                          )
                        : Text(
                            //
                            widget.str_name.toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                            ),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '  Description'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      //
                      widget.str_get_about_goal,
                      //
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          // ],
        ],
      ),
    );
  }

// TAB 2
  SingleChildScrollView tab_2_notes_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          header_UI(context),
          //
          //
          if (str_main_loader == 'notes_loader_start')
            const CustomeLoaderPopUp(
              str_custom_loader: 'please wait...',
              str_status: '3',
            )
          else if (str_main_loader == 'notes_data_empty')
            const CustomeLoaderPopUp(
              str_custom_loader: 'Note not Added Yet',
              str_status: '4',
            )
          else
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
                        arr_notes_list[index]['created'].toString(),
                        // _tabController.index.toString(),
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
                          // '2',
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
      ),
    );
  }

// ALL 4 TYPE
  Container type_UI(BuildContext context) {
    if (widget.str_tray_value == 'goal') {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(1, 27, 82, 1),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 60,
            // width: MediaQuery.of(context).size.width,
            // height: 60,
            // width: me,
            color: const Color.fromRGBO(1, 27, 82, 1),
            child: Row(
              children: <Widget>[
                Container(
                  // width: 40,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print('object 2.1');

                          get_sub_goals_list_WB();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Sub-Goal'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: font_style_name,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              //
                              str_sub_goal_count.toString(),
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
                  height: MediaQuery.of(context).size.height,
                  width: 0.25,
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    get_quest_list_WB();
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
                            'Quest'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: font_style_name,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(
                                14.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                //
                                str_quest_count.toString(),
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
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: 0.25,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          if (kDebugMode) {
                            print('LINE NUMBER ====> 2931');
                          }

                          (widget.strFromViewDetails == 'yes')
                              ? get_mission_list_WB_without_user_id()
                              : get_mission_list_WB();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Mission'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: font_style_name,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              //
                              str_mission_count.toString(),
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
                  height: MediaQuery.of(context).size.height,
                  width: 0.25,
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    (widget.strFromViewDetails == 'yes')
                        ? func_get_task_list_WB_remove_user_id()
                        : func_get_task_list_WB();
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
                            'Tasks'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: font_style_name,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(
                                14.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                //
                                str_task_count.toString(),
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
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: 0.25,
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
                          'Complete'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: font_style_name,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '0',
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
              ],
            ),
          ),
        ),
      );
    } else if (widget.str_tray_value == 'sub_goal') {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromRGBO(1, 27, 82, 1),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 60,
            color: const Color.fromRGBO(1, 27, 82, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: 0.25,
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //
                    if (kDebugMode) {
                      print('LINE NUMBER ====> 3116');
                    }
                    get_quest_list_WB();
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
                            'Quest'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: font_style_name,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(
                                14.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '0',
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
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: 0.25,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          if (kDebugMode) {
                            print('LINE NUMBER ====> 3174');
                          }

                          (widget.strFromViewDetails == 'yes')
                              ? get_mission_list_WB_without_user_id()
                              : get_mission_list_WB();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Mission'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: font_style_name,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              //
                              str_mission_count.toString(),
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
                InkWell(
                  onTap: () {
                    //
                    (widget.strFromViewDetails == 'yes')
                        ? func_get_task_list_WB_remove_user_id()
                        : func_get_task_list_WB();
                    //
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
                            'Tasks'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: font_style_name,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(
                                14.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                //
                                str_task_count.toString(),
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
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: 0.25,
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
                          'Complete'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: font_style_name,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '0',
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
              ],
            ),
          ),
        ),
      );
    } else if (widget.str_tray_value == 'mission' ||
        widget.str_tray_value == 'quest') {
      return Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(
            1,
            27,
            82,
            1,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  color: Colors.transparent,
                  child: Align(
                    child: InkWell(
                      onTap: () {
                        //
                        (widget.strFromViewDetails == 'yes')
                            ? func_get_task_list_WB_remove_user_id()
                            : func_get_task_list_WB();
                        //
                      },
                      child: Container(
                        // width: 40,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Task'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: font_style_name,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(
                                    14.0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    //
                                    str_task_count.toString(),
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
                    ),
                  ),
                ),
              ),
              Container(
                height: 20,
                width: 0.25,
                color: Colors.white,
                margin: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  color: Colors.transparent,
                  child: Align(
                    child: Container(
                      // width: 40,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Complete'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: font_style_name,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(
                                  14.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '0',
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
                ),
              )
            ],
          )

          /*SingleChildScrollView(
          // scrollDirection: neve,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(1, 27, 82, 1),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Container(
                //   height: MediaQuery.of(context).size.height,
                //   width: 0.25,
                //   color: Colors.white,
                //   margin: const EdgeInsets.only(
                //     top: 10.0,
                //     bottom: 10.0,
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    str_show_ui = 'tasks';

                    str_tab_press = 'tasks';

                    setState(() {});
                  },
                  child: Expanded(
                    child: Container(
                      // width: 40,
                      color: Colors.transparent,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Tasks'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: font_style_name,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(
                                  14.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  //
                                  str_task_count.toString(),
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
                  ),
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height,
                //   width: 0.25,
                //   color: Colors.white,
                //   margin: const EdgeInsets.only(
                //     top: 10.0,
                //     bottom: 10.0,
                //   ),
                // ),
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
                            'Complete'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: font_style_name,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(
                                14.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '0',
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
              ],
            ),
          ),
        ),*/
          );
    } else {
      return Container(
        height: 20,
        width: 20,
        color: Colors.pink,
      );
    }
  }

  /// ******************************* WEBSERVICES *************************/
  /// *********************************************************************

// NOTES
  Future func_reward_WB() async {
    print('=====> POST : REWARD LIST');

    setState(() {
      str_main_loader = 'reward_loader_start';
    });
    //
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
//       [action] => rewardlist
//     [profesionalId] => 58
//     [profesionalType] => Goal
//     [pageNo] => 1
// )

      body: jsonEncode(
        <String, String>{
          'action': 'rewardlist',
          'pageNo': '',
          'profesionalId': widget.str_get_goal_id.toString(),
          'profesionalType': widget.str_professional_type.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      arr_reward.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          // print('object');

          arr_reward.add(i);
        }

        if (arr_reward.isEmpty) {
          setState(() {
            str_main_loader = 'reward_data_empty';
          });
        } else {
          setState(() {
            str_main_loader = 'reward_loader_stop';
          });
        }
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
    print('=====> POST : NOTES 1');

    setState(() {
      str_main_loader = 'notes_loader_start';
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
          // 'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'profesionalId': widget.str_get_goal_id.toString(),
          'profesionalType': widget.str_professional_type.toString(),
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
          arr_notes_list.add(i);
        }

        if (arr_notes_list.isEmpty) {
          setState(() {
            str_main_loader = 'notes_data_empty';
          });
        } else {
          setState(() {
            str_main_loader = 'notes_loader_stop';
          });
        }
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
  Future func_quotes_WB_without_userId() async {
    print('=====> POST : QUOTES 3.0');

    setState(() {
      str_main_loader = 'quotes_loader_start';
    });

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
          // 'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'profesionalId': widget.str_get_goal_id.toString(),
          'profesionalType': widget.str_professional_type.toString(),
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

        if (arr_quotes_list.isEmpty) {
          setState(() {
            str_main_loader = 'quotes_data_empty';
          });
        } else {
          setState(() {
            str_main_loader = 'quotes_loader_stop';
          });
        }
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
    print('=====> POST : QUOTES 3.0');

    setState(() {
      str_main_loader = 'quotes_loader_start';
    });

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
          'profesionalType': widget.str_professional_type.toString(),
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

        if (arr_quotes_list.isEmpty) {
          setState(() {
            str_main_loader = 'quotes_data_empty';
          });
        } else {
          setState(() {
            str_main_loader = 'quotes_loader_stop';
          });
        }
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  func_team_list_WB() async {
    print('=====> POST : TEAM LIST');

    str_main_loader = 'team_loader_start';
    setState(() {});

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
          'mainProfesionalId': widget.str_get_goal_id.toString(),
          'mainProfesionalType': widget.str_professional_type.toString(),
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

        arr_send_teammate_request.clear();
        arr_approve_teammate.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          arr_send_teammate_request.add(get_data['data'][i]);
        }

        for (var i = 0; i < get_data['acceptData'].length; i++) {
          arr_approve_teammate.add(get_data['data'][i]);
        }

        print('count start');
        str_send_teammate_count = arr_send_teammate_request.length.toString();
        str_approved_teammate_count = arr_approve_teammate.length.toString();

        str_main_loader = 'team_loader_stop';

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

  // get sub goals
  get_sub_goals_list_WB() async {
    print('=====> POST : SUB GOAL LIST');

    str_show_ui = 'sub_goal';

    str_tab_press = 'sub_goal';

    str_main_loader = 'sub_goal_loader_start';
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
          'action': 'goallist',
          'userId': prefs.getInt('userId').toString(),
          'parentGoalId': widget.str_get_goal_id.toString(),
          'pageNo': '',
          'subGoal': '1',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print('ANY DATA FROM CART LIST ???');

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        print('YES DATA FOUND');

        arr_sub_goals.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          arr_sub_goals.add(get_data['data'][i]);
        }

        str_sub_goal_count = arr_sub_goals.length.toString();

        if (arr_sub_goals.isEmpty) {
          setState(() {
            str_main_loader = 'sub_goal_data_empty';
          });
        } else {
          setState(() {
            str_main_loader = 'sub_goal_loader_stop';
          });
        }
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

  func_get_task_list_WB_remove_user_id() async {
    if (kDebugMode) {
      print('=====> POST : TASKS LIST 2.0');
    }

    str_show_ui = 'tasks';

    str_tab_press = 'tasks';

    str_main_loader = 'tasks_loader_start';
    setState(() {});

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
          'action': 'tasklist',
          // 'userId': prefs.getInt('userId').toString(),
          'profesionalId': widget.str_get_goal_id.toString(),
          'profesionalType': widget.str_professional_type.toString(),
          'completed': '0,1,3',
          'pageNo': ''
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

        str_task_count = arr_task_list.length.toString();

        if (arr_task_list.isEmpty) {
          str_main_loader = 'tasks_data_empty';
        } else {
          str_main_loader = 'tasks_loader_stop';
        }

        setState(() {});

        // mission_info_list_WB();
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

  func_get_task_list_WB() async {
    print('=====> POST : TASKS LIST 2.0');

    str_show_ui = 'tasks';

    str_tab_press = 'tasks';

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
          'profesionalId': widget.str_get_goal_id.toString(),
          'profesionalType': widget.str_professional_type.toString(),
          'completed': '0,1,3',
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

        str_task_count = arr_task_list.length.toString();

        if (arr_task_list.isEmpty) {
          str_main_loader = 'tasks_data_empty';
        } else {
          str_main_loader = 'tasks_loader_stop';
        }

        setState(() {});

        // mission_info_list_WB();
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

  //
  func_push_from_floating_button() {
    if (kDebugMode) {
      print(str_tab_press.toString());
    }

    if (str_tab_press == '0') {
      push_to_add_sub_goal(context);
    } else if (str_tab_press == 'sub_goal') {
      push_to_add_sub_goal(context);
    } else if (str_tab_press == '1') {
      if (kDebugMode) {
        print('add note');
      }
      push_to_create_notes(context);
    } else if (str_tab_press == '2') {
      if (kDebugMode) {
        print('add quote');
      }
      add_quotes_push_via_future(context);
      //
    } else if (str_tab_press == '3') {
      if (kDebugMode) {
        print('add team');
      }
    } else if (str_tab_press == 'tasks') {
      if (kDebugMode) {
        print('add task');
      }
      push_to_create_task(context);
    } else if (str_tab_press == 'quest') {
      if (kDebugMode) {
        print('add quest');
      }

      //
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddMissionScreen(
            str_category_id: widget.str_category_id.toString(),
            str_goal_id: widget.str_get_goal_id.toString(),
            str_edit_status: '0',
            str_deadline: '',
            str_mission_text: '',
            str_mission_id: '',
            str_navigation_title: 'Add Quest',
          ),
        ),
      );
      //
    } else if (str_tab_press == 'mission') {
      if (kDebugMode) {
        print('add mission');
      }
      //
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddMissionScreen(
            str_category_id: widget.str_category_id.toString(),
            str_goal_id: widget.str_get_goal_id.toString(),
            str_edit_status: '0',
            str_deadline: '',
            str_mission_text: '',
            str_mission_id: '',
            str_navigation_title: 'Add Mission',
          ),
        ),
      );
      //
    } else if (str_tab_press == '4') {
      if (kDebugMode) {
        print('add reward');
      }

      setState(() {
        str_show_ui = 'add_reward';
      });
    }
  }

  Future<void> push_to_add_sub_goal(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSubGoalScreen(
          str_goal_id: widget.str_get_goal_id.toString(),
        ),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    if (kDebugMode) {
      print('result =====> ' + result);
    }

// back_after_add_sub_goal

    if (!mounted) return;

    // if (result)
    setState(() {});
  }

  Future<void> push_to_create_notes(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNotesInGoalScreen(
          str_profession_id: widget.str_get_goal_id.toString(),
          str_profession_type: widget.str_professional_type.toString(),
        ),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

// get_back_from_add_notes

    if (!mounted) return;

    // if (result)
    func_notes_WB();
    // setState(() {});
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotesInGoalScreen(
          str_message: str_get_message,
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

// ALERT
  // ALERT
  Future<void> gear_popup_2(
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

                    // _navigateAndDisplaySelection(context);
                    _navigateAndDisplaySelection_edit_quote(context);
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
                    // delete_goal_WB(goal_id_is);
                    delete_goal_quotes_POPUP(str_name);

                    // delete_goal_WB
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

// DELETE ALERT
  Future<void> delete_goal_quotes_POPUP(String str_title) async {
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

                    _navigateAndDisplaySelection(context);
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
                          text: ' Are you sure you want to delete this quote ?',
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
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'yes, delete',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 14.0,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                delete_goal_WB(str_get_quote_id);
              },
            ),
          ],
        );
      },
    );
  }

  delete_notes_WB(
    String note_id,
  ) async {
    print('=====> POST : DELETE NOTES');

    // str_notes_loader_status = '0';
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
    print(get_data);

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

  // delete goal
  delete_goal_WB(
    String quote_id,
  ) async {
    print('=====> POST : DELETE QUOTES');

    str_loader_title = '0';
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
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_quotes_list = [];
        //
        (widget.strFromViewDetails == 'yes')
            ? func_quotes_WB_without_userId()
            : func_quotes_WB();
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

  Future<void> push_to_create_task(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskScreen(
          str_professional_id: widget.str_get_goal_id.toString(),
          str_professional_type: widget.str_professional_type.toString(),
        ),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    if (!mounted) return;

    // team_task_loader = '0';
    setState(() {});
    (widget.strFromViewDetails == 'yes')
        ? func_get_task_list_WB_remove_user_id()
        : func_get_task_list_WB();
  }

  Future<void> _navigateAndDisplaySelection_edit_quote(
      BuildContext context) async {
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
      arr_quotes_list.clear();

      setState(() {
        (widget.strFromViewDetails == 'yes')
            ? func_quotes_WB_without_userId()
            : func_quotes_WB();
      });
    }
  }

  Future<void> add_quotes_push_via_future(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddQuotesScreen(
          str_add_quotes_main_id: widget.str_get_goal_id.toString(),
          str_profession_type: widget.str_professional_type.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_add_quotes') {
      // arr_notes_list.clear();
      // str_quotes = '0';
      setState(() {});
      if (kDebugMode) {
        print('YES I CAME FROM ADD QUOTE');
      }
      (widget.strFromViewDetails == 'yes')
          ? func_quotes_WB_without_userId()
          : func_quotes_WB();
    }
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
                  str_message,
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

    // str_task_in_team = '2';
    str_main_loader = 'tasks_loader_start';
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
        (widget.strFromViewDetails == 'yes')
            ? func_get_task_list_WB_remove_user_id()
            : func_get_task_list_WB();
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

  // get mission details
  get_quest_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : QUEST LIST');
    }

    str_show_ui = 'quest';

    str_tab_press = 'quest';

    str_main_loader = 'quest_loader_start';

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
          'action': 'questlist',
          'userId': prefs.getInt('userId').toString(),
          // 'goalId': widget.str_goal_cat_id.toString(),
          'profesionalId': widget.str_get_goal_id,
          'profesionalType': 'Goal',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        arr_quest_list.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          arr_quest_list.add(get_data['data'][i]);
        }

        str_quest_count = arr_quest_list.length.toString();
        print('total number of quest =====> $str_quest_count');

        if (arr_quest_list.isEmpty) {
          str_main_loader = 'quest_data_empty';
          setState(() {});
        } else {
          str_main_loader = 'quest_loader_stop';
          setState(() {});
        }
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

// get mission details
  get_mission_list_WB_without_user_id() async {
    if (kDebugMode) {
      print('=====> POST : MISSION LIST');
    }

    str_show_ui = 'mission';

    str_tab_press = 'mission';

    str_main_loader = 'mission_loader_start';
    setState(() {});

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      //   [action] => missionlist
      // [userId] => 2
      // [profesionalId] => 6
      // [profesionalType] => Goal
      // [pageNo] => 1

      // 'profesionalId': widget.str_get_goal_id.toString(),
      //       'profesionalType': widget.str_professional_type.toString(),

      body: jsonEncode(
        <String, String>{
          'action': 'missionlist',
          // 'userId': prefs.getInt('userId').toString(),
          'profesionalId': widget.str_get_goal_id,
          'profesionalType': 'Goal',
          'pageNo': '1'
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        arr_mission_list.clear();

        for (var i = 0; i < get_data['data'].length; i++) {
          arr_mission_list.add(get_data['data'][i]);
        }
        // str_mission_loader = '1';
        str_mission_count = arr_mission_list.length.toString();
        print('total number of mission =====> $str_mission_count');

        if (arr_mission_list.isEmpty) {
          str_main_loader = 'mission_data_empty';
        } else {
          str_main_loader = 'mission_loader_stop';
        }

        setState(() {});

        // get_quest_list_WB();
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

  // get mission details
  get_mission_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : MISSION LIST');
    }

    str_show_ui = 'mission';

    str_tab_press = 'mission';

    str_main_loader = 'mission_loader_start';
    setState(() {});

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      //   [action] => missionlist
      // [userId] => 2
      // [profesionalId] => 6
      // [profesionalType] => Goal
      // [pageNo] => 1

      // 'profesionalId': widget.str_get_goal_id.toString(),
      //       'profesionalType': widget.str_professional_type.toString(),

      body: jsonEncode(
        <String, String>{
          'action': 'missionlist',
          'userId': prefs.getInt('userId').toString(),
          'profesionalId': widget.str_get_goal_id,
          'profesionalType': 'Goal',
          'pageNo': '1'
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        arr_mission_list.clear();

        for (var i = 0; i < get_data['data'].length; i++) {
          arr_mission_list.add(get_data['data'][i]);
        }
        // str_mission_loader = '1';
        str_mission_count = arr_mission_list.length.toString();
        print('total number of mission =====> $str_mission_count');

        if (arr_mission_list.isEmpty) {
          str_main_loader = 'mission_data_empty';
        } else {
          str_main_loader = 'mission_loader_stop';
        }

        setState(() {});

        // get_quest_list_WB();
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

  // delete goal
  // ALERT
  Future<void> gear_popup_22(
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
                    print(' delete goal');

                    Navigator.pop(context);

                    // delete_notes_WB(
                    //   note_id_is,
                    // );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        // WidgetSpan(
                        //
                        // child: IconButton(
                        //   onPressed: () {
                        //     print('object');
                        //   },
                        // icon: Icon(
                        //   Icons.delete,
                        // ),
                        // ),
                        // ),
                        TextSpan(
                          text: ' Are you sure you want to delete ?',
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
                  color: Colors.white,
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
            TextButton(
              child: Text(
                'yes, delete',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();

                if (widget.str_tray_value == 'goal') {
                  delete_main_goal(
                    goal_id_is.toString(),
                  );
                } else if (widget.str_tray_value == 'sub_goal') {
                  delete_main_goal(
                    goal_id_is.toString(),
                  );
                } else if (widget.str_tray_value == 'mission') {
                  delete_mission_WB(
                    goal_id_is.toString(),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  delete_main_goal(
    String str_goal_id,
  ) async {
    print('=====> POST : GOAL LIST');

    // str_goal_loader = '0';
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
          'action': 'goaldelete',
          'userId': prefs.getInt('userId').toString(),
          'goalId': str_goal_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        Navigator.pop(context);
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

  delete_mission_WB(
    String str_goal_id,
  ) async {
    print('=====> POST : DELETE MISSION');

    // str_goal_loader = '0';
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
          'action': 'missiondelete',
          'userId': prefs.getInt('userId').toString(),
          'missionId': str_goal_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        Navigator.pop(context);
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

  void camera_gallery_for_profile(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Camera option'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.camera,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                setState(() {
                  imageFile_for_profile = File(pickedFile.path);
                });
              }
            },
            child: Text(
              'Open Camera',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.gallery,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                print('object 22.22');

                setState(() {
                  //
                  func_show_snack_bar_for_upload();
                  //
                  imageFile_for_profile = File(pickedFile.path);

                  // Goals

                  //

                  if (widget.str_tray_value == 'goal')
                    upload_info_profile_picture('Goals');
                  else if (widget.str_tray_value == 'sub_goal')
                    upload_info_profile_picture('Goals');
                  else if (widget.str_tray_value == 'quest')
                    upload_info_profile_picture('Quests');
                  else if (widget.str_tray_value == 'mission')
                    upload_info_profile_picture('Missions');
                });
              }
            },
            child: Text(
              'Open Gallery',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
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

  void _showActionSheet_for_camera_gallery(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Camera option'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.camera,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                setState(() {
                  imageFile = File(pickedFile.path);
                });
              }
            },
            child: Text(
              'Open Camera',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.gallery,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                setState(() {
                  print('object');
                  imageFile = File(pickedFile.path);
                });
              }
            },
            child: Text(
              'Open Gallery',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
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

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Goal'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMissionScreen(
                    str_category_id: widget.str_category_id.toString(),
                    str_goal_id: widget.str_get_goal_id.toString(),
                    str_edit_status: '0',
                    str_deadline: '',
                    str_mission_text: '',
                    str_mission_id: '',
                    str_navigation_title: 'Add Mission',
                  ),
                ),
              );
            },
            child: Text(
              'Add Mission',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMissionScreen(
                    str_category_id: widget.str_category_id.toString(),
                    str_goal_id: widget.str_get_goal_id.toString(),
                    str_edit_status: '0',
                    str_deadline: '',
                    str_mission_text: '',
                    str_mission_id: '',
                    str_navigation_title: 'Add Quest',
                  ),
                ),
              );
            },
            child: Text(
              'Add Quest',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
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

  Future<void> push_to_mission_details(
    BuildContext context,
    String str_mission_get_category_name,
    String str_mission_name,
    String str_mission_get_due_date,
    String str_mission_about_goal,
    String str_goal_id,
    String str_mission_category_id,
    String str_mission_parent_name,
    String str_goal_cat_id,
    String str_image,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RealMainDetailsScreen(
          str_navigation_title: 'Mission',
          str_category_name: str_mission_get_category_name.toString(),
          str_name: str_mission_name.toString(),
          str_due_date: str_mission_get_due_date.toString(),
          str_get_about_goal: str_mission_about_goal.toString(),
          str_get_goal_id: str_goal_id.toString(),
          str_category_id: str_mission_category_id.toString(),
          str_professional_type: 'Mission',
          str_tray_value: 'mission',
          str_parent_name: str_mission_parent_name.toString(),
          str_goal_cat_id: str_goal_cat_id.toString(),
          str_image: str_image.toString(),
          strFromViewDetails: widget.strFromViewDetails,
          // s
        ),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    if (!mounted) return;
    /*ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));*/

    (widget.strFromViewDetails == 'yes')
        ? get_mission_list_WB_without_user_id()
        : get_mission_list_WB();

    // setState(() {});
  }

  //

  Future<void> push_to_quest_details(
    BuildContext context,
    String str_mission_get_category_name,
    String str_mission_name,
    String str_mission_get_due_date,
    String str_mission_about_goal,
    String str_goal_id,
    String str_mission_category_id,
    String str_mission_parent_name,
    String str_goal_cat_id,
    String str_image,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RealMainDetailsScreen(
          str_navigation_title: 'Quest',
          str_category_name: str_mission_get_category_name.toString(),
          str_name: str_mission_name.toString(),
          str_due_date: str_mission_get_due_date.toString(),
          str_get_about_goal: str_mission_about_goal.toString(),
          str_get_goal_id: str_goal_id.toString(),
          str_category_id: str_mission_category_id.toString(),
          str_professional_type: 'Quest',
          str_tray_value: 'quest',
          str_parent_name: str_mission_parent_name.toString(),
          str_goal_cat_id: str_goal_cat_id.toString(),
          str_image: str_image.toString(),
          strFromViewDetails: widget.strFromViewDetails,
        ),
      ),
    );

    print('result =====> ' + result);

    if (!mounted) return;
    /*ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));*/
    if (kDebugMode) {
      print('LINE NUMBER ====> 5670');
    }
    (widget.strFromViewDetails == 'yes')
        ? get_mission_list_WB_without_user_id()
        : get_mission_list_WB();

    // setState(() {});
  }

  ///
  ///
  ///
  upload_image_to_server() async {
    str_add_reward_loader = '0';
    setState(() {});
    // var postBody = {
    //   'action': 'addreward',
    //   'userId': '42',
    //   'reward_name': 'test_reward',
    //   'price': '100',
    //   'profesionalId': widget.str_professional_type.toString(),
    //   'profesionalType': 'Goal',
    //   'image': imageFile!,
    // };

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var request =
        await http.MultipartRequest('POST', Uri.parse(application_base_url));

    request.fields['action'] = 'addreward';
    request.fields['userId'] = prefs.getInt('userId').toString();

    request.fields['reward_name'] = cont_reward_name.text.toString();
    request.fields['price'] = cont_reward_price.text.toString();
    request.fields['profesionalId'] = widget.str_get_goal_id.toString();
    request.fields['profesionalType'] = widget.str_professional_type.toString();

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile!.path,
      ),
    );

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responsedData = json.decode(responsed.body);
    print(responsedData);

    if (responsedData['status'].toString() == 'Success') {
      cont_reward_name.text = '';
      cont_reward_price.text = '';
      imageFile = null;
      str_add_reward_loader = '1';

      str_main_loader = 'reward_loader_start';
      str_show_ui = 'n.a.';
      setState(() {});
      func_reward_WB();
    }

/*
 Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
 

      body: jsonEncode(
        <String, String>{
          'action': 'rewardlist',
          'pageNo': '',
          'profesionalId': widget.str_get_goal_id.toString(),
          'profesionalType': widget.str_professional_type.toString(),
        },
      ),
*/
    /*final response = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(postBody),

      // body: jsonEncode(
      //   <String, String>{
      //     'action': 'rewardlist',
      //     'pageNo': '',
      //     'profesionalId': widget.str_get_goal_id.toString(),
      //     'profesionalType': widget.str_professional_type.toString(),
      //   },
      // ),
    );

    final responseJson = json.decode(response.body);

    print(responseJson);*/
  }

  //
  //

  mission_info_list_WB() async {
    print('=====> POST : INFO LIST');

    str_mission_info_loader = '0';
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
      // str_mission_info_loader
      body: jsonEncode(
        <String, String>{
          'action': 'missiondetail',
          'userId': prefs.getInt('userId').toString(),
          'missionId': widget.str_goal_cat_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        // arr_mission_info.clear();
        //
        /*for (Map i in get_data['data']) {
          arr_mission_info.add(i);
        }*/

        str_mission_info_loader = '1';
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

  upload_info_profile_picture(
    String str_type,
  ) async {
    str_add_reward_loader = '0';
    setState(() {});

    print('=====>');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var request =
        await http.MultipartRequest('POST', Uri.parse(application_base_url));

    request.fields['action'] = 'uploadimage';
    request.fields['userId'] = prefs.getInt('userId').toString();
    request.fields['typeId'] = widget.str_goal_cat_id.toString();

    request.fields['Type'] = str_type.toString();

    request.files.add(await http.MultipartFile.fromPath(
        'image', imageFile_for_profile!.path));
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responsedData = json.decode(responsed.body);
    print(responsedData);

    if (responsedData['status'].toString() == 'success') {
      imageFile_for_profile = null;

      print('success');

      // func_show_snack_bar_for_upload();
    }

    //
  }

  func_show_snack_bar_for_upload() {
    setState(() {});
    final snackBar = SnackBar(
      content: const Text('Hi, I am a SnackBar!'),
      backgroundColor: (Colors.black12),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //
  func_get_goal_details_WB() async {
    str_mission_info_loader = '0';
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
      // str_mission_info_loader
      body: jsonEncode(
        <String, String>{
          'action': 'goalldetails',
          'userId': prefs.getInt('userId').toString(),
          'goalId': widget.str_goal_cat_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        str_sub_goal_count = get_data['data']['totalSubGoal'].toString();
        str_task_count = get_data['data']['totalTask'].toString();
        str_quest_count = get_data['data']['totalQuest'].toString();
        str_mission_count = get_data['data']['totalMission'].toString();
        //
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

    (widget.strFromViewDetails == 'yes')
        ? func_get_task_list_WB_remove_user_id()
        : func_get_task_list_WB();
  }
}

class ActionSheetExample {}
