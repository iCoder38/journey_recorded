// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/real_main_details/real_main_details.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:journey_recorded/single_classes/single_class.dart';
import 'package:journey_recorded/sub_goals/sub_goals_details/sub_goals_details.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SubGoalsScreen extends StatefulWidget {
  const SubGoalsScreen({super.key, required this.str_from_goal_id});

  final String str_from_goal_id;

  @override
  State<SubGoalsScreen> createState() => _SubGoalsScreenState();
}

class _SubGoalsScreenState extends State<SubGoalsScreen> {
  //
  var str_sub_goal_loader = '0';
  var arr_sub_goals = [];
  //
  var str_category_id = '';
  var arr_get_category_list = [];
  //
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
  final GetDifferenceBetweenDate parse_days_left = GetDifferenceBetweenDate();
  //
  @override
  void initState() {
    super.initState();

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

    if (widget.str_from_goal_id == 'n.a.') {
      get_sub_goals_list_WB('');
    } else {
      get_sub_goals_list_WB(widget.str_from_goal_id.toString());
    }
  }

  // get sub goals
  get_sub_goals_list_WB(
    String parent_goal_id,
  ) async {
    print('=====> POST : SUB GOAL LIST');

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
          'parentGoalId': parent_goal_id.toString(),
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
        // print('YES DATA FOUND');
        arr_sub_goals.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          arr_sub_goals.add(get_data['data'][i]);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          'Sub - Goals', Colors.white, 16.0,
        ),
        leading: IconButton(
          onPressed: () {
            //
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        backgroundColor: navigation_color,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            //
            categories_filter_UI(context),
            //

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

            if (str_sub_goal_loader == '0') ...[
              //
              const CustomeLoaderPopUp(
                str_custom_loader: 'Please wait...',
                str_status: '0',
              ),
              //
            ] else if (str_sub_goal_loader == '1') ...[
              //
              const CustomeLoaderPopUp(
                str_custom_loader: 'Sub goals not Added Yet.',
                str_status: '4',
              ),
              //
            ] else ...[
              /*(widget.str_from_goal_id == 'n.a.')
                  ? Container(
                      height: 10,
                      width: 10,
                      color: Colors.pink,
                    )
                  : */
              /*Container(
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(
                          8.0,
                        ),
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
                  ],
                ),
              ),*/
              //
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: arr_sub_goals.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      // print('object');
                      // print(arr_sub_goals);

                      final result = await Navigator.push(
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
                            fullData: arr_sub_goals[index],
                          ),
                        ),
                      );

                      // ignore: prefer_interpolation_to_compose_strings
                      if (kDebugMode) {
                        print('result =====> ' + result);
                      }

                      if (result == 'sub_goal') {
                        str_sub_goal_loader = '0';
                        setState(() {});
                        if (widget.str_from_goal_id == 'n.a.') {
                          get_sub_goals_list_WB('');
                        } else {
                          str_sub_goal_loader = '0';
                          setState(() {});
                          get_sub_goals_list_WB(
                              widget.str_from_goal_id.toString());
                        }
                      }

// get_back_from_add_notes

                      if (!mounted) return;

                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubGoalsDetailsScreen(
                            str_get_goal_id:
                                arr_sub_goals[index]['goalId'].toString(),
                            str_get_sub_goal_category_id:
                                arr_sub_goals[index]['categoryId'].toString(),
                            str_get_sub_goal_category_name:
                                arr_sub_goals[index]['categoryName'].toString(),
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
                        leading: (arr_sub_goals[index]['image'].toString() ==
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
                                      arr_sub_goals[index]['name'].toString(),
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
                                  arr_sub_goals[index]['image'].toString(),
                                  fit: BoxFit.cover,
                                  // height: 220,
                                ),
                              ),

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
                        trailing: (arr_sub_goals[index]['deadline']
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
                            : (func_difference_between_date(arr_sub_goals[index]
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
                                              arr_sub_goals[index]['deadline']
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

  /*Container categories_filter_UI(BuildContext context) {
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
                  open_category_list(context);
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
                  open_filters_list(context);
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
  }*/

  //
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

        if (arr_sub_goals.isEmpty) {
          str_sub_goal_loader = '1';
          setState(() {});
        } else {
          str_sub_goal_loader = '2';
          setState(() {});
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
              if (widget.str_from_goal_id == 'n.a.') {
                get_sub_goals_list_WB('');
              } else {
                get_sub_goals_list_WB(widget.str_from_goal_id.toString());
              }
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
              if (widget.str_from_goal_id == 'n.a.') {
                get_sub_goals_list_WB('');
              } else {
                get_sub_goals_list_WB(widget.str_from_goal_id.toString());
              }
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

    setState(() {
      str_sub_goal_loader = '0';
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
          'subGoal': '1',
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
        arr_sub_goals.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_sub_goals.add(get_data['data'][i]);
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
      str_sub_goal_loader = '0';
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
          'subGoal': '1',
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
        arr_sub_goals.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_sub_goals.add(get_data['data'][i]);
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

  // new ui
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
    print('===============> DISHANT RAJPUT');
    print('category id is ====> $str_category_id');
    print('category id is ====> $str_category_search_name');

    print(str_filter_id.toString());
    print('filter id is ====> $str_filter_search_name');
    print('===============>');

    if (str_filter_search_name.toString() == 'Overdue' ||
        str_filter_search_name.toString() == 'Last 30 days') {
      print('with overdue');
      seach_with_overdue_WB();
    } else {
      print('without overdue');
      seach_without_overdue_WB();
    }

    //
  }

  seach_without_overdue_WB(
      // String str_goal_type,
      ) async {
    // print('=====> POST : SEARCH VIA FILTERS');

    setState(() {
      str_sub_goal_loader = '0';
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
          'subGoal': '1',
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
        arr_sub_goals.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_sub_goals.add(get_data['data'][i]);
        }

        if (arr_sub_goals.isEmpty) {
          str_sub_goal_loader = '1';
        } else {
          str_sub_goal_loader = '2';
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
      str_sub_goal_loader = '0';
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
          'subGoal': '1',
          'overdue': str_filter_id.toString(),
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
        arr_sub_goals.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_sub_goals.add(get_data['data'][i]);
        }

        if (arr_sub_goals.isEmpty) {
          str_sub_goal_loader = '1';
        } else {
          str_sub_goal_loader = '2';
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
}
