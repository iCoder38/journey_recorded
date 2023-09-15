// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/real_main_details/real_main_details.dart';
import 'package:journey_recorded/single_classes/single_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopAllViewDetailsScreen extends StatefulWidget {
  const ShopAllViewDetailsScreen({super.key, this.getFullDataInViewDetails});

  final getFullDataInViewDetails;

  @override
  State<ShopAllViewDetailsScreen> createState() =>
      _ShopAllViewDetailsScreenState();
}

class _ShopAllViewDetailsScreenState extends State<ShopAllViewDetailsScreen>
    with SingleTickerProviderStateMixin {
  //
  final GetDifferenceBetweenDate parseDayLeft = GetDifferenceBetweenDate();
  late TabController _tabController;
  //
  var strScreenLoader = '0';
  // var arrSubGoal = [];
  var arrAllDetails = [];
  //
  var strUserClickWhichPanel = '1';
  @override
  void initState() {
    //
    if (kDebugMode) {
      print('============= VIEW DETAILS ==============');
      print(widget.getFullDataInViewDetails);
      print('=========================================');
    }
    _tabController = TabController(vsync: this, length: 6);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: text_bold_style_custom(
            'View Details',
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
        body: Column(
          children: [
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: navigation_color,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    (strUserClickWhichPanel == '1')
                        ? GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strUserClickWhichPanel = '1';
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              color: Colors.transparent,
                              child: Center(
                                child: text_bold_style_custom(
                                  'INFO',
                                  Colors.white,
                                  18.0,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strUserClickWhichPanel = '1';
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              color: Colors.transparent,
                              child: Center(
                                child: text_regular_style_custom(
                                  'INFO',
                                  Colors.white,
                                  14.0,
                                ),
                              ),
                            ),
                          ),
                    /***********************************************/
                    /***********************************************/
                    (strUserClickWhichPanel == '2')
                        ? GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strUserClickWhichPanel = '2';
                                //
                                strScreenLoader = '0';
                                funcGetSubGoal();
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 120,
                              color: Colors.transparent,
                              child: Center(
                                child: text_bold_style_custom(
                                  'SUB GOAL',
                                  Colors.white,
                                  18.0,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strUserClickWhichPanel = '2';
                                //
                                strScreenLoader = '0';
                                funcGetSubGoal();
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              color: Colors.transparent,
                              child: Center(
                                child: text_regular_style_custom(
                                  'SUB GOAL',
                                  Colors.white,
                                  14.0,
                                ),
                              ),
                            ),
                          ),
                    /***********************************************/
                    /***********************************************/
                    (strUserClickWhichPanel == '3')
                        ? GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strUserClickWhichPanel = '3'; //
                                strScreenLoader = '0';
                                funcQuestWB();
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              color: Colors.transparent,
                              child: Center(
                                child: text_bold_style_custom(
                                  'QUESTS',
                                  Colors.white,
                                  18.0,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strUserClickWhichPanel = '3'; //
                                strScreenLoader = '0';
                                funcQuestWB();
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              color: Colors.transparent,
                              child: Center(
                                child: text_regular_style_custom(
                                  'QUESTS',
                                  Colors.white,
                                  14.0,
                                ),
                              ),
                            ),
                          ),
                    /***********************************************/
                    /***********************************************/
                    (strUserClickWhichPanel == '4')
                        ? GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strUserClickWhichPanel = '4'; //
                                strScreenLoader = '0';
                                funcMissionWB();
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              color: Colors.transparent,
                              child: Center(
                                child: text_bold_style_custom(
                                  'MISSIONS',
                                  Colors.white,
                                  18.0,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strUserClickWhichPanel = '4'; //
                                strScreenLoader = '0';
                                funcMissionWB();
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              color: Colors.transparent,
                              child: Center(
                                child: text_regular_style_custom(
                                  'MISSIONS',
                                  Colors.white,
                                  14.0,
                                ),
                              ),
                            ),
                          ),
                    /***********************************************/
                    /***********************************************/
                    (strUserClickWhichPanel == '5')
                        ? GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strUserClickWhichPanel = '5'; //
                                strScreenLoader = '0';
                                funcTasksWB();
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 120,
                              color: Colors.transparent,
                              child: Center(
                                child: text_bold_style_custom(
                                  'TASK',
                                  Colors.white,
                                  18.0,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strUserClickWhichPanel = '5'; //
                                strScreenLoader = '0';
                                funcTasksWB();
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              color: Colors.transparent,
                              child: Center(
                                child: text_regular_style_custom(
                                  'TASK',
                                  Colors.white,
                                  14.0,
                                ),
                              ),
                            ),
                          ),
                    /***********************************************/
                    /***********************************************/
                    (strUserClickWhichPanel == '6')
                        ? GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strUserClickWhichPanel = '6'; //
                                strScreenLoader = '0';
                                funcRewardsWB();
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 120,
                              color: Colors.transparent,
                              child: Center(
                                child: text_bold_style_custom(
                                  'REWARDS',
                                  Colors.white,
                                  18.0,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strUserClickWhichPanel = '6'; //
                                strScreenLoader = '0';
                                funcRewardsWB();
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              color: Colors.transparent,
                              child: Center(
                                child: text_regular_style_custom(
                                  'REWARDS',
                                  Colors.white,
                                  14.0,
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
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      //
                      headerUI(context),
                      //
                      if (strUserClickWhichPanel == '1') ...[
                        //
                        tabOneInfoUI(context),
                      ] else if (strUserClickWhichPanel == '2') ...[
                        //
                        if (strScreenLoader == '0') ...[
                          const Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ] else ...[
                          //
                          tabTwpSubGoalUI(context),
                        ],
                      ] else if (strUserClickWhichPanel == '3') ...[
                        //
                        if (strScreenLoader == '0') ...[
                          const Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ] else ...[
                          //
                          tabThreeQuotesUI(context),
                        ],
                      ] else if (strUserClickWhichPanel == '4') ...[
                        //
                        if (strScreenLoader == '0') ...[
                          const Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ] else ...[
                          //
                          tabFourMissionUI(context),
                        ],
                      ] else if (strUserClickWhichPanel == '5') ...[
                        //
                        if (strScreenLoader == '0') ...[
                          const Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ] else ...[
                          //
                          tabFiveTaskUI(context),
                        ],
                      ] else if (strUserClickWhichPanel == '6') ...[
                        //
                        if (strScreenLoader == '0') ...[
                          const Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ] else ...[
                          //
                          tabSixRewardsUI(context),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            )
          ],
        )
        /*TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          // tab 1
          tabOneInfoUI(context),
          // tabTwpSubGoalUI(context),
          // tabThreeQuotesUI(context),
          // tabFourMissionUI(context),
          // tabFourMissionUI(context),
          // tabTwpSubGoalUI(context)
          // tabOneInfoUI(context),
          /*tabTwpSubGoalUI(context),
          tabThreeQuotesUI(context),
          tabFourMissionUI(context),
          tabFiveTaskUI(context),
          tabSixRewardsUI(context)*/
          // tab 2
          (strScreenLoader == '0')
              ? const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                )
              : tabTwpSubGoalUI(context),
          // tab 3 quotes
          (strScreenLoader == '0')
              ? const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                )
              : tabThreeQuotesUI(context),
          // tab 4 missions
          (strScreenLoader == '0')
              ? const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                )
              : tabFourMissionUI(context),
          // tab 5
          (strScreenLoader == '0')
              ? const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListTile(
                  title: text_regular_style_custom(
                    //
                    arrAllDetails[0]['name'].toString(),
                    Colors.black,
                    14.0,
                  ),
                ),
          // tab 6
          (strScreenLoader == '0')
              ? const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                )
              : tabSixRewardsUI(context),
        ],
      ),*/
        );
  }

  Column tabFiveTaskUI(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < arrAllDetails.length; i++) ...[
          ListTile(
            title: text_regular_style_custom(
              //
              arrAllDetails[i]['name'].toString(),
              Colors.black,
              14.0,
            ),
            trailing: (parseDayLeft.func_difference_between_date(
                        arrAllDetails[i]['due_date'].toString()) ==
                    'overdue')
                ? Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_style_custom(
                        'overdue',
                        Colors.black,
                        14.0,
                      ),
                    ),
                  )
                : Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                    child: Center(
                      child: text_bold_style_custom(
                        parseDayLeft.func_difference_between_date(
                            arrAllDetails[i]['due_date'].toString()),
                        Colors.black,
                        12.0,
                      ),
                    ),
                  ),
          ),
          //
          Container(
            height: 0.4,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
        ],
      ],
    );
  }

  ///
  ///
  Container headerUI(BuildContext context) {
    return Container(
      // height: 180,
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
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(
                      width: 4.0,
                      color: Colors.white,
                    ),
                  ),
                  child: Image.network(
                    widget.getFullDataInViewDetails['image'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: text_bold_style_custom(
                          //
                          widget.getFullDataInViewDetails['name'].toString(),
                          Colors.white,
                          18.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 6.0,
                              left: 2.0,
                            ),
                            height: 40,
                            width: 120,
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
                            child: (parseDayLeft.func_difference_between_date(
                                        widget.getFullDataInViewDetails[
                                                'deadline']
                                            .toString()) ==
                                    'overdue')
                                ? Center(
                                    child: text_regular_style_custom(
                                      'overdue',
                                      Colors.black,
                                      14.0,
                                    ),
                                  )
                                : Center(
                                    child: text_regular_style_custom(
                                      parseDayLeft.func_difference_between_date(
                                          widget.getFullDataInViewDetails[
                                                  'deadline']
                                              .toString()),
                                      Colors.black,
                                      12.0,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column tabSixRewardsUI(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < arrAllDetails.length; i++) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: text_regular_style_custom(
                //
                arrAllDetails[i]['name'].toString(),
                Colors.black,
                14.0,
              ),
              leading: Container(
                height: 60,
                width: 60,
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    40.0,
                  ),
                  child: (widget.getFullDataInViewDetails['image'].toString() ==
                          '')
                      ? SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.network(
                          //
                          arrAllDetails[i]['image'].toString(),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              trailing: (parseDayLeft.func_difference_between_date(
                          arrAllDetails[i]['deadline'].toString()) ==
                      'overdue')
                  ? text_regular_style_custom(
                      'overdue',
                      Colors.black,
                      14.0,
                    )
                  : text_regular_style_custom(
                      parseDayLeft.func_difference_between_date(
                          arrAllDetails[i]['deadline'].toString()),
                      Colors.black,
                      14.0,
                    ),
            ),
          ),
          //
          Container(
            height: 0.4,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
        ],
      ],
    );
  }

  Column tabFourMissionUI(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < arrAllDetails.length; i++) ...[
          GestureDetector(
            onTap: () {
              //
              if (kDebugMode) {
                print('========================');
                print('====== GOAL ID ========');
                print(arrAllDetails[i]['goalId'].toString());
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RealMainDetailsScreen(
                    str_navigation_title: 'Mission',
                    str_category_name:
                        arrAllDetails[i]['categoryName'].toString(),
                    str_name: arrAllDetails[i]['name'].toString(),
                    str_due_date: arrAllDetails[i]['deadline'].toString(),
                    str_get_about_goal:
                        arrAllDetails[i]['description'].toString(),
                    str_get_goal_id:
                        widget.getFullDataInViewDetails['goalId'].toString(),
                    str_category_id: arrAllDetails[i]['categoryId'].toString(),
                    str_professional_type: 'Mission',
                    str_tray_value: 'mission',
                    str_parent_name: arrAllDetails[i]['parentName'].toString(),
                    str_goal_cat_id: arrAllDetails[i]['missionId'].toString(),
                    str_image: arrAllDetails[i]['image'].toString(),
                    strFromViewDetails: 'yes',
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: text_regular_style_custom(
                  //
                  arrAllDetails[i]['name'].toString(),
                  Colors.black,
                  14.0,
                ),
                leading: Container(
                  height: 60,
                  width: 60,
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      40.0,
                    ),
                    child:
                        (widget.getFullDataInViewDetails['image'].toString() ==
                                '')
                            ? SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.network(
                                //
                                arrAllDetails[i]['image'].toString(),
                                fit: BoxFit.cover,
                              ),
                  ),
                ),
                trailing: (parseDayLeft.func_difference_between_date(
                            arrAllDetails[i]['deadline'].toString()) ==
                        'overdue')
                    ? Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                        child: Center(
                          child: text_bold_style_custom(
                            'overdue',
                            Colors.black,
                            14.0,
                          ),
                        ),
                      )
                    : Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                        child: Center(
                          child: text_bold_style_custom(
                            parseDayLeft.func_difference_between_date(
                                arrAllDetails[i]['deadline'].toString()),
                            Colors.black,
                            12.0,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          //
          Container(
            height: 0.4,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
        ],
      ],
    );
  }

  Column tabThreeQuotesUI(BuildContext context) {
    return Column(
      children: [
        /*
        arr_quest_list[index]['categoryName'].toString(),
                        arr_quest_list[index]['name'].toString(),
                        arr_quest_list[index]['deadline'].toString(),
                        arr_quest_list[index]['description'].toString(),
                        arr_quest_list[index]['goalId'].toString(),
                        arr_quest_list[index]['categoryId'].toString(),
                        arr_quest_list[index]['parentName'].toString(),
                        arr_quest_list[index]['questId'].toString(),
                        arr_quest_list[index]['image'].toString(),
        */
        for (int i = 0; i < arrAllDetails.length; i++) ...[
          GestureDetector(
            onTap: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RealMainDetailsScreen(
                    str_navigation_title: 'Quest',
                    str_category_name:
                        arrAllDetails[i]['categoryName'].toString(),
                    str_name: arrAllDetails[i]['name'].toString(),
                    str_due_date: arrAllDetails[i]['deadline'].toString(),
                    str_get_about_goal:
                        arrAllDetails[i]['description'].toString(),
                    str_get_goal_id: arrAllDetails[i]['goalId'].toString(),
                    str_category_id: arrAllDetails[i]['categoryId'].toString(),
                    str_professional_type: 'Quest',
                    str_tray_value: 'quest',
                    str_parent_name: arrAllDetails[i]['parentName'].toString(),
                    str_goal_cat_id: arrAllDetails[i]['questId'].toString(),
                    str_image: arrAllDetails[i]['image'].toString(),
                    strFromViewDetails: 'yes',
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: text_regular_style_custom(
                  //
                  arrAllDetails[i]['name'].toString(),
                  Colors.black,
                  14.0,
                ),
                leading: Container(
                  height: 60,
                  width: 60,
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      40.0,
                    ),
                    child:
                        (widget.getFullDataInViewDetails['image'].toString() ==
                                '')
                            ? SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.network(
                                //
                                arrAllDetails[i]['image'].toString(),
                                fit: BoxFit.cover,
                              ),
                  ),
                ),
                trailing: (parseDayLeft.func_difference_between_date(
                            arrAllDetails[i]['deadline'].toString()) ==
                        'overdue')
                    ? Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                        child: Center(
                          child: text_bold_style_custom(
                            'overdue',
                            Colors.black,
                            14.0,
                          ),
                        ),
                      )
                    : Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                        child: Center(
                          child: text_bold_style_custom(
                            parseDayLeft.func_difference_between_date(
                                arrAllDetails[i]['deadline'].toString()),
                            Colors.black,
                            12.0,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          //
          Container(
            height: 0.4,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
        ],
      ],
    );
  }

  Column tabTwpSubGoalUI(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < arrAllDetails.length; i++) ...[
          GestureDetector(
            onTap: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RealMainDetailsScreen(
                    str_navigation_title: 'Goal',
                    str_category_name:
                        arrAllDetails[i]['categoryName'].toString(),
                    str_name: arrAllDetails[i]['name'].toString(),
                    str_due_date: arrAllDetails[i]['deadline'].toString(),
                    str_get_about_goal:
                        arrAllDetails[i]['aboutGoal'].toString(),
                    str_get_goal_id: arrAllDetails[i]['goalId'].toString(),
                    str_category_id: arrAllDetails[i]['categoryId'].toString(),
                    str_professional_type: 'Goal',
                    str_tray_value: 'sub_goal',
                    str_parent_name: arrAllDetails[i]['parentName'].toString(),
                    str_goal_cat_id: arrAllDetails[i]['goalId'].toString(),
                    str_image: arrAllDetails[i]['image'].toString(),
                    strFromViewDetails: 'yes',
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: text_regular_style_custom(
                  //
                  arrAllDetails[i]['name'].toString(),
                  Colors.black,
                  14.0,
                ),
                leading: Container(
                  height: 60,
                  width: 60,
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      40.0,
                    ),
                    child:
                        (widget.getFullDataInViewDetails['image'].toString() ==
                                '')
                            ? SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.network(
                                //
                                arrAllDetails[i]['image'].toString(),
                                fit: BoxFit.cover,
                              ),
                  ),
                ),
                trailing: (parseDayLeft.func_difference_between_date(
                            arrAllDetails[i]['deadline'].toString()) ==
                        'overdue')
                    ? Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                        child: Center(
                          child: text_bold_style_custom(
                            'overdue',
                            Colors.black,
                            14.0,
                          ),
                        ),
                      )
                    : Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                        child: Center(
                          child: text_bold_style_custom(
                            parseDayLeft.func_difference_between_date(
                                arrAllDetails[i]['deadline'].toString()),
                            Colors.black,
                            12.0,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          //
          Container(
            height: 0.4,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
          ),
        ],
      ],
    );
  }

  Column tabOneInfoUI(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            // height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.2),
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 6.0,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      text_bold_style_custom(
                        'CATEGORY',
                        Colors.black,
                        14.0,
                      ),
                      //
                      text_regular_style_custom(
                        //
                        widget.getFullDataInViewDetails['categoryName']
                            .toString(),
                        //
                        Colors.black,
                        12.0,
                      ),
                    ],
                  ),
                  //
                  const SizedBox(
                    height: 10,
                  ),
                  //
                  Container(
                    height: 0.4,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                  ),
                  //
                  const SizedBox(
                    height: 10,
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      text_bold_style_custom(
                        'ACTIONS',
                        Colors.black,
                        14.0,
                      ),
                      //
                      text_regular_style_custom(
                        'GOAL',
                        Colors.black,
                        12.0,
                      ),
                    ],
                  ),
                  //
                  const SizedBox(
                    height: 10,
                  ),
                  //
                  Container(
                    height: 0.4,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                  ),
                  //
                  //
                  const SizedBox(
                    height: 10,
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      text_bold_style_custom(
                        'DESCRIPTION',
                        Colors.black,
                        14.0,
                      ),
                    ],
                  ),
                  //
                  const SizedBox(
                    height: 10,
                  ),
                  //
                  //
                  Align(
                    alignment: Alignment.centerLeft,
                    child: text_regular_style_custom(
                      //
                      widget.getFullDataInViewDetails['aboutGoal'].toString(),
                      //
                      Colors.black,
                      12.0,
                    ),
                  ),

                  //
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

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
  ///WB
  funcGetSubGoal() async {
    if (kDebugMode) {
      print('=====> POST : GET SUB GOAL');
    }

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
          'action': 'goallist',
          'parentGoalId': widget.getFullDataInViewDetails['goalId'].toString(),
          'subGoal': '1',
          'pageNo': '1',
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      // print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        //
        arrAllDetails.clear();
        for (Map i in getData['data']) {
          arrAllDetails.add(i);
        }
        //
        if (kDebugMode) {
          print(arrAllDetails);
          print(arrAllDetails.length);
        }
        setState(() {
          strScreenLoader = '1';
        });
        //
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

  //
  funcQuestWB() async {
    if (kDebugMode) {
      print('=====> POST : GET QUEST');
    }

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
          'action': 'questlist',
          'profesionalId': widget.getFullDataInViewDetails['goalId'].toString(),
          'profesionalType': 'Goal',
          'pageNo': '1',
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      // print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        //
        arrAllDetails.clear();
        for (Map i in getData['data']) {
          arrAllDetails.add(i);
        }
        //
        if (kDebugMode) {
          print(arrAllDetails);
          print(arrAllDetails.length);
        }
        setState(() {
          strScreenLoader = '1';
        });
        //
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

  //
  funcMissionWB() async {
    if (kDebugMode) {
      print('=====> POST : GET MISSION');
    }

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
          'action': 'missionlist',
          'profesionalId': widget.getFullDataInViewDetails['goalId'].toString(),
          'profesionalType': 'Goal',
          'pageNo': '1',
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      // print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        //
        arrAllDetails.clear();
        for (Map i in getData['data']) {
          arrAllDetails.add(i);
        }
        //
        if (kDebugMode) {
          print(arrAllDetails.length);
          print(arrAllDetails);
        }
        setState(() {
          strScreenLoader = '1';
        });
        //
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

  //
  funcTasksWB() async {
    if (kDebugMode) {
      print('=====> POST : GET TASK');
    }

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
          'action': 'tasklist',
          'profesionalId': widget.getFullDataInViewDetails['goalId'].toString(),
          'profesionalType': 'Goal',
          'pageNo': '1',
          'completed': '0,1,3',
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      // print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        //
        arrAllDetails.clear();
        for (Map i in getData['data']) {
          arrAllDetails.add(i);
        }
        //
        if (kDebugMode) {
          print(arrAllDetails.length);
          print(arrAllDetails);
          // print(arrAllDetails['data']);
        }
        setState(() {
          strScreenLoader = '1';
        });
        //
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

  //
  funcRewardsWB() async {
    if (kDebugMode) {
      print('=====> POST : GET REWARDS');
    }

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
          'action': 'tasklistnew',
          'profesionalId': widget.getFullDataInViewDetails['goalId'].toString(),
          'profesionalType': 'Goal',
          'pageNo': '1',
          'userId': prefs.getInt('userId').toString(),
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        //
        arrAllDetails.clear();
        for (Map i in getData['data']) {
          arrAllDetails.add(i);
        }
        //
        if (kDebugMode) {
          // print(arrAllDetails.length);
          // print(arrAllDetails);
          // print(arrAllDetails['data']);
        }
        setState(() {
          strScreenLoader = '1';
        });
        //
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
}
