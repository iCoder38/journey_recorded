// ignore_for_file: non_constant_identifier_names, unused_element

import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
// import 'package:journey_recorded/custom_files/drawer.dart';
import 'package:journey_recorded/goals/add_goals/add_goals.dart';
// import 'package:journey_recorded/goals/goals_details/goals_details.dart';
// import 'package:journey_recorded/quotes/add_quotes/add_quotes.dart';
import 'package:journey_recorded/real_main_details/real_main_details.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  //
  var str_goal_loader = '0';
  //
  var str_category_id = '';
  var arr_get_category_list = [];
  var arr_goal_list = [];
  //
  var str_category_search = '0';
  var str_category_search_name = 'ALL';

  var str_filter_search = '0';
  var str_filter_search_name = 'ALL';
  //
  var str_filter_id = '';
  var custom_filter_data = [];
  var arr_filter_search_data = [];
  //
  @override
  void initState() {
    super.initState();
    // print('i am goal main class');

//
    arr_filter_search_data = [
      {
        'id': '',
        'name': 'All',
      },
      {
        'id': '1',
        'name': 'Solo Goal',
      },
      {
        'id': '2',
        'name': 'Shop or Authority',
      },
      {
        'id': '3',
        'name': 'For Team or Shop',
      },
      {
        'id': '1',
        'name': 'Overdue',
      },
      {
        'id': '2',
        'name': 'Last 30 days',
      },
    ];

    // arr_filter_search_data.add(custom_filter_data);
    if (kDebugMode) {
      print(arr_filter_search_data);
    }
//

    get_goals_list_WB();
  }

// get cart
  get_goals_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : GOAL LIST');
    }

    setState(() {
      str_goal_loader = '0';
    });
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
          'pageNo': '',
          'subGoal': '2'
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
        arr_goal_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_goal_list.add(get_data['data'][i]);
        }
        get_category_list_WB();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar_goals_UI(),
      //drawer: const navigationDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            //
            categories_filter_UI(context),
            //
            (str_category_search == '0')
                ? const SizedBox(
                    width: 0,
                  )
                : category_search_UI(),

            // filter
            (str_filter_search == '0')
                ? const SizedBox(
                    width: 0,
                  )
                : filters_search_UI(),

            //
            if (str_goal_loader == '0') ...[
              const CustomeLoaderPopUp(
                str_custom_loader: 'please wait...',
                str_status: '0',
              ),
            ] else if (str_goal_loader == '1') ...[
              const CustomeLoaderPopUp(
                str_custom_loader: 'Goals not Added Yet.',
                str_status: '4',
              ),
            ] else ...[
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: arr_goal_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => RealMainDetailsScreen(
                      //       str_navigation_title: 'Goal',
                      //       str_category_name:
                      //           arr_goal_list[index]['categoryName'].toString(),
                      //       str_name: arr_goal_list[index]['name'].toString(),
                      //       str_due_date:
                      //           arr_goal_list[index]['deadline'].toString(),
                      //       str_get_about_goal:
                      //           arr_goal_list[index]['aboutGoal'].toString(),
                      //       str_get_goal_id:
                      //           arr_goal_list[index]['goalId'].toString(),
                      //       str_category_id:
                      //           arr_goal_list[index]['categoryId'].toString(),
                      //       str_professional_type: 'Goal',
                      //       str_tray_value: 'goal',
                      //       str_parent_name:
                      //           arr_goal_list[index]['parentName'].toString(),
                      //     ),
                      //   ),
                      // );
                      push_to_add_goal(
                        context,
                        arr_goal_list[index]['categoryName'].toString(),
                        arr_goal_list[index]['name'].toString(),
                        arr_goal_list[index]['deadline'].toString(),
                        arr_goal_list[index]['aboutGoal'].toString(),
                        arr_goal_list[index]['goalId'].toString(),
                        arr_goal_list[index]['categoryId'].toString(),
                        arr_goal_list[index]['parentName'].toString(),
                        arr_goal_list[index]['image'].toString(),
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
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(
                              40.0,
                            ),
                          ),
                          child: (arr_goal_list[index]['image'].toString() ==
                                  '')
                              ? Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    // color: Colors.blueAccent[200],
                                    color: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  child: Align(
                                    child: Text(
                                      //
                                      func_get_initials(
                                        arr_goal_list[index]['name'].toString(),
                                      ),
                                      //
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: Image.network(
                                    arr_goal_list[index]['image'].toString(),
                                    fit: BoxFit.cover,
                                    // height: 220,
                                  ),
                                ),
                        ),

                        /*ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: (arr_goal_list[index]['image'].toString() ==
                                  '')
                              ? Image.asset('assets/images/logo.png')
                              : FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/loader.gif',
                                  image:
                                      arr_goal_list[index]['image'].toString(),
                                ),
                        ),*/
                        // const CircleAvatar(
                        //   radius: 30,
                        //   backgroundImage: AssetImage(
                        //     'assets/images/3.png',
                        //   ),
                        // ),
                        title: Text(
                          //
                          arr_goal_list[index]['name'].toString(),
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          //
                          arr_goal_list[index]['categoryName'].toString(),
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
                        trailing: (arr_goal_list[index]['deadline']
                                    .toString()
                                    .substring(0, 4) ==
                                '1970')
                            ? Container(
                                height: 40,
                                width: 120,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      25.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        //
                                        'n.a.',
                                        //
                                        style: TextStyle(
                                          fontFamily: font_style_name,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : (func_difference_between_date(arr_goal_list[index]
                                            ['deadline']
                                        .toString()) ==
                                    'overdue')
                                ? Container(
                                    height: 40,
                                    width: 120,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          12.0,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          child: Text(
                                            //
                                            //
                                            'overdue',
                                            //
                                            style: TextStyle(
                                              fontFamily: font_style_name,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                  )
                                : Container(
                                    height: 40,
                                    width: 120,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          12.0,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        child: Text(
                                          //
                                          func_difference_between_date(
                                              arr_goal_list[index]['deadline']
                                                  .toString()),
                                          //
                                          style: TextStyle(
                                            fontFamily: font_style_name,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                      ),
                    ),
                  );
                },
              ),
            ]
          ],
        ),
      ),
    );
  }

// FILTER
  SingleChildScrollView filters_search_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 70,
        // width: 20,
        color: navigation_color,
        child: Row(
          children: <Widget>[
            for (int i = 0; i < arr_filter_search_data.length; i++) ...[
              InkWell(
                onTap: () {
                  //
                  // print('object');

                  /*str_category_search_name =
                      arr_filter_search_data[i]['name'].toString();
                  setState(() {});

                  str_category_id = arr_filter_search_data[i]['id'].toString();
                  searched_get_goals_list_WB(
                    arr_filter_search_data[i]['id'].toString(),
                  );*/

                  str_filter_id = arr_filter_search_data[i]['id'].toString();
                  str_filter_search_name =
                      arr_filter_search_data[i]['name'].toString();
                  str_filter_search = '0';
                  setState(() {});

                  // searched_via_filters_WB(
                  // arr_filter_search_data[i]['id'].toString());

                  // setState(() {
                  //   str_category_search = '0';
                  // });

                  func_manage_filter_section_here();

                  print('category id is ====> $str_category_id');
                  print('category id is ====> $str_category_search_name');

                  print(arr_filter_search_data[i]['id'].toString());
                  print('filter id is ====> $str_filter_search_name');
                  //
                },
                child: (str_filter_search_name ==
                        arr_filter_search_data[i]['name'].toString())
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(
                            color: Colors.amber,
                          ),
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            //
                            arr_filter_search_data[i]['name'].toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            //
                            arr_filter_search_data[i]['name'].toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ],
        ),
      ),
    );
  }

  SingleChildScrollView category_search_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 70,
        // width: 20,
        color: navigation_color,
        child: Row(
          children: <Widget>[
            for (int i = 0; i < arr_get_category_list.length; i++) ...[
              InkWell(
                onTap: () {
                  //
                  // print('object');

                  str_category_search_name =
                      arr_get_category_list[i]['name'].toString();
                  str_category_search = '0';
                  setState(() {});

                  str_category_id = arr_get_category_list[i]['id'].toString();
                  /*
                  searched_get_goals_list_WB(
                    arr_get_category_list[i]['id'].toString(),
                  );*/
                  func_manage_filter_section_here();
                  //
                },
                child: (str_category_search_name ==
                        arr_get_category_list[i]['name'].toString())
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(
                            color: Colors.amber,
                          ),
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            //
                            arr_get_category_list[i]['name'].toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            //
                            arr_get_category_list[i]['name'].toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Container categories_filter_UI(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: const Color.fromRGBO(9, 44, 132, 1),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: InkWell(
                onTap: () {
                  // open_category_list(context);

                  if (str_category_search == '1') {
                    setState(() {
                      str_category_search = '0';
                    });
                  } else {
                    setState(() {
                      str_category_search = '1';
                    });
                  }

                  // func_manage_filter_section_here();
                },
                child: Container(
                  height: 60,
                  width: 100,
                  // width: MediaQuery.of(context).size.width,

                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage('assets/images/btn_round.png'),
                    //   fit: BoxFit.cover,
                    // ),
                    // shape: BoxShape.circle,

                    // color: Colors.orange,
                    // image:
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
                      'Categories'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: InkWell(
                onTap: () {
                  // open_filters_list(context);

                  if (str_filter_search == '1') {
                    setState(() {
                      str_filter_search = '0';
                    });
                  } else {
                    setState(() {
                      str_filter_search = '1';
                    });
                  }

                  // func_manage_filter_section_here();
                },
                child: Container(
                  height: 60,
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
                      'Filters'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar app_bar_goals_UI() {
    return AppBar(
      backgroundColor: navigation_color,
      title: Text(
        ///
        navigation_title_goal,

        ///
        style: TextStyle(
          fontFamily: font_style_name,
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      // leading: Icon(
      //   Icons.abc,
      // ),
      actions: [
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: InkWell(
        //     onTap: () =>
        //         // print('object');
        //         Navigator.of(context),
        //     child: const Icon(
        //       Icons.home,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        InkWell(
          onTap: () {
            if (kDebugMode) {
              print('click on add goals');
            }
            _navigateAndDisplaySelection(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const AddGoals(),
            //   ),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
            ),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: app_yellow_color,
              child: const Icon(
                Icons.add,
                color: Colors.black,
                size: 16,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 20.0,
          ),
          child: CircleAvatar(
            radius: 14,
            backgroundColor: app_yellow_color,
            child: const Icon(
              Icons.question_mark,
              color: Colors.black,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddGoals()),
    );

    // print('result =====> ' + result);

    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));

    //
    arr_goal_list.clear();
    //
    setState(() {
      get_goals_list_WB();
    });
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

  //
  get_category_list_WB() async {
    print('=====> POST : GET CATEGORY');

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'category',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //

        arr_get_category_list = get_data['data'];

        var custom_dict = {'id': '', 'name': 'ALL'};
        arr_get_category_list.insert(0, custom_dict);

        // print(arr_get_category_list);
        // print(arr_get_category_list.length);

        if (arr_goal_list.isEmpty) {
          str_goal_loader = '1';
        } else {
          str_goal_loader = '2';
        }

        setState(() {});

        // if (arr_notes_list.isEmpty) {
        //   setState(() {
        //     str_main_loader = 'notes_data_empty';
        //   });
        // } else {
        //   setState(() {
        //     str_main_loader = 'notes_loader_stop';
        //   });
        // }
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
  void open_category_list(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Categories'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          //
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () {
              Navigator.pop(context);
              //
              get_goals_list_WB();
              //
            },
            child: Text(
              'All',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          //
          for (int i = 0; i < arr_get_category_list.length; i++) ...[
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                /*note_list_by_category_list_WB(
                    arr_get_category_list[i]['id'].toString());

                */
                str_category_id = arr_get_category_list[i]['id'].toString();
                searched_get_goals_list_WB(
                  arr_get_category_list[i]['id'].toString(),
                );
              },
              child: Text(
                arr_get_category_list[i]['name'].toString(),
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
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

  // filters
  void open_filters_list(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Filters'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          //
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () {
              Navigator.pop(context);
              //
              get_goals_list_WB();
              //
            },
            child: Text(
              'All',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          //
          // for (int i = 0; i < arr_get_category_list.length; i++) ...[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              searched_via_filters_WB('1');
              //
            },
            child: Text(
              //
              'Solo Goal',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          // shop or authority
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              searched_via_filters_WB('2');
              //
            },
            child: Text(
              //
              'Shop or Authority',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          // team or shop
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              searched_via_filters_WB('3');
              //
            },
            child: Text(
              //
              'For Team or Shop',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          // overdue
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              searched_via_filters_WB('4');
              //
            },
            child: Text(
              //
              'Overdue',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          // last 30 days
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              searched_via_filters_WB('5');
              //
            },
            child: Text(
              //
              'Last 30 days',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),

          // ],
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

  //
  // get cart
  searched_get_goals_list_WB(
    String str_category_id,
  ) async {
    print('=====> POST : SEARCHEDE GOAL LIST');

    // print(str_category_search_name);
    // if (str_category_search_name == 'ALL') {
    // setState(() {
    // str_category_search = '0';
    // });
    // }
    setState(() {
      str_goal_loader = '0';
    });

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
          'pageNo': '',
          'subGoal': '2',
          'categoryId': str_category_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        arr_goal_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_goal_list.add(get_data['data'][i]);
        }
        get_category_list_WB();
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

  // get cart
  searched_via_filters_WB(
    String str_goal_type,
  ) async {
    print('=====> POST : SEARCH VIA FILTERS');

    setState(() {
      str_goal_loader = '0';
    });
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
          'pageNo': '',
          'subGoal': '2',
          'goalType': str_goal_type.toString(),
          'categoryId': str_category_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        arr_goal_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_goal_list.add(get_data['data'][i]);
        }
        get_category_list_WB();
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

  func_get_initials(String str_name) {
    var initials_are = str_name.split(' ');

    var final_initial_name = '';
    // print(initials_are.length);
    if (initials_are.length == 1) {
      final_initial_name = initials_are[0][0].toString().toUpperCase();
    } else if (initials_are.length == 2) {
      final_initial_name =
          (initials_are[0][0] + initials_are[1][0]).toString().toUpperCase();
    } else {
      final_initial_name = initials_are[0][0].toString().toUpperCase();
    }
    return final_initial_name;
  }

  // manage filter
  func_manage_filter_section_here() {
    /*print('===============> DISHANT RAJPUT');
    print('category id is ====> $str_category_id');
    print('category id is ====> $str_category_search_name');

    print(str_filter_id.toString());
    print('filter id is ====> $str_filter_search_name');
    print('===============>');*/

    if (str_filter_search_name.toString() == 'Overdue' ||
        str_filter_search_name.toString() == 'Last 30 days') {
      // print('with overdue');
      seach_with_overdue_WB();
    } else {
      // print('without overdue');
      seach_without_overdue_WB();
    }

    //
  }

  seach_without_overdue_WB(
      // String str_goal_type,
      ) async {
    // print('=====> POST : SEARCH VIA FILTERS');

    setState(() {
      str_goal_loader = '0';
    });
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
          'pageNo': '',
          'subGoal': '2',
          'goalType': str_filter_id.toString(),
          'categoryId': str_category_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        arr_goal_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_goal_list.add(get_data['data'][i]);
        }

        if (arr_goal_list.isEmpty) {
          str_goal_loader = '1';
        } else {
          str_goal_loader = '2';
        }

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

  seach_with_overdue_WB(
      // String str_goal_type,
      ) async {
    // print('=====> POST : SEARCH VIA FILTERS');

    setState(() {
      str_goal_loader = '0';
    });
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
          'pageNo': '',
          'subGoal': '2',
          'overdue': str_filter_id.toString(),
          'categoryId': str_category_id.toString(),
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
        arr_goal_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_goal_list.add(get_data['data'][i]);
        }

        if (arr_goal_list.isEmpty) {
          str_goal_loader = '1';
        } else {
          str_goal_loader = '2';
        }

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

  // push to details
  Future<void> push_to_add_goal(
    BuildContext context,
    String str_get_category_name,
    String str_get_name,
    String str_get_due_date,
    String str_get_about_goal,
    String str_get_goal_id,
    String str_get_category_id,
    String str_get_parent_name,
    String str_get_profile,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RealMainDetailsScreen(
          str_navigation_title: 'Goal',
          str_category_name: str_get_category_name.toString(),
          str_name: str_get_name.toString(),
          str_due_date: str_get_due_date.toString(),
          str_get_about_goal: str_get_about_goal.toString(),
          str_get_goal_id: str_get_goal_id.toString(),
          str_category_id: str_get_category_id.toString(),
          str_professional_type: 'Goal',
          str_tray_value: 'goal',
          str_parent_name: str_get_parent_name.toString(),
          str_goal_cat_id: str_get_goal_id.toString(),
          str_image: str_get_profile,
          strFromViewDetails: 'no',
        ),
      ),
    );

    //

    //
    if (!mounted) return;
    str_goal_loader = '0';
    str_category_search = '0';
    str_filter_search = '0';
    setState(() {});

    get_goals_list_WB();
  }
}
