// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/language_translate_texts/language_translate_text.dart';
import 'package:journey_recorded/grind/create_grind/create_grind.dart';
import 'package:journey_recorded/grind/grind_details/grind_details.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrindScreen extends StatefulWidget {
  const GrindScreen({super.key});

  @override
  State<GrindScreen> createState() => _GrindScreenState();
}

class _GrindScreenState extends State<GrindScreen> {
  //
  var strUserSelectLanguage = 'en';
  final ConvertLanguage languageTextConverter = ConvertLanguage();
  //
  var strCategory = '';
  var strSkills = '';
  //
  var strGrindLoader = '0';
  var strSkillLoader = '0';
  var arrGrindList = [];
  //
  var str_category_id = '';
  var strCategoryName = '';
  var strFilterName = '';
  var arr_get_category_list = [];
  //
  var arr_skills_list = [];
  var str_skill_id = '';
  var str_skill_name = '';
  var str_training_id = '';
  var str_training_count = '0';
  //
  var str_priority_count = '';
  var str_priority_loader = '';
  var str_none_loader = '0';
  //
  var strPriorityCount = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];
  //
  @override
  void initState() {
    super.initState();
    //
    funcSelectLanguage();
    get_category_list_WB();
    //
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

  getGrindWB() async {
    if (kDebugMode) {
      print('=====> POST : MISSION LIST');
    }

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
          'action': 'grindlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '1'
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
        //
        arrGrindList.clear();
        //
        for (var i = 0; i < getData['data'].length; i++) {
          arrGrindList.add(getData['data'][i]);
        }
        //
        if (arrGrindList.isEmpty) {
          strGrindLoader = '1';
        } else {
          strGrindLoader = '3';
        }
        setState(() {
          str_none_loader = '0';
        });
        //
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
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
    //
    // get mission details

    //
    return Scaffold(
      appBar: AppBar(
        title: (strUserSelectLanguage == 'en')
            ? text_bold_style_custom(
                //
                grind_navigation_en,
                Colors.white,
                16.0,
              )
            : text_bold_style_custom(
                //
                grind_navigation_sp,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          pushToCreateGrind(context);
          //
        },
        backgroundColor: navigation_color,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 160,
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
                    height: 140,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/task_bg.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(
                        14.0,
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
                      color: const Color.fromRGBO(
                        240,
                        20,
                        74,
                        1,
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      //
                                      open_category_list(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Center(
                                        child: text_regular_style_custom(
                                          //
                                          languageTextConverter
                                              .funcConvertLanguage(
                                            'grind_category',
                                            strUserSelectLanguage,
                                          ),
                                          Colors.white,
                                          14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      //
                                      openPriorityPopup(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Center(
                                        child: (str_priority_loader == '1')
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : text_regular_style_custom(
                                                //
                                                languageTextConverter
                                                    .funcConvertLanguage(
                                                  'grind_priority',
                                                  strUserSelectLanguage,
                                                ),
                                                Colors.white,
                                                14.0,
                                              ),
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
                                  child: GestureDetector(
                                    onTap: () {
                                      //
                                      skillListWB();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Center(
                                        child: (strSkillLoader == '1')
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : text_regular_style_custom(
                                                //
                                                languageTextConverter
                                                    .funcConvertLanguage(
                                                  'grind_skills',
                                                  strUserSelectLanguage,
                                                ),
                                                Colors.white,
                                                14.0,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      //
                                      setState(() {
                                        str_none_loader = '1';
                                      });
                                      get_category_list_WB();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Center(
                                        child: (str_none_loader == '1')
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : text_regular_style_custom(
                                                //
                                                languageTextConverter
                                                    .funcConvertLanguage(
                                                  'grind_none',
                                                  strUserSelectLanguage,
                                                ),
                                                Colors.white,
                                                14.0,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Most Recent',
                                        style: TextStyle(
                                          fontFamily: font_style_name,
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'None',
                                        style: TextStyle(
                                          fontFamily: font_style_name,
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            if (strGrindLoader == '0') ...[
              //
              const CustomeLoaderPopUp(
                str_custom_loader: 'Please wait...',
                str_status: '0',
              ),
              //
            ] else if (strGrindLoader == '1') ...[
              //
              const CustomeLoaderPopUp(
                str_custom_loader: 'Grind not Added Yet.',
                str_status: '4',
              ),
              //
            ] else ...[
              //
              Container(
                // width: MediaQuery.of(context).size.width,
                height: 60.0,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(
                    246,
                    200,
                    68,
                    1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffDDDDDD),
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      color: Colors.transparent,
                      // width: MediaQuery.of(context).size.width,
                      // height: 60.0,
                      child: (strUserSelectLanguage == 'en')
                          ? text_bold_style_custom(
                              //
                              grind_navigation_en,
                              Colors.black,
                              16.0,
                            )
                          : text_bold_style_custom(
                              //
                              grind_navigation_sp,
                              Colors.black,
                              16.0,
                            ),
                    ),
                    //
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.transparent,
                      width: 120,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (kDebugMode) {
                                print('object1');
                              }
                            },
                            icon: const Icon(
                              Icons.check_box,
                              color: Colors.pink,
                              size: 30,
                            ),
                          ),
                          //
                          (strUserSelectLanguage == 'en')
                              ? text_bold_style_custom(
                                  //
                                  grind_expect_en,
                                  Colors.black,
                                  16.0,
                                )
                              : text_bold_style_custom(
                                  //
                                  grind_expect_sp,
                                  Colors.black,
                                  16.0,
                                ),
                        ],
                      ),
                    ),
                    //
                    /*IconButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('object1');
                        }
                        //
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),*/
                  ],
                ),
              ),
              for (int i = 0; i < arrGrindList.length; i++) ...[
                InkWell(
                  onTap: () {
                    if (kDebugMode) {
                      print('asas');
                    }
                    //
                    grindDetails(context, i);
                    //
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        color: Colors.transparent,
                        // width: MediaQuery.of(context).size.width,
                        // height: 60.0,
                        child: text_with_semi_bold_style_black(
                          //
                          arrGrindList[i]['grindName'].toString(),
                          //
                        ),
                      ),
                      //
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        color: Colors.transparent,
                        // width: 120,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ),
                              ),
                              child: Center(
                                child: text_bold_style_custom(
                                  //
                                  arrGrindList[i]['total_completed_Count']
                                      .toString(),
                                  Colors.white,
                                  14.0,
                                ),
                              ),
                            ),
                            //
                            const SizedBox(
                              width: 30.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                //
                                // print(arrGrindList[i]);
                                //
                                addOneGrindWB(
                                  arrGrindList[i]['grindId'].toString(),
                                  arrGrindList[i]['categoryId'].toString(),
                                  arrGrindList[i]['time_to_complete']
                                      .toString(),
                                  arrGrindList[i]['grindName'].toString(),
                                );
                                //
                              },
                              child: Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  color: navigation_color,
                                  borderRadius: BorderRadius.circular(
                                    12.0,
                                  ),
                                ),
                                child: Center(
                                  child: text_bold_style_custom(
                                    arrGrindList[i]['no_of_time_to_complete']
                                        .toString(),
                                    Colors.white,
                                    14.0,
                                  ),
                                ),
                              ),
                            ),
                            /*IconButton(
                              onPressed: () {
                                if (kDebugMode) {
                                  print('object1');
                                }
                                //
                                deleteGrindPopUp(
                                  arrGrindList[i]['grindName'].toString(),
                                  arrGrindList[i]['grindId'].toString(),
                                );
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),*/
                          ],
                        ),
                      ),
                      //
                    ],
                  ),
                ),
                //
                Container(
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width,
                  height: 1.0,
                ),
              ]
              //
            ],
          ],
        ),
      ),
    );
  }

  //
  Future<void> pushToCreateGrind(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateGrindScreen(
            // str_goal_id: widget.str_get_goal_id.toString(),
            ),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    print('hello 1');
    if (!mounted) return;
    print('hello 2');
    if (result == 'back_from_create_grind') {
      setState(() {
        strGrindLoader = '0';
        getGrindWB();
      });
    } else {
      //

      //
    }
  }

  //
  Future<void> grindDetails(BuildContext context, i) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GrindDetailsScreen(
          dictShowFullData: arrGrindList[i],
        ),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    print('hello 1');
    if (!mounted) return;
    print('hello 2');
    if (result == 'back_from_create_grind' ||
        result == 'successfully_deleted') {
      setState(() {
        strGrindLoader = '0';
        getGrindWB();
      });
    } else {
      //

      //
    }
  }

  //
  // delete grind
  addOneGrindWB(
    getGrindId,
    categoryId,
    totalPoint,
    name,
  ) async {
    if (kDebugMode) {
      print('=====> POST : ADD GRINDS');
    }

    setState(() {
      strGrindLoader = '0';
    });
    //
    print('qwerty');
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
          'action': 'grandadd',
          'userId': prefs.getInt('userId').toString(),
          'grindId': getGrindId.toString(),
          'grindName': name.toString(),
          'categoryId': categoryId.toString(),
          'totalPoint': totalPoint.toString(),
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
        //
        getGrindWB();
        //
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
      if (kDebugMode) {
        print('something went wrong');
      }
    }
  }

  Future<void> pushToGridDetails(BuildContext context, i) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GrindDetailsScreen(
          dictShowFullData: arrGrindList[i],
        ),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    if (!mounted) return;

    if (result == 'successfully_deleted') {
      setState(() {
        strGrindLoader = '0';
        getGrindWB();
      });
    } else {
      //
      print('error while refreshing');
      //
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
    var getData = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
        arr_get_category_list = getData['data'];
        getGrindWB();
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  void open_category_list(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: text_bold_style_custom(
          'Categories',
          Colors.black,
          16.0,
        ),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          //
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () {
              Navigator.pop(context);
              str_category_id = '';
              strCategoryName = '';
              //
            },
            child: text_regular_style_custom(
              'All',
              Colors.black,
              16.0,
            ),
          ),
          //
          for (int i = 0; i < arr_get_category_list.length; i++) ...[
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                //
                filterByCategoryWB();
                //
                str_category_id = arr_get_category_list[i]['id'].toString();
                strCategoryName = arr_get_category_list[i]['name'].toString();
              },
              child: text_regular_style_custom(
                //
                arr_get_category_list[i]['name'].toString(),
                Colors.black,
                14.0,
              ),
            ),
          ],
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: text_bold_style_custom(
              //
              languageTextConverter.funcConvertLanguage(
                //
                'alert_dismiss',
                strUserSelectLanguage,
              ),
              Colors.purple,
              12.0,
            ),
          ),
        ],
      ),
    );
  }

  filterByCategoryWB() async {
    if (kDebugMode) {
      print('=====> POST : CATEGORY');
    }

    setState(() {
      strGrindLoader = '0';
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
          'action': 'grindlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '1',
          'categoryId': str_category_id.toString(),
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
        //
        arrGrindList.clear();
        //
        for (var i = 0; i < getData['data'].length; i++) {
          arrGrindList.add(getData['data'][i]);
        }

        setState(() {
          //
          if (arrGrindList.isEmpty) {
            strGrindLoader = '1';
          } else {
            strGrindLoader = '3';
          }
        });
        //
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
      if (kDebugMode) {
        print('something went wrong');
      }
    }
  }

  ///
  ///
  ///
  ///
  //
  skillListWB() async {
    print('=====> POST : SKILL');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      strSkillLoader = '1';
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
          'action': 'skilllist',
          'userId': prefs.getInt('userId').toString(),
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    print(getData);

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
        arr_skills_list = getData['data'];
        open_skill_list(context);
        setState(() {
          strSkillLoader = '0';
        });
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  void open_skill_list(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: text_bold_style_custom(
          //
          languageTextConverter.funcConvertLanguage(
            'grind_skills',
            strUserSelectLanguage,
          ),
          Colors.black,
          12.0,
        ),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          //

          for (int i = 0; i < arr_skills_list.length; i++) ...[
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);

                //
                print(arr_skills_list[i]);
                if (arr_skills_list[i]['TrainingList'].length == 0) {
                  //
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      closeIconColor: Colors.amber,
                      content: text_regular_style_custom(
                        'Training not added yet',
                        Colors.white,
                        14.0,
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                } else {
                  //
                  str_skill_id = arr_skills_list[i]['skillId'].toString();
                  str_skill_name = arr_skills_list[i]['SkillName'].toString();
                }
              },
              child: text_regular_style_custom(
                //
                arr_skills_list[i]['SkillName'].toString(),
                Colors.black,
                16.0,
              ),
            ),
          ],
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: text_bold_style_custom(
              //
              languageTextConverter.funcConvertLanguage(
                //
                'alert_dismiss',
                strUserSelectLanguage,
              ),
              Colors.purple,
              12.0,
            ),
          ),
        ],
      ),
    );
  }

  //
  void openPriorityPopup(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: text_bold_style_custom(
          'Priority',
          Colors.black,
          16.0,
        ),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          //
          for (int i = 0; i < strPriorityCount.length; i++) ...[
            CupertinoActionSheetAction(
              onPressed: () async {
                //
                gridListByPriorityWB(strPriorityCount[i].toString());
                Navigator.pop(context);
              },
              child: text_regular_style_custom(
                //
                strPriorityCount[i].toString(),
                Colors.black,
                16.0,
              ),
            ),
          ],
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: text_bold_style_custom(
              //
              languageTextConverter.funcConvertLanguage(
                //
                'alert_dismiss',
                strUserSelectLanguage,
              ),
              Colors.purple,
              12.0,
            ),
          ),
        ],
      ),
    );
  }

  //
  gridListByPriorityWB(priorityText) async {
    print('=====> POST : PRIORITY');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      str_priority_loader = '1';
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
          'action': 'skilllist',
          'userId': prefs.getInt('userId').toString(),
          'priority': priorityText.toString(),
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    print(getData);

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
        arr_skills_list = getData['data'];
        //
        setState(() {
          str_priority_loader = '0';
        });
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }
}
