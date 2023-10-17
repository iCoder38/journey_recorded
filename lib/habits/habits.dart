// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/habits/create_new_habit/create_new_habit.dart';
import 'package:journey_recorded/habits/habits_info.dart/habits_info.dart';
import 'package:journey_recorded/custom_files/language_translate_texts/language_translate_text.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  //
  var strUserSelectLanguage = 'en';
  final ConvertLanguage languageTextConverter = ConvertLanguage();
  //
  var str_loader_habit = '0';
  var arr_habits_list = [];
  //
  @override
  void initState() {
    super.initState();

    funcSelectLanguage();

    get_habits_list_WB();
  }

// /********** LANGUAGE SELECTED **********************************************/
  funcSelectLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strUserSelectLanguage = prefs.getString('selected_language').toString();
    if (kDebugMode) {
      print('user already selected ====> $strUserSelectLanguage');
    }
    setState(() {});
  }

// /********** LANGUAGE SELECTED **********************************************/

  // get cart
  get_habits_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : HABIT LIST');
    }

    str_loader_habit = '0';
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
          'action': 'habitlist',
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
        arr_habits_list.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          //
          arr_habits_list.add(get_data['data'][i]);
          //
        }

        //
        str_loader_habit = '1';
        setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          navigation_title_habits,
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: app_yellow_color,
              child: InkWell(
                onTap: () {
                  print('object');
                },
                child: const Icon(
                  Icons.question_mark_sharp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          func_push_to_add_new_habit(context);
        },
        backgroundColor: navigation_color,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            // color: Colors.amber,
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
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  height: 160,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/task_bg.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(
                        240,
                        20,
                        74,
                        1,
                      ),
                      border: Border.all(
                        width: 2.0,
                        color: Colors.white,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: text_regular_style_custom(
                                      //
                                      languageTextConverter.funcConvertLanguage(
                                        'grind_category',
                                        strUserSelectLanguage,
                                      ),
                                      Colors.white,
                                      14.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: text_regular_style_custom(
                                      //
                                      languageTextConverter.funcConvertLanguage(
                                        'grind_priority',
                                        strUserSelectLanguage,
                                      ),
                                      Colors.white,
                                      14.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: text_regular_style_custom(
                                      //
                                      languageTextConverter.funcConvertLanguage(
                                        'grind_skills',
                                        strUserSelectLanguage,
                                      ),
                                      Colors.white,
                                      14.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: text_regular_style_custom(
                                      //
                                      languageTextConverter.funcConvertLanguage(
                                        'grind_none',
                                        strUserSelectLanguage,
                                      ),
                                      Colors.white,
                                      14.0,
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
              ],
            ),
          ),
          (str_loader_habit == '0')
              ? const CustomeLoaderPopUp(
                  str_custom_loader: 'please wait...',
                  str_status: '4',
                )
              : Column(
                  children: <Widget>[
                    for (var i = 0; i < arr_habits_list.length; i++) ...[
                      InkWell(
                        onTap: () {
                          var split_date =
                              arr_habits_list[i]['reminderAlarm'].toString();

                          if (kDebugMode) {
                            print('<==== dishu ====>');
                            print(arr_habits_list[i]);
                          }

                          // print(split_date.split(' ')[0]);

                          push_to_edit_habits(
                            context,
                            arr_habits_list[i]['habitId'].toString(),
                            arr_habits_list[i]['name'].toString(),
                            arr_habits_list[i]['categoryId'].toString(),
                            arr_habits_list[i]['categoryName'].toString(),
                            arr_habits_list[i]['userName'].toString(),
                            arr_habits_list[i]['priority'].toString(),
                            split_date.split(' ')[0].toString(), // date
                            split_date.split(' ')[1].toString(), // time
                            arr_habits_list[i]['startPercentage'].toString(),
                            arr_habits_list[i]['tiggerPoint'].toString(),
                            arr_habits_list[i]['why'].toString(),
                            arr_habits_list[i]['danger'].toString(),
                            arr_habits_list[i]['pro'].toString(),
                            arr_habits_list[i]['specificDetails'].toString(),
                            arr_habits_list[i]['time_to_complete'].toString(),
                            arr_habits_list[i]['SkillClass'].toString(),
                          );
                        },
                        child: ListTile(
                          title: text_bold_style_custom(
                            //
                            arr_habits_list[i]['name'].toString(),
                            Colors.black, 18.0,
                          ),
                          subtitle: text_regular_style_custom(
                            //
                            arr_habits_list[i]['categoryName'].toString(),
                            Colors.black, 10.0,
                          ),
                          trailing: Container(
                            height: 50,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    'assets/images/clock.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                //
                                text_bold_style_custom(
                                  //
                                  '${arr_habits_list[i]['startPercentage']}%',
                                  Colors.white,
                                  16.0,
                                ),
                                //
                                Padding(
                                  padding: const EdgeInsets.all(
                                    4.0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      //
                                      //
                                      var sumOnePercentage = 1;
                                      var oldPercentage = int.parse(
                                          arr_habits_list[i]['startPercentage']
                                              .toString());
                                      // var sumBoth =
                                      // oldPercentage + sumOnePercentage;
                                      // if (kDebugMode) {
                                      // print(sumBoth);
                                      // }
                                      // filter
                                      // sumBoth = 29;
                                      //

                                      //
                                      oldPercentage = 89;
                                      //
                                      // if (kDebugMode) {
                                      //   print('======================');
                                      //   print(oldPercentage);
                                      // }
                                      //
                                      var addValue = 0;
                                      //
                                      var send_filtered_value = '32';
                                      if (oldPercentage > 1 &&
                                          oldPercentage < 30) {
                                        //
                                        // if (kDebugMode) {
                                        //   print('add only 1');
                                        //   print('======================');
                                        // }
                                        //
                                        oldPercentage += 1;
                                        //
                                      } else if (oldPercentage > 30 &&
                                          oldPercentage < 90) {
                                        //
                                        // if (kDebugMode) {
                                        //   print('add only 2');
                                        //   print('======================');
                                        // }
                                        //
                                        oldPercentage += 2;
                                        //
                                      } else {
                                        //
                                        // if (kDebugMode) {
                                        //   print('add only 1');
                                        //   print('======================');
                                        // }
                                        //
                                        oldPercentage += 1;
                                        //
                                      }
                                      // if (kDebugMode) {
                                      //   print('======================');
                                      //   print('======================');
                                      //   print(oldPercentage);
                                      //   print('======================');
                                      //   print('======================');
                                      // }
                                      //
                                      DateTime now = DateTime.now();
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd').format(now);
                                      if (kDebugMode) {
                                        print(formattedDate);
                                      }
                                      if (arr_habits_list[i]['updateDate']
                                              .toString() ==
                                          formattedDate.toString()) {
                                        if (kDebugMode) {
                                          print('The dates are same');
                                        }
                                        //
                                        var snackdemo = SnackBar(
                                          content: text_regular_style_custom(
                                            //
                                            habit_you_already_update_status_EN,
                                            Colors.white,
                                            14.0,
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackdemo);
                                        //
                                      } else {
                                        //
                                        if (kDebugMode) {
                                          print('you clicked plus button');
                                        }
                                        updateOnePercentage(
                                          arr_habits_list[i]['habitId']
                                              .toString(),
                                          oldPercentage.toString(),
                                        );
                                        //
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        /*child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          // height: 60.0,
                          child:  /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(20),
                                color: Colors.transparent,
                                // width: MediaQuery.of(context).size.width,
                                // height: 60.0,
                                child: text_with_semi_bold_style_black(
                                  //
                                  arr_habits_list[i]['name'].toString(),
                                  //
                                ),
                              ),
                              //
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                color: Colors.transparent,
                                width: 120,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (kDebugMode) {
                                          print('object1');
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.watch_later_rounded,
                                        color: Colors.pink,
                                        size: 30,
                                      ),
                                    ),
                                    //
                                    text_with_regular_style(
                                      '${arr_habits_list[i]['startPercentage']}%',
                                    ),
                                    //
                                    IconButton(
                                      onPressed: () {
                                        if (kDebugMode) {
                                          print(
                                              'clicked on add one percentage');
                                        }
                                        //
                                        var sumOnePercentage = 1;
                                        var oldPercentage = int.parse(
                                            arr_habits_list[i]
                                                    ['startPercentage']
                                                .toString());
                                        var sumBoth =
                                            oldPercentage + sumOnePercentage;
                                        if (kDebugMode) {
                                          print(sumBoth);
                                        }
                                        updateOnePercentage(
                                          arr_habits_list[i]['habitId']
                                              .toString(),
                                          sumBoth.toString(),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //
                            ],
                          ),*/
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 20.0,
                                ),
                                child: Text(
                                  //
                                  arr_habits_list[i]['name'].toString(),
                                  //
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  right: 20.0,
                                ),
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '+10%',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),*/
                        ),*/
                      ),
                      Container(
                        color: Colors.grey,
                        width: MediaQuery.of(context).size.width,
                        height: 1.0,
                      ),
                    ]
                  ],
                ),
        ],
      ),
    );
  }

// push to add new habit
  Future<void> func_push_to_add_new_habit(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateNewHabitScreen(
          str_fetch_get_name_your_habit: '',
          str_fetch_get_user_name: '',
          str_fetch_get_priority: '',
          str_fetch_get_reminder_date: '',
          str_fetch_get_reminder_time: '',
          str_fetch_get_start: '',
          str_fetch_get_trigger: '',
          str_fetch_get_why: '',
          str_fetch_get_danger: '',
          str_fetch_get_pro: '',
          str_fetch_get_specify: '',
          str_fetch_get_habit_id: '',
          str_fetch_get_category_id: '',
          str_fetch_get_category_name: '',
          str_fetch_get_skill: '',
          str_fetch_get_time: '',
          str_fetched_select_class: '',
        ),
      ),
    );

    print('result =====> ' + result);
    print('object 22.22');

    if (!mounted) return;

    //
    str_loader_habit = '0';
    get_habits_list_WB();
    //
  }

  Future<void> push_to_edit_habits(
    BuildContext context,
    String str_habit_id,
    String str_name,
    String str_get_category_id,
    String str_get_category_name,
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
    String str_time_to_complete,
    String str_get_class_deets,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HabitsInfoScreen(
          str_habit_id: str_habit_id.toString(),
          str_get_name_your_habit: str_name.toString(),
          str_get_category_id: str_get_category_id.toString(),
          str_get_category_name: str_get_category_name.toString(),
          str_get_user_name: str_user_name.toString(),
          str_get_priority: str_priority.toString(),
          str_get_reminder_date: str_reminder_date.toString(),
          str_get_reminder_time: str_reminder_time.toString(),
          str_get_start: str_start.toString(),
          str_get_trigger: str_trigger.toString(),
          str_get_why: str_why.toString(),
          str_get_danger: str_danger.toString(),
          str_get_pro: str_pro.toString(),
          str_get_specify: str_specify.toString(),
          str_get_skill_id: '',
          str_get_skill_name: '',
          str_get_time_name: str_time_to_complete,
          str_get_class: str_get_class_deets.toString(),
        ),
      ),
    );

    print('result =====> ' + result);

    if (!mounted) return;

    //
    str_loader_habit = '0';
    get_habits_list_WB();
    //
  }

  //
  /*
  [action] => habitupdate
    [userId] => 3
    [habitId] => 10
    [startPercentage] => 1
  */
  // get cart
  updateOnePercentage(
    getHabitId,
    getPercentage,
  ) async {
    if (kDebugMode) {
      print('=====> POST : UPDATE ONE PERCENTAGE');
    }

    setState(() {
      str_loader_habit = '0';
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
          'action': 'habitupdate',
          'userId': prefs.getInt('userId').toString(),
          'habitId': getHabitId.toString(),
          'startPercentage': getPercentage.toString()
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
        //
        get_habits_list_WB();
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
}
