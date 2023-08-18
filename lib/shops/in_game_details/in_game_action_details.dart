// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/shops/show_all_in_game/show_all_in_game_images.dart';

class InGameActionDetailsScreen extends StatefulWidget {
  const InGameActionDetailsScreen({super.key, this.getAllGameData});

  final getAllGameData;

  @override
  State<InGameActionDetailsScreen> createState() =>
      _InGameActionDetailsScreenState();
}

class _InGameActionDetailsScreenState extends State<InGameActionDetailsScreen> {
  //
  //
  var str_main_loader = '0';
  //
  // var arr_goal_list = [];
  var arr_goal_list = [];
  // var arr_mission_list = [];
  var arr_mission_list = [];
  // var arr_quest_list = [];
  var arr_quest_list = [];
  //
  @override
  void initState() {
    super.initState();
    goalListWB();
  }

  // goal list
  goalListWB() async {
    if (kDebugMode) {
      print('=====> POST : GOAL LIST');
    }

    setState(() {
      str_main_loader = '0';
    });

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
          'subGoal': '2',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(get_data);
    }

    if (resposne.statusCode == 200) {
      //
      arr_goal_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arr_goal_list.add(i);
          //
        }
        //
        setState(() {
          skillList();
        });

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

  // action list
  questListWB() async {
    if (kDebugMode) {
      print('=====> POST : QUEST LIST');
    }

    setState(() {
      str_main_loader = '0';
    });

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
          'profesionalType': 'Profile',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      // print(get_data);
    }

    if (resposne.statusCode == 200) {
      //
      arr_quest_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arr_quest_list.add(i);
          //
        }
        //
        setState(() {});
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

  // product list
  skillList() async {
    if (kDebugMode) {
      print('=====> POST : MISSION LIST');
    }

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'missionlist',
          'profesionalType': 'Profile',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      // print(get_data);
    }

    if (resposne.statusCode == 200) {
      //
      arr_mission_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arr_mission_list.add(i);
          //
        }
        //
        setState(() {
          questListWB();
        });
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

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          'Actions',
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
            children: [
              //
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text_with_bold_style_black(
                        'Goal',
                      ),
                      //
                      GestureDetector(
                        onTap: () {
                          //
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ShowAllInGameImagesScreen(
                                getNumberToParse: '3',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                          child: Center(
                            child: text_regular_style_custom(
                              'View all',
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //
              // text_with_regular_style(arr_goal_list.length),
              //
              if (arr_goal_list.isEmpty) ...[
                //
                text_with_regular_style('please wait...'),
                //
              ] else if (arr_goal_list.length == 1) ...[
                //
                for (int i = 0; i < arr_goal_list.length; i++) ...[
                  actionHaveOneDataUI(i)
                ]
                //
              ] else ...[
                //
                actionHaveTwoDataUI()
                //
              ],
              //

              ///
              ///
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height: 0.2,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10.0,
              ),

              ///
              //
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text_with_bold_style_black(
                        'Missions',
                      ),
                      //
                      GestureDetector(
                        onTap: () {
                          //
                          //
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ShowAllInGameImagesScreen(
                                getNumberToParse: '4',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                          child: Center(
                            child: text_regular_style_custom(
                              'View all',
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //
              // text_with_regular_style(arr_mission_list.length),
              //
              if (arr_mission_list.isEmpty) ...[
                //
                text_with_regular_style('please wait...'),
                //
              ] else if (arr_mission_list.length == 1) ...[
                //
                for (int i = 0; i < arr_mission_list.length; i++) ...[
                  skillHaveOneDataUI(i),
                ]
                //
              ] else ...[
                //
                skillHaveMultipleDataUI(),
                //
              ],

              ///
              ///
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height: 0.2,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10.0,
              ),

              ///
              //
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text_with_bold_style_black(
                        'Quests',
                      ),
                      //
                      GestureDetector(
                        onTap: () {
                          //
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ShowAllInGameImagesScreen(
                                getNumberToParse: '5',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                          child: Center(
                            child: text_regular_style_custom(
                              'View all',
                              Colors.black,
                              14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //
              // text_with_regular_style(arr_quest_list.length),
              //
              //
              if (arr_quest_list.isEmpty) ...[
                //
                text_with_regular_style('please wait...'),
                //
              ] else if (arr_quest_list.length == 1) ...[
                //
                productSingleDataUI(),
                //
              ] else ...[
                //
                productMultipleDataUI(),
                //
              ],
              //

              const SizedBox(
                height: 20.0,
              ),
            ],
          )),
    );
  }

  //
  Padding productMultipleDataUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(width: 0.4),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Image.network(
                          //
                          arr_quest_list[0]['image'].toString(),
                          fit: BoxFit.cover,
                          //
                        ),
                      ),
                    ),
                  ),
                  //
                  Align(
                    alignment: Alignment.center,
                    child: text_regular_style_custom(
                      //
                      arr_quest_list[0]['name'].toString(),
                      //
                      Colors.black,
                      16.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: text_bold_style_custom(
                      //
                      '\$${arr_quest_list[0]['price']}',
                      //
                      Colors.black,
                      14.0,
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //
          const SizedBox(
            width: 12.0,
          ),
          //
          Expanded(
            child: Container(
              height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 0.4),
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Image.network(
                          //
                          arr_quest_list[1]['image'].toString(),
                          fit: BoxFit.cover,
                          //
                        ),
                      ),
                    ),
                  ),
                  //
                  Align(
                    alignment: Alignment.center,
                    child: text_regular_style_custom(
                      //
                      arr_quest_list[1]['name'].toString(),
                      //
                      Colors.black,
                      16.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: text_bold_style_custom(
                      //
                      '\$${arr_quest_list[1]['price']}',
                      //
                      Colors.black,
                      14.0,
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //
        ],
      ),
    );
  }

  Padding productSingleDataUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(width: 0.4),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Image.network(
                          //
                          arr_quest_list[0]['image'].toString(),
                          fit: BoxFit.cover,
                          //
                        ),
                      ),
                    ),
                  ),
                  //
                  Align(
                    alignment: Alignment.center,
                    child: text_regular_style_custom(
                      //
                      arr_quest_list[0]['name'].toString(),
                      //
                      Colors.black,
                      16.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: text_bold_style_custom(
                      //
                      '\$${arr_quest_list[0]['price']}',
                      //
                      Colors.black,
                      14.0,
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //
          const SizedBox(
            width: 12.0,
          ),

          //
        ],
      ),
    );
  }

  Padding skillHaveMultipleDataUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(width: 0.4),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Image.network(
                          //
                          arr_mission_list[0]['image'].toString(),
                          fit: BoxFit.cover,
                          //
                        ),
                      ),
                    ),
                  ),
                  //
                  Align(
                    alignment: Alignment.center,
                    child: text_regular_style_custom(
                      //
                      arr_mission_list[0]['name'].toString(),
                      //
                      Colors.black,
                      16.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: text_bold_style_custom(
                      //
                      '\$${arr_mission_list[0]['price'].toString()}',
                      //
                      Colors.black,
                      14.0,
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //
          const SizedBox(
            width: 12.0,
          ),

          //
          Expanded(
            child: Container(
              height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(width: 0.4),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Image.network(
                          //
                          arr_mission_list[1]['image'].toString(),
                          fit: BoxFit.cover,
                          //
                        ),
                      ),
                    ),
                  ),
                  //
                  Align(
                    alignment: Alignment.center,
                    child: text_regular_style_custom(
                      //
                      arr_mission_list[1]['name'].toString(),
                      //
                      Colors.black,
                      16.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: text_bold_style_custom(
                      //
                      '\$${arr_mission_list[1]['price'].toString()}',
                      //
                      Colors.black,
                      14.0,
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding skillHaveOneDataUI(int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(width: 0.4),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Image.network(
                          //
                          arr_mission_list[i]['image'].toString(),
                          fit: BoxFit.cover,
                          //
                        ),
                      ),
                    ),
                  ),
                  //
                  Align(
                    alignment: Alignment.center,
                    child: text_regular_style_custom(
                      //
                      arr_mission_list[i]['name'].toString(),
                      //
                      Colors.black,
                      16.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: text_bold_style_custom(
                      //
                      '\$${arr_mission_list[i]['price']}',
                      //
                      Colors.black,
                      14.0,
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //
          const SizedBox(
            width: 12.0,
          ),

          //
        ],
      ),
    );
  }

  Padding actionHaveTwoDataUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(width: 0.4),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Image.network(
                          //
                          arr_goal_list[0]['image'].toString(),
                          fit: BoxFit.cover,
                          //
                        ),
                      ),
                    ),
                  ),
                  //
                  Align(
                    alignment: Alignment.center,
                    child: text_regular_style_custom(
                      //
                      arr_goal_list[0]['name'],
                      //
                      Colors.black,
                      16.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: text_bold_style_custom(
                      //
                      '\$${arr_goal_list[0]['price']}',
                      //
                      Colors.black,
                      14.0,
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //
          const SizedBox(
            width: 12.0,
          ),
          //
          Expanded(
            child: Container(
              height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(width: 0.4),
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Image.network(
                          //
                          arr_goal_list[1]['image'].toString(),
                          fit: BoxFit.cover,
                          //
                        ),
                      ),
                    ),
                  ),
                  //
                  Align(
                    alignment: Alignment.center,
                    child: text_regular_style_custom(
                      //
                      arr_goal_list[1]['name'],
                      //
                      Colors.black,
                      16.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: text_bold_style_custom(
                      //
                      '\$${arr_goal_list[1]['price']}',
                      //
                      Colors.black,
                      14.0,
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //
        ],
      ),
    );
  }

  Padding actionHaveOneDataUI(i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 200,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(width: 0.4),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Image.network(
                          //
                          arr_goal_list[i]['image'].toString(),
                          fit: BoxFit.cover,
                          //
                        ),
                      ),
                    ),
                  ),
                  //
                  Align(
                    alignment: Alignment.center,
                    child: text_regular_style_custom(
                      //
                      arr_goal_list[1]['name'],
                      //
                      Colors.black,
                      16.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: text_bold_style_custom(
                      //
                      arr_goal_list[i]['price'].toString(),
                      //
                      Colors.black,
                      14.0,
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          //

          //
        ],
      ),
    );
  }
}
