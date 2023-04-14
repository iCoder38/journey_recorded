// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/popup/popup.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:journey_recorded/skills/create_skills/create_skills.dart';
import 'package:journey_recorded/training/create_task/create_training.dart';
import 'package:journey_recorded/training/skill_training_list.dart';
import 'package:journey_recorded/training/training_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  //
  var str_search_text = 'All';
  //
  var str_category_loader = '0';
  var arr_get_category_list = [];
  var str_category_id = 'n.a.';
  //
  var str_main_loader = '0';
  var arr_skills = [];

  //
  var str_all_click = '1';
  var str_by_level_click = '0';
  //
  var str_hide_loader = '0';
  //
  @override
  void initState() {
    super.initState();
    //
    get_category_list_WB();
    //
  }

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

        //
        get_skills_list_WB('');
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

// get skills
  get_skills_list_WB(str_category_id) async {
    if (kDebugMode) {
      print('=====> POST : SKILLS LIST');
    }

    setState(() {
      str_main_loader = '0';
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
          'action': 'skilllist',
          'userId': prefs.getInt('userId').toString(),
          'categoryId': str_category_id.toString(),
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
        //
        arr_skills.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          //
          arr_skills.add(get_data['data'][i]);
          //
        }

        //

        if (str_hide_loader == '1') {
          str_hide_loader = '0';
          Navigator.of(context).pop('');
        }

        setState(() {
          str_main_loader = '1';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              //
              navigation_title_skills,
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            backgroundColor: navigation_color,
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            /*bottom: TabBar(
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 18.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    2.0,
                  ),
                  child: Text(
                    'By Category',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 18.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'By Level',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 18.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),*/
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: InkWell(
                  onTap: () {
                    push_to_create_skill(context);
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: tabbar_ALL_ui(context),
        ),
      ),
    );
  }

  SingleChildScrollView tabbar_ALL_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: (str_main_loader == '0')
          ? const DialogExample(
              str_alert_text_name: 'please wait...',
            )
          : Column(
              children: [
                Center(
                  child: Container(
                    // margin: const EdgeInsets.all(10.0),
                    color: Colors.amber[600],
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (kDebugMode) {
                                print('all click');
                              }
                              //
                              setState(() {
                                str_all_click = '1';
                                str_by_level_click = '0';
                                str_search_text = 'All';
                              });
                              //
                              get_skills_list_WB('');
                              //
                            },
                            child: Container(
                              // margin: const EdgeInsets.all(10.0),

                              width: 48.0,
                              // height: 48.0,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                border: (str_all_click == '0')
                                    ? const Border(
                                        bottom: BorderSide(
                                          width: 0,
                                        ),
                                        right: BorderSide(
                                          width: 1,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Border(
                                        bottom: BorderSide(
                                          width: 3,
                                        ),
                                        right: BorderSide(
                                          width: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                              child: Center(
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (kDebugMode) {
                                print('by level');
                              }
                              //
                              setState(() {
                                str_all_click = '0';
                                str_by_level_click = '1';
                              });
                              //
                            },
                            child: Container(
                              // margin: const EdgeInsets.all(10.0),

                              width: 48.0,
                              // height: 48.0,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                border: (str_by_level_click == '0')
                                    ? const Border(
                                        bottom: BorderSide(
                                          width: 0,
                                        ),
                                      )
                                    : const Border(
                                        bottom: BorderSide(
                                          width: 3,
                                        ),
                                      ),
                              ),
                              child: Center(
                                child: Text(
                                  'By Level',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //
                Center(
                  child: Container(
                    // margin: const EdgeInsets.all(10.0),
                    color: Colors.amber[600],
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: InkWell(
                      onTap: () {
                        if (kDebugMode) {
                          print('object');
                        }
                        //
                        setState(() {
                          str_all_click = '0';
                          str_by_level_click = '0';
                        });
                        category_list_POPUP('');
                        //
                      },
                      child: Container(
                        margin: const EdgeInsets.all(6),
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
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              //
                              str_search_text.toString(),
                              //
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            //
                            const Spacer(),
                            //
                            IconButton(
                              onPressed: () {
                                if (kDebugMode) {
                                  print('object');
                                }
                                //
                                setState(() {
                                  str_all_click = '0';
                                  str_by_level_click = '0';
                                });
                                //
                                category_list_POPUP('');
                                //
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //
                for (int i = 0; i < arr_skills.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        //
                        // print('object ?');
                        // print(arr_skills[i]);
                        // as
                        if (arr_skills[i]['TrainingCount'].toString() == '0') {
                          //
                          push_add_training(
                              context, arr_skills[i]['skillId'].toString());
                          //
                        } else {
                          //
                          if (kDebugMode) {
                            print(arr_skills[i]);
                            print('object');
                          }
                          //
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrainingListScreen(
                                str_skill_id:
                                    arr_skills[i]['skillId'].toString(),
                                str_training_id:
                                    arr_skills[i]['trainingId'].toString(),
                              ),
                            ),
                          );
                          //
                        }
                        //
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SkillTrainingListScreen(
                        //       str_skill_id: arr_skills[i]['skillId'].toString(),
                        //     ),
                        //   ),
                        // );
                        /**/
                      },
                      child: Container(
                        height: 46,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 20,
                              height: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: (arr_skills[i]['image'].toString() == '')
                                  ? Image.asset('assets/images/logo.png')
                                  : FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/loader.gif',
                                      image: arr_skills[i]['image'].toString(),
                                    ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.transparent,
                                child: Text(
                                  //
                                  arr_skills[i]['SkillName'].toString(),
                                  //
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 18.0,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                right: 0.0,
                              ),
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(
                                  250,
                                  0,
                                  60,
                                  1,
                                ),
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  //
                                  //'Level : ${int.parse(arr_skills[i]['currentLavel'].toString()) + 1}',
                                  'Level : ${int.parse(arr_skills[i]['currentLavel'].toString())}',
                                  //
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (kDebugMode) {
                                  print('');
                                }
                                //
                                show_action_sheet_(
                                  context,
                                  arr_skills[i]['skillId'].toString(),
                                  arr_skills[i],
                                );
                                //
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.pink,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                ],
              ],
            ),
    );
  }

  Container tabbar_CATEGORY_ui(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: Colors.amber,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.abc,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Text(
                'Knitting',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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
              color: const Color.fromRGBO(
                250,
                0,
                60,
                1,
              ),
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ),
            child: Center(
              child: Text(
                'LV:3',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container tabbar_LEVEL_ui(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: Colors.amber,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.abc,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Text(
                'Knitting',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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
              color: const Color.fromRGBO(
                250,
                0,
                60,
                1,
              ),
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ),
            child: Center(
              child: Text(
                'LV:3',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> push_to_create_skill(BuildContext context) async {
    if (kDebugMode) {
      print('object');
    }
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateSkills(
          str_from_profile: 'no',
          dict_data: '',
        ),
      ),
    );

    print('result =====> ' + result);

    if (!mounted) return;

    str_main_loader = '0';
    setState(() {
      get_skills_list_WB('');
    });
  }

  //
  Future<void> push_to_edit_skill(
    BuildContext context,
    get_full_data,
  ) async {
    if (kDebugMode) {
      print('object');
    }
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateSkills(
          str_from_profile: 'yes',
          dict_data: get_full_data,
        ),
      ),
    );

    print('result =====> ' + result);

    if (!mounted) return;

    str_main_loader = '0';
    setState(() {
      get_skills_list_WB('');
    });
  }

// ALERT
  Future<void> category_list_POPUP(
    String str_message,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Please select Category',
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 16.0,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: ListView.builder(
                    itemCount: arr_get_category_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();

                          setState(() {
                            str_category_id =
                                arr_get_category_list[index]['id'].toString();
                            //
                            str_search_text =
                                arr_get_category_list[index]['name'].toString();
                          });
                          //
                          get_skills_list_WB(
                            str_category_id.toString(),
                          );
                          //
                        },
                        child: ListTile(
                          leading: const Icon(
                            Icons.category,
                          ),
                          title: Text(
                            arr_get_category_list[index]['name'].toString(),
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
              ],
              //
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

  //
  void show_action_sheet_(BuildContext context, indexx, full_data) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Skill',
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              //
              func_show_delete_skill_alert(indexx);
              //
            },
            child: Text(
              'Delete',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
                color: Colors.red,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              //
              push_to_edit_skill(
                context,
                full_data,
              );
              //
            },
            child: Text(
              'Edit',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          /*CupertinoActionSheetAction(
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
          ),*/
        ],
      ),
    );
  }

  //
  func_show_delete_skill_alert(get_skill_id) {
    // Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Journey Recorded',
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Are you sure you want to delete this Skill ?',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'yes, delete',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  color: Colors.green,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //
                delete_skill_WB(get_skill_id);
                // loader_show('');
                //
              },
            ),
            TextButton(
              child: Text(
                'dismiss',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
// }
  }

  // show loader
  loader_show(get_user_id) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Align(
                  child: Text(
                    'deleting...',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
// }
  }

  //
  delete_skill_WB(str_category_id) async {
    //
    loader_show('');
    //
    if (kDebugMode) {
      print('=====> POST : SKILLS DELETE');
    }
    str_hide_loader = '1';
    // setState(() {
    //   // str_main_loader = '0';
    // });

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
          'action': 'skilldelete',
          'userId': prefs.getInt('userId').toString(),
          'skillId': str_category_id.toString(),
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

        get_skills_list_WB('');
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

  //
  Future<void> push_add_training(
    BuildContext context,
    get_skill_id,
  ) async {
    //
    print(get_skill_id);
    //
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTrainingScreen(
          str_skill_id: get_skill_id.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'training_added') {
      setState(() {
        str_main_loader = '0';
      });
      //
      get_skills_list_WB('');
      //
    }
  }
}

//

