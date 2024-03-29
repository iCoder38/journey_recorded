// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:journey_recorded/custom_files/language_translate_texts/language_translate_text.dart';
import 'package:journey_recorded/mission/add_mission/add_mission.dart';
import 'package:journey_recorded/real_main_details/real_main_details.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key});

  @override
  State<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
  //
  var strUserSelectLanguage = 'en';
  final ConvertLanguage languageTextConverter = ConvertLanguage();
  //
  var str_mission_loader = '0';
  var arr_quest_list = [];
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
  var professionIdForAddMission = '';
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
        'name': 'Overdue',
      },
      {
        'id': '2',
        'name': 'Last 30 days',
      },
    ];

    funcSelectLanguage();
    get_quest_list_WB();
  }

// /********** LANGUAGE SELECTED **********************************************/
  funcSelectLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strUserSelectLanguage = prefs.getString('language').toString();
    if (kDebugMode) {
      print('user already selected ====> $strUserSelectLanguage');
    }
    setState(() {});
  }
// /********** LANGUAGE SELECTED **********************************************/

  // get mission details
  get_quest_list_WB() async {
    print('=====> POST : QUEST LIST');

    //

    setState(() {
      str_mission_loader = '0';
    });
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    professionIdForAddMission = prefs.getInt('userId').toString();

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
          'pageNo': ''
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_quest_list.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          arr_quest_list.add(get_data['data'][i]);
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

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          'Quest', Colors.white, 16.0,
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
        actions: [
          IconButton(
            onPressed: () {
              //
              add_quest(context);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: navigation_color,
      ),
      /*AppBar(
        backgroundColor: navigation_color,
        title: Text(
          ///
          navigation_title_quest,

          ///
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
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
        ],
      ),*/
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            //
            categories_filters_UI(context),
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

            if (str_mission_loader == '0') ...[
              //
              const CustomeLoaderPopUp(
                str_custom_loader: 'Please wait...',
                str_status: '0',
              ),
              //
            ] else if (str_mission_loader == '1') ...[
              //
              const CustomeLoaderPopUp(
                str_custom_loader: 'Quest not Added Yet.',
                str_status: '4',
              ),
              //
            ] else ...[
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: arr_quest_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print('=====> PUSH TO QUEST');
                      }

                      push_to_quest_details(
                        context,
                        arr_quest_list[index]['categoryName'].toString(),
                        arr_quest_list[index]['name'].toString(),
                        arr_quest_list[index]['deadline'].toString(),
                        arr_quest_list[index]['description'].toString(),
                        arr_quest_list[index]['goalId'].toString(),
                        arr_quest_list[index]['categoryId'].toString(),
                        arr_quest_list[index]['parentName'].toString(),
                        arr_quest_list[index]['questId'].toString(),
                        arr_quest_list[index]['image'].toString(),
                        //
                        arr_quest_list[index],
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 0.0,
                      ),
                      // height: 80,
                      color: Colors.transparent,
                      child: ListTile(
                        // iconColor: Colors.pink,
                        leading: (arr_quest_list[index]['image'].toString() ==
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
                                      arr_quest_list[index]['name'].toString(),
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
                            : SizedBox(
                                height: 60,
                                width: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: Image.network(
                                    arr_quest_list[index]['image'].toString(),
                                    fit: BoxFit.cover,
                                    // height: 220,
                                  ),
                                ),
                              ),

                        title: Text(
                          //
                          arr_quest_list[index]['name'].toString(),
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          //
                          arr_quest_list[index]['categoryName'].toString(),
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
                        trailing: (arr_quest_list[index]['deadline']
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
                            : (func_difference_between_date(
                                        arr_quest_list[index]['deadline']
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
                                              arr_quest_list[index]['deadline']
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

// new ui
  // FILTER
  SingleChildScrollView filters_search_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
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

  Container categories_filters_UI(BuildContext context) {
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
                  height: 50,
                  // width: MediaQuery.of(context).size.width,

                  decoration: BoxDecoration(
                    // color: Colors.orange,
                    borderRadius: BorderRadius.circular(12.0),
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
                  child: Center(
                    child: text_bold_style_custom(
                      //
                      languageTextConverter.funcConvertLanguage(
                        'common_categories',
                        strUserSelectLanguage,
                      ),
                      Colors.black,
                      14.0,
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
                  height: 50,
                  // width: MediaQuery.of(context).size.width,

                  decoration: BoxDecoration(
                    // color: Colors.orange,
                    borderRadius: BorderRadius.circular(12.0),
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
                  child: Center(
                    child: text_bold_style_custom(
                      //
                      languageTextConverter.funcConvertLanguage(
                        'common_filters',
                        strUserSelectLanguage,
                      ),
                      Colors.black,
                      14.0,
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
      //
      data) async {
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
          strFromViewDetails: 'no',
          fullData: data,
        ),
      ),
    );

    print('result 1 =====> ' + result);

    if (!mounted) return;
    get_quest_list_WB();
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

        if (arr_quest_list.isEmpty) {
          str_mission_loader = '1';
          setState(() {});
        } else {
          str_mission_loader = '2';
          setState(() {});
        }

        // setState(() {});

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

  Future<void> add_quest(
    BuildContext context,
  ) async {
    // print('push to mission');
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMissionScreen(
          str_category_id: ''.toString(),
          str_goal_id: professionIdForAddMission.toString(),
          str_edit_status: '0',
          str_deadline: ''.toString(),
          str_mission_text: '',
          str_mission_id: ''.toString(),
          str_navigation_title: 'Add Quest',
        ),
      ),
    );

    print('result quest =====> ' + result);

    if (!mounted) return;

    get_quest_list_WB();

    // setState(() {});
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
              get_quest_list_WB();
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
              get_quest_list_WB();
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
          /*CupertinoActionSheetAction(
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
          ),*/
          // overdue
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              searched_via_filters_WB('1');
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
              searched_via_filters_WB('2');
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
      str_mission_loader = '0';
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
          'action': 'questlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          // 'subGoal': '2',
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
        arr_quest_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_quest_list.add(get_data['data'][i]);
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
      str_mission_loader = '0';
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
          'action': 'questlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          // 'subGoal': '2',
          'overdue': str_goal_type.toString(),
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
        arr_quest_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_quest_list.add(get_data['data'][i]);
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

  // NEW

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
      str_mission_loader = '0';
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
          'action': 'questlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
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
        arr_quest_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_quest_list.add(get_data['data'][i]);
        }

        if (arr_quest_list.isEmpty) {
          str_mission_loader = '1';
        } else {
          str_mission_loader = '2';
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
      str_mission_loader = '0';
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
          'action': 'questlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
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
        arr_quest_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_quest_list.add(get_data['data'][i]);
        }

        if (arr_quest_list.isEmpty) {
          str_mission_loader = '1';
        } else {
          str_mission_loader = '2';
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
