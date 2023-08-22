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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.lime,
          isScrollable: true,
          tabs: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: text_regular_style_custom(
                'INFO',
                Colors.white,
                14.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: text_regular_style_custom(
                'SUB GOAL',
                Colors.white,
                14.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: text_regular_style_custom(
                'QUOTES',
                Colors.white,
                14.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: text_regular_style_custom(
                'MISSIONS',
                Colors.white,
                14.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: text_regular_style_custom(
                'TASKS',
                Colors.white,
                14.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: text_regular_style_custom(
                'REWARDS',
                Colors.white,
                14.0,
              ),
            ),
          ],
          onTap: (value) {
            if (kDebugMode) {
              print('tab id ====> $value');
            }
            //
            if (value == 0) {
              //
            } else if (value == 1) {
              //
              setState(() {
                strScreenLoader = '0';
              });

              funcGetSubGoal();
            } else if (value == 2) {
              //
              setState(() {
                strScreenLoader = '0';
              });

              funcQuestWB();
            } else if (value == 3) {
              // mission
              //
              setState(() {
                strScreenLoader = '0';
              });

              funcMissionWB();
            } else if (value == 4) {
              //
              setState(() {
                strScreenLoader = '0';
              });

              // funcTasksWB();
            } else if (value == 5) {
              setState(() {
                strScreenLoader = '0';
              });
              funcRewardsWB();
            }
          },
        ),
      ),
      body: TabBarView(
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
      ),
    );
  }

  Column tabFiveTaskUI(BuildContext context) {
    return Column(
      children: [
        // for (int i = 0; i < arrAllDetails.length; i++) ...[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: text_regular_style_custom(
              //
              arrAllDetails[0]['name'].toString(),
              Colors.black,
              14.0,
            ),
            /*leading: Container(
                          height: 60,
                          width: 60,
                          color: Colors.transparent,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              40.0,
                            ),
                            child: (widget.getFullDataInViewDetails['image']
                                        .toString() ==
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
                        ),*/
            /*trailing: (parseDayLeft.func_difference_between_date(
                                    arrAllDetails[i]['due_date']
                                        .toString()) ==
                                'overdue')
                            ? text_regular_style_custom(
                                'overdue',
                                Colors.black,
                                14.0,
                              )
                            : text_regular_style_custom(
                                parseDayLeft.func_difference_between_date(
                                    arrAllDetails[i]['due_date'].toString()),
                                Colors.black,
                                14.0,
                              ),*/
          ),
        ),
        //
        Container(
          height: 0.4,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
        ),
        //  ],
      ],
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
