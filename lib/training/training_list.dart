// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/popup/popup.dart';
import 'package:journey_recorded/goals/add_notes_in_goal/add_notes_in_goal.dart';
import 'package:journey_recorded/goals/edit_notes_in_goal/edit_notes_in_goal.dart';
import 'package:journey_recorded/quotes/add_quotes/add_quotes.dart';
import 'package:journey_recorded/quotes/edit_quotes/edit_quotes.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
// import 'package:journey_recorded/task/create_task/create_task.dart';
import 'package:journey_recorded/training/add_check_list/add_check_list.dart';
import 'package:journey_recorded/training/add_routine/add_routine.dart';
// import 'package:journey_recorded/training/create_task/create_training.dart';
import 'package:journey_recorded/training/training_header.dart';
// import 'package:journey_recorded/training/training_quotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrainingListScreen extends StatefulWidget {
  const TrainingListScreen({
    super.key,
    required this.str_skill_id,
    required this.str_training_id,
    required this.strUserIdEnabled,
    this.strGetUserId,
  });

  final String str_skill_id;
  final String str_training_id;
  final String strUserIdEnabled;
  final strGetUserId;

  @override
  State<TrainingListScreen> createState() => _TrainingListScreenState();
}

class _TrainingListScreenState extends State<TrainingListScreen> {
  //
  var str_main_loader = '0';
  var str_UI_show = 'n.a.';
  var str_bottom_bar_color = '0';
  var str_get_training_id;

  // routine
  var arr_routine_list = [];

// check list
  var arr_check_list = [];

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

  //
  var get_str_date = '';
  var get_str_time = '';
  //
  var dict_save_training_full_data;
  //
  var boolFloatingButton = false;
  var strNewSkillClass = '';
  //
  @override
  void initState() {
    super.initState();
    // var string = widget.str_date;

    if (kDebugMode) {
      print('Skill id =====>  ${widget.str_skill_id}');
      print('Training id =====>  ${widget.str_training_id}');
    }

    if (widget.strUserIdEnabled == 'yes') {
      boolFloatingButton = true;
    } else {
      boolFloatingButton = false;
    }

    //
    funcValidationBeforeFetchTrainingList();
  }

  funcValidationBeforeFetchTrainingList() {
    if (widget.strUserIdEnabled == 'yes') {
      //
      getTrainingListOld();
    } else {
      //
      getTrainingListNew();
    }
  }

  getTrainingListNew() async {
    if (kDebugMode) {
      print('=====> POST : SKILL => TRAINING LIST 2');
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
          'action': 'traininglist',
          'userId': widget.strGetUserId.toString(),
          'pageNo': '',
          'skillId': widget.str_skill_id.toString()
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
        dict_save_training_full_data = get_data['data'][0];
        //

        //
        final splitted = dict_save_training_full_data['SetReminder'].split(' ');
        if (kDebugMode) {
          print(splitted);
        }
        get_str_date = splitted[0].toString();
        get_str_time = splitted[1].toString();
        //
        strNewSkillClass = dict_save_training_full_data['SkillClass'];
        //
        // get and parse data

        if (kDebugMode) {
          print('one');
          print(dict_save_training_full_data);
        }
        setState(() {
          str_main_loader = '1';
        });
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

  getTrainingListOld() async {
    if (kDebugMode) {
      print('=====> POST : SKILL => TRAINING LIST 2');
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
          'action': 'traininglist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'skillId': widget.str_skill_id.toString()
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
        dict_save_training_full_data = get_data['data'][0];
        //

        //
        final splitted = dict_save_training_full_data['SetReminder'].split(' ');
        if (kDebugMode) {
          print(splitted);
        }
        get_str_date = splitted[0].toString();
        get_str_time = splitted[1].toString();
        //
        // get and parse data

        if (kDebugMode) {
          print(dict_save_training_full_data);
        }
        setState(() {
          str_main_loader = '1';
        });
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: text_regular_style_custom(
              'training details'.toUpperCase(),
              Colors.white,
              16.0,
            ),
            backgroundColor: navigation_color,
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: TabBar(
              indicatorColor: Colors.lime,
              isScrollable: true,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'Info'.toUpperCase(),
                    Colors.white,
                    16.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'Notes'.toUpperCase(),
                    Colors.white,
                    16.0,
                  ),
                  // Text(
                  //   'Notes'.toUpperCase(),
                  //   style: TextStyle(
                  //     fontFamily: font_style_name,
                  //     fontSize: 16.0,
                  //     backgroundColor: Colors.transparent,
                  //   ),
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'Quotes'.toUpperCase(),
                    Colors.white,
                    16.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'Stats lvs'.toUpperCase(),
                    Colors.white,
                    16.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'grinds'.toUpperCase(),
                    Colors.white,
                    16.0,
                  ),
                )
              ],
              onTap: (value) {
                if (kDebugMode) {
                  print('user click ==> $value');
                }

                if (value == 0) {
                  // info
                  str_UI_show = 'n.a.';
                  str_bottom_bar_color = '0';
                  setState(() {});
                  //
                } else if (value == 1) {
                  // notes
                  // str_UI_show = 'notes';
                  // setState(() {});
                  func_notes_WB();
                  //
                } else if (value == 2) {
                  // quotes
                  //str_UI_show = 'notes';
                  // setState(() {});
                  //
                  func_quotes_WB();
                  //
                } else if (value == 3) {
                  // stats
                  // stats
                  //
                  str_UI_show = 'stats_lvs';
                  setState(() {});
                  //
                } else if (value == 4) {
                  // grinds
                }
                // else if (value == 5) {
                //   // link
                // }
              },
            ),
          ),
          floatingActionButton: Visibility(
            visible: boolFloatingButton,
            child: FloatingActionButton(
              onPressed: () {
                func_push_from_floating_button();
              },
              backgroundColor: navigation_color,
              child: const Icon(Icons.add),
            ),
          ),
          body: (str_main_loader == '0')
              ? const DialogExample(
                  str_alert_text_name: 'please wait...',
                )
              : TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    // tab 1
                    if (str_UI_show == 'routine') ...[
                      //
                      routine_UI()
                      //
                    ] else if (str_UI_show == 'check_list') ...[
                      //
                      check_list_UI(),
                      //
                    ] else if (str_UI_show == 'stats') ...[
                      //
                      stats_UI(),
                      //
                    ] else if (str_UI_show == 'frequency') ...[
                      //
                      frequency_UI(),
                      //
                    ] else ...[
                      //
                      tab_1_info_UI(context),
                      //
                    ],

                    // tab 2
                    if (str_UI_show == 'routine') ...[
                      //
                      routine_UI()
                      //
                    ] else if (str_UI_show == 'check_list') ...[
                      //
                      check_list_UI(),
                      //
                    ] else if (str_UI_show == 'stats') ...[
                      //
                      stats_UI(),
                      //
                    ] else if (str_UI_show == 'frequency') ...[
                      //
                      frequency_UI(),
                      //
                    ] else ...[
                      //
                      notes_UI(context)
                      //
                    ],

                    // tab 3
                    if (str_UI_show == 'routine') ...[
                      //
                      routine_UI()
                      //
                    ] else if (str_UI_show == 'check_list') ...[
                      //
                      check_list_UI(),
                      //
                    ] else if (str_UI_show == 'stats') ...[
                      //
                      stats_UI(),
                      //
                    ] else if (str_UI_show == 'frequency') ...[
                      //
                      frequency_UI(),
                      //
                    ] else ...[
                      //
                      // notes_UI(context)
                      quote_UI(context),

                      //
                    ],
                    // tab 4 ( stats lvs )
                    if (str_UI_show == 'routine') ...[
                      //
                      routine_UI()
                      //
                    ] else if (str_UI_show == 'check_list') ...[
                      //
                      check_list_UI(),
                      //
                    ] else if (str_UI_show == 'stats') ...[
                      //
                      stats_UI(),
                      //
                    ] else if (str_UI_show == 'frequency') ...[
                      //
                      frequency_UI(),
                      //
                    ] else ...[
                      //
                      stats_UI(),
                      //
                    ],

                    // tab 5 ( grinds )
                    if (str_UI_show == 'routine') ...[
                      //
                      routine_UI()
                      //
                    ] else if (str_UI_show == 'check_list') ...[
                      //
                      check_list_UI(),
                      //
                    ] else if (str_UI_show == 'stats') ...[
                      //
                      stats_UI(),
                      //
                    ] else if (str_UI_show == 'frequency') ...[
                      //
                      frequency_UI(),
                      //
                    ] else ...[
                      //
                      stats_UI(),
                      //
                    ],
                  ],
                ),
        ),
      ),
    );
  }

// stats lvs
  SingleChildScrollView stats_lvs_UI(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          // header
          //
          TrainingHeaderScreen(
            str_skill_class:
                dict_save_training_full_data['skillClassName'].toString(),
            str_next_level_xp:
                dict_save_training_full_data['currentLavel'].toString(),
          ),
          //

          Center(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              color: Colors.amber[600],
              width: 48.0,
              height: 48.0,
            ),
          ),
        ],
      ),
    );
  }

// quotes UI
  SingleChildScrollView quote_UI(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          // header
          //
          //
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
                                //print(index);
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

  Column notes_UI(BuildContext context) {
    return Column(
      children: [
        //
        header_UI(context),
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
                              str_profession_id = widget.str_skill_id;
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
    );
  }

  // routine
  Column routine_UI() {
    return Column(
      children: [
        //
        header_UI(context),
        //
        if (str_main_loader == 'routine_loader_start')
          const CustomeLoaderPopUp(
            str_custom_loader: 'please wait...',
            str_status: '3',
          )
        else if (str_main_loader == 'routine_loader_empty')
          const CustomeLoaderPopUp(
            str_custom_loader: 'Routine Not Added Yet.',
            str_status: '4',
          )
        else
          routine_expanded_UI()
      ],
    );
  }

  // tab 4
  SingleChildScrollView routine_expanded_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          //
          for (var i = 0; i < arr_routine_list.length; i++) ...[
            ExpansionTile(
              title: Text(
                //
                arr_routine_list[i]['message'].toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                ),
              ),
              // subtitle: Text('Trailing expansion arrow icon'),

              children: <Widget>[
                for (var j = 0;
                    j < arr_routine_list[i]['checklist'].length;
                    j++) ...[
                  ListTile(
                    /*leading: Container(
                      width: 80,
                      height: 80,
                      color: Colors.yellow,
                    ),*/
                    title: Text(
                      //
                      arr_routine_list[i]['checklist'][j]['message'].toString(),
                      //
                      style: TextStyle(
                          fontFamily: font_style_name,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    /*subtitle: Text(
                      // 'skills : ${arr_send_teammate_request[j]['skill']}\nTask name : ${arr_send_teammate_request[j]['taskName']}',
                      'sub-title',
                    ),*/
                    trailing: InkWell(
                      onTap: () {
                        print('sub-title click');
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              print('object');
                            },
                            icon: (arr_routine_list[i]['checklist'][j]
                                            ['message']
                                        .toString() ==
                                    '0')
                                ? Icon(
                                    Icons.check_box_outline_blank,
                                    color: navigation_color,
                                  )
                                : Icon(
                                    Icons.check_box,
                                    color: navigation_color,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    isThreeLine: false,
                  ),
                ]
              ],
            ),
          ],
          /*for (var i = 0; i < 1; i++) ...[
            ExpansionTile(
              title: Text(
                //

                //'${'approve teammate'.toString().toUpperCase()} ($str_approved_teammate_count)',
                'approved',
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
          ]*/
        ],
      ),
    );
  }

  // check list UI
  Column check_list_UI() {
    return Column(
      children: [
        //
        header_UI(context),
        //
        if (str_main_loader == 'check_list_loader_start')
          const CustomeLoaderPopUp(
            str_custom_loader: 'please wait...',
            str_status: '3',
          )
        else if (str_main_loader == 'check_list_loader_empty')
          const CustomeLoaderPopUp(
            str_custom_loader: 'Check List Not Added Yet.',
            str_status: '4',
          )
        else
          for (int i = 0; i < arr_check_list.length; i++) ...[
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      //
                      arr_check_list[i]['message'].toString(),
                      //
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // const Spacer(),
                  Container(
                    height: 40,
                    // width: 160,
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print('check box click');
                            }
                          },
                          icon: const Icon(
                            Icons.check_box_outline_blank,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print('checklist==>edit==>click');
                            }
                            //
                            push_to_edit_check_list(context, arr_check_list[i]);
                            //
                          },
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print('object');
                            }
                            delete_check_list_WB('Delete checklist',
                                arr_check_list[i]['checklistId'].toString());
                          },
                          icon: const Icon(
                            Icons.close,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
      ],
    );
  }

  // stats UI
  Column stats_UI() {
    return Column(
      children: [
        //
        header_UI(context),
        //
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'T Stats'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  //
                  dict_save_training_full_data['TStats'].toString(),
                  // '3',
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // frequency UI
  Column frequency_UI() {
    return Column(
      children: [
        //
        header_UI(context),
        //
        const SizedBox(
          height: 20,
        ),
        Text(
          'FREQUENCY',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        //
        const SizedBox(
          height: 8,
        ),
        if (dict_save_training_full_data['Frequency'].toString() ==
            'Mon,Wed,Fr') ...[
          Container(
            margin: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            height: 48.0,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      'Mon',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                //
                Expanded(
                  child: Center(
                    child: Text(
                      'Wed',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                //
                //
                Expanded(
                  child: Center(
                    child: Text(
                      'Fri',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ] else if (dict_save_training_full_data['Frequency'].toString() ==
            'Mon,Wed,Fri') ...[
          Container(
            margin: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            height: 48.0,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      'Mon',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                //
                Expanded(
                  child: Center(
                    child: Text(
                      'Wed',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                //
                //
                Expanded(
                  child: Center(
                    child: Text(
                      'Fri',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ] else if (dict_save_training_full_data['Frequency'].toString() ==
            'Tue,Thu,Sat') ...[
          Container(
            margin: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            height: 48.0,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      'Tue',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                //
                Expanded(
                  child: Center(
                    child: Text(
                      'Thu',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                //
                //
                Expanded(
                  child: Center(
                    child: Text(
                      'Sat',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]
        //
        else if (dict_save_training_full_data['Frequency'].toString() ==
            'Every Saturday') ...[
          Container(
            margin: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            height: 48.0,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      'Every Saturday',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        ] else if (dict_save_training_full_data['Frequency'].toString() ==
            'Daily') ...[
          Container(
            margin: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            height: 48.0,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(
                14,
              ),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      'Daily',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        ],
        //
        const SizedBox(
          height: 20,
        ),
        Text(
          'REMINDER',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        //
        Container(
          margin: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          height: 48.0,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 71, 71, 71),
            borderRadius: BorderRadius.circular(
              14,
            ),
          ),
          child: Row(
            children: const <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    //
                    'DATE',
                    //
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    //
                    'TIME',
                    //
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              //
            ],
          ),
        ),
        //
        Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          width: MediaQuery.of(context).size.width,
          height: 48.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              14,
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    //
                    get_str_date,
                    //
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    //
                    get_str_time,
                    //
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              //
            ],
          ),
        ),

        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                Text('data'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Frequency'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                    // widget.str_frequncy.toString(),
                    '4'),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Reminder'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      // widget.str_frequncy.toString(),
                      '',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Date : '.toUpperCase(),
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      //
                      get_str_date.toString(),
                      //
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Time : '.toUpperCase(),
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      //
                      get_str_time.toString(),
                      //
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),*/
      ],
    );
  }

  SingleChildScrollView tab_1_info_UI(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          header_UI(context),
          //

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              // margin: const EdgeInsets.all(
              //   20.0,
              // ),
              // height: 40,
              width: MediaQuery.of(context).size.width,
              // color: Colors.pink,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.pink,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Category'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        //
                        dict_save_training_full_data['categoryName'].toString(),
                        // '5',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Container(
                    height: .5,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Actions'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        //
                        'Training'.toUpperCase(),
                        //
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    height: .5,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),

                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Skill Name'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        //
                        dict_save_training_full_data['skillName']
                            .toString()
                            .toUpperCase(),
                        // '6'
                        //
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    height: .5,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Training Name'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        dict_save_training_full_data['TrainingName']
                            .toString()
                            .toUpperCase(),
                        // '77',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Container(
                    height: .5,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Frequncy'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        dict_save_training_full_data['Frequency']
                            .toString()
                            .toUpperCase(),
                        // '8',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    height: .5,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'T Stats'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        dict_save_training_full_data['TStats']
                            .toString()
                            .toUpperCase(),
                        // '9',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  /*Container(
                    height: .5,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Description :'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 18,
                        bottom: 18.0,
                        right: 18.0,
                      ),
                      child: Text(
                        //
                        widget.str_description.toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 16.0,
                        ),
                        //
                      ),
                    ),
                  ),*/
                  Container(
                    height: .5,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column header_UI(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.amber,
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
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: Image.network(
                  dict_save_training_full_data['image'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 200 - 30,
                width: 2,
                color: Colors.transparent,
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  // height: 180,
                  // width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text_bold_style_custom(
                        //
                        dict_save_training_full_data['skillName'].toString(),
                        Colors.white,
                        16.0,
                      ), //
                      const SizedBox(
                        height: 8.0,
                      ),
                      text_regular_style_custom(
                        'Total Exp : 0',
                        Colors.white,
                        14.0,
                      ),
                      //
                      const SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8,
                            ),
                          ),
                          // border: Border.all(),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            //
                            Image.asset(
                              'assets/images/btn_round.png',
                              height: 50,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                            //
                            text_regular_style_custom(
                              'Level : ${dict_save_training_full_data['currentLavel'].toString()}',
                              Colors.black,
                              12.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              /*Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 10.0,
                  ),
                  height: 200 - 30,
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              //
                              dict_save_training_full_data['skillName']
                                  .toString()
                                  .toUpperCase(),
                              // '12',
                              //
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              Container(
                                child: Image.asset(
                                  'assets/images/btn_round.png',
                                  height: 140,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      8,
                                    ),
                                  ),
                                  // border: Border.all(),
                                ),
                              ),
                              Positioned(
                                child: Center(
                                  child: Text(
                                    //
                                    'Level : ${dict_save_training_full_data['currentLavel']}',
                                    //
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: font_style_name,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // top: 45,
                                // left: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
            ],
          ),
        ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(
            2,
            26,
            78,
            1,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text_bold_style_custom(
                        'SKILLS CLASS : ',
                        Colors.white,
                        14.0,
                      ),
                      text_regular_style_custom(
                        //
                        strNewSkillClass,
                        Colors.white,
                        14.0,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                width: 1,
                color: Colors.grey,
              ),
              Expanded(
                child: Align(
                  child: Text(
                    'Next LV XP : ${dict_save_training_full_data['TrainingLV']}',
                    // '15',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(
            250,
            0,
            28,
            1,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    routine_list_WB();
                  },
                  child: Container(
                    height: 80,
                    width: 120,
                    decoration: (str_bottom_bar_color == 'routine_click')
                        ? const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 3,
                              ),
                            ),
                          )
                        : const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 0,
                              ),
                            ),
                          ),
                    child: Align(
                      child: text_regular_style_custom(
                        'Routine',
                        Colors.white,
                        14.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    check_list_WB();
                  },
                  child: Container(
                    height: 80,
                    width: 120,
                    // color: Colors.transparent,
                    decoration: (str_bottom_bar_color == 'check_list_click')
                        ? const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 3,
                              ),
                            ),
                          )
                        : const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 0,
                              ),
                            ),
                          ),
                    child: Align(
                      child: text_regular_style_custom(
                        'Check List',
                        Colors.white,
                        14.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    str_UI_show = 'stats';
                    str_bottom_bar_color = 'stats_click';
                    setState(() {});
                  },
                  child: Container(
                    height: 80,
                    width: 120,
                    decoration: (str_bottom_bar_color == 'stats_click')
                        ? const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 3,
                              ),
                            ),
                          )
                        : const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 0,
                              ),
                            ),
                          ),
                    child: Align(
                      child: text_regular_style_custom(
                        'Stats',
                        Colors.white,
                        14.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    str_UI_show = 'frequency';
                    str_bottom_bar_color = 'frequency_click';
                    setState(() {});
                  },
                  child: Container(
                    height: 80,
                    width: 120,
                    decoration: (str_bottom_bar_color == 'frequency_click')
                        ? const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 3,
                              ),
                            ),
                          )
                        : const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 0,
                              ),
                            ),
                          ),
                    child: Align(
                      child: text_regular_style_custom(
                        'Frequency',
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
      ],
    );
  }

  ////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///// NOTES
  Future func_notes_WB() async {
    print('=====> POST : NOTES 1');

    str_UI_show = 'notes';
    str_bottom_bar_color = '0';
    setState(() {});

    setState(() {
      str_main_loader = 'notes_loader_start';
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
      body: jsonEncode(
        <String, String>{
          'action': 'notelist',
          'pageNo': '',
          'profesionalId': widget.str_training_id.toString(),
          'profesionalType': 'Training',
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
  Future func_quotes_WB() async {
    if (kDebugMode) {
      print('=====> POST : QUOTES');
    }

    str_UI_show = 'notes';
    str_bottom_bar_color = '0';

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
          'profesionalId': widget.str_training_id.toString(),
          'profesionalType': 'Training',
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

// add quotes
  Future<void> add_quotes_push_via_future(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddQuotesScreen(
          str_add_quotes_main_id: widget.str_skill_id.toString(),
          str_profession_type: 'Training'.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_add_quotes') {
      // arr_notes_list.clear();
      // str_quotes = '0';
      setState(() {});
      print('YES I CAME FROM ADD QUOTE');
      func_quotes_WB();
    }
  }

  // add note
  Future<void> push_to_create_notes(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNotesInGoalScreen(
          str_profession_id: widget.str_skill_id.toString(),
          str_profession_type: 'Training'.toString(),
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

                    edit_quote(context);
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

                    delete_goal_quotes_POPUP(str_name);
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

                    edit_quote(context);
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
                //delete_check_list_server
              },
            ),
          ],
        );
      },
    );
  }

  // delete goal
  delete_goal_WB(
    String quote_id,
  ) async {
    if (kDebugMode) {
      print('=====> POST : DELETE QUOTES');
    }

    setState(() {
      str_loader_title = '0';
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
        func_quotes_WB();
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

  Future<void> edit_quote(BuildContext context) async {
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
        func_quotes_WB();
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

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotesInGoalScreen(
          str_message: str_get_message,
          str_note_id: str_note_id.toString(),
          str_professional_id: str_profession_id.toString(),
          str_professional_type: 'Training'.toString(),
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

  // push
  func_push_from_floating_button() {
    if (kDebugMode) {
      print('floating action button click');
    }
    if (kDebugMode) {
      print(str_UI_show);
    }
    if (str_UI_show == 'notes') {
      if (kDebugMode) {
        print('add note');
      }
      push_to_create_notes(context);
    } else if (str_UI_show == 'routine') {
      if (kDebugMode) {
        print('add routine 2');
      }
      push_to_add_routine(context);
    } else if (str_UI_show == 'quotes') {
      if (kDebugMode) {
        print('add quote');
      }
      add_quotes_push_via_future(context);
    } else if (str_UI_show == 'check_list') {
      if (kDebugMode) {
        print('add check list');
      }
      push_to_add_check_list(context);
    }
  }

  Future<void> push_to_edit_check_list(
      BuildContext context, training_data) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCheckListScreen(
          str_training_id_check_list:
              dict_save_training_full_data['trainingId'].toString(),
          get_dict_training_data: training_data,
        ),
      ),
    );

    print('result =====> ' + result);

    if (!mounted) return;

    check_list_WB();
  }

  Future<void> push_to_add_check_list(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCheckListScreen(
          str_training_id_check_list:
              dict_save_training_full_data['trainingId'].toString(),
          get_dict_training_data: '',
        ),
      ),
    );

    print('result =====> ' + result);

    if (!mounted) return;

    check_list_WB();
  }

  Future<void> push_to_add_routine(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRoutineScreen(
          str_professional_id:
              dict_save_training_full_data['trainingId'].toString(),
          // widget.str_training_id.toString(),
        ),
      ),
    );

    print('result =====> ' + result);

    if (!mounted) return;

    routine_list_WB();
  }

  // routine list
  routine_list_WB() async {
    print('=====> POST : ROUTINE LIST');

    str_UI_show = 'routine';
    str_bottom_bar_color = 'routine_click';
    str_main_loader = 'routine_loader_start';
    setState(() {});

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'routinelist',
          'profesionalId':
              dict_save_training_full_data['trainingId'].toString(),
          // 'profesionalId': '5'.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        arr_routine_list.clear();

        for (Map i in get_data['data']) {
          arr_routine_list.add(i);
        }

        if (arr_routine_list.isEmpty) {
          setState(() {
            str_main_loader = 'routine_loader_empty';
          });
        } else {
          setState(() {
            str_main_loader = 'routine_loader_stop';
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

  //
  // check list
  check_list_WB() async {
    print('=====> POST : CHECK LIST');

    str_UI_show = 'check_list';
    str_bottom_bar_color = 'check_list_click';
    str_main_loader = 'check_list_loader_start';
    setState(() {});

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'checklist',
          'profesionalId':
              dict_save_training_full_data['trainingId'].toString(),
          // 'profesionalId': '5'.toString(),
          'profesionalType': 'Training'.toString(),
          'pageNo': '1'.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        arr_check_list.clear();

        for (Map i in get_data['data']) {
          arr_check_list.add(i);
        }

        if (arr_check_list.isEmpty) {
          setState(() {
            str_main_loader = 'check_list_loader_empty';
          });
        } else {
          setState(() {
            str_main_loader = 'check_list_loader_stop';
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

// DELETE ALERT
  Future<void> delete_check_list_WB(
    String str_title,
    str_check_list_id,
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
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            ' Are you sure you want to delete this checklist?',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
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
                print('yes delete');

                delete_check_list_server(str_check_list_id);
              },
            ),
          ],
        );
      },
    );
  }

  // delete check list
  // delete goal
  delete_check_list_server(
    String check_list_id,
  ) async {
    print('=====> POST : DELETE CHECKLIST');

    str_UI_show = 'check_list';
    str_bottom_bar_color = 'check_list_click';
    str_main_loader = 'check_list_loader_start';
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
          'action': 'checklistdelete',
          'userId': prefs.getInt('userId').toString(),
          'checklistId': check_list_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        check_list_WB();
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
