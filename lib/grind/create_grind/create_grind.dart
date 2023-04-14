// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/app_bar/app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateGrindScreen extends StatefulWidget {
  const CreateGrindScreen({super.key});

  @override
  State<CreateGrindScreen> createState() => _CreateGrindScreenState();
}

class _CreateGrindScreenState extends State<CreateGrindScreen> {
  //
  var str_category_id = '0';
  var strScreenLoader = '0';
  var strCreateGrindLoader = '0';
  var strRelatedSkillLoader = '0';
  var strRelatedHabitLoader = '0';
  var strSaveRelatedSkillId = '';
  var strSaveRelatedHabitId = '';
  var arr_get_category_list = [];
  var arrRelatedSkills = [];
  var arrRelatedHabit = [];
  //
  final formKey = GlobalKey<FormState>();
  late final TextEditingController contGrindName;
  late final TextEditingController contGrindCategory;
  late final TextEditingController contGrindTime;
  late final TextEditingController contGrindPriority;
  late final TextEditingController contGrindRelatedSkill;
  late final TextEditingController contGrindRelatedHabit;
  late final TextEditingController contGrindDescription;
  //
  @override
  void initState() {
    contGrindName = TextEditingController();
    contGrindCategory = TextEditingController();
    contGrindTime = TextEditingController();
    contGrindPriority = TextEditingController();
    contGrindRelatedSkill = TextEditingController();
    contGrindRelatedHabit = TextEditingController();
    contGrindDescription = TextEditingController();

    super.initState();

    //
    getCategoryList();
  }

  @override
  void dispose() {
    contGrindName.dispose();
    contGrindCategory.dispose();
    contGrindTime.dispose();
    contGrindPriority.dispose();
    contGrindRelatedSkill.dispose();
    contGrindRelatedHabit.dispose();
    contGrindDescription.dispose();

    super.dispose();
  }

  // get category list
  getCategoryList() async {
    if (kDebugMode) {
      print('=====> POST : GET CATEGORY');
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
          'action': 'category',
          // 'userId': prefs.getInt('userId').toString(),
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    // print(get_data['data']);
    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
        arr_get_category_list = getData['data'];

        setState(() {
          strScreenLoader = '1';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: navigation_title_create_grind,
        str_back_button_status: '1',
      ),
      body: (strScreenLoader == '0')
          ? const Align(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffDDDDDD),
                            blurRadius: 6.0,
                            spreadRadius: 2.0,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: TextFormField(
                          controller: contGrindName,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name',
                          ),

                          // validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter grind name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    //
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffDDDDDD),
                            blurRadius: 6.0,
                            spreadRadius: 2.0,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: contGrindCategory,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            border: InputBorder.none,
                            hintText: 'Category',
                          ),
                          onTap: () {
                            category_list_POPUP('str_message');
                          },
                          // validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select category';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    //
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffDDDDDD),
                            blurRadius: 6.0,
                            spreadRadius: 2.0,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: TextFormField(
                          controller: contGrindTime,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Time to complete the activity',
                          ),
                          // validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some data';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    //
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffDDDDDD),
                            blurRadius: 6.0,
                            spreadRadius: 2.0,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: TextFormField(
                          controller: contGrindPriority,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Priority',
                          ),
                          // validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter priority';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    //
                    if (strRelatedSkillLoader == '1') ...[
                      const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: CircularProgressIndicator(
                          color: Colors.pink,
                        ),
                      ),
                    ] else ...[
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            14,
                          ),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffDDDDDD),
                              blurRadius: 6.0,
                              spreadRadius: 2.0,
                              offset: Offset(0.0, 0.0),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: contGrindRelatedSkill,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Related skill',
                            ),
                            onTap: () {
                              //
                              (contGrindCategory.text == '')
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        closeIconColor: Colors.amber,
                                        content: Text(
                                          'Alert : Please select category',
                                        ),
                                      ),
                                    )
                                  : get_skills_list_WB();

                              //
                            },
                          ),
                        ),
                      )
                    ],
                    //
                    (strRelatedHabitLoader == '1')
                        ? const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                14,
                              ),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xffDDDDDD),
                                  blurRadius: 6.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: TextFormField(
                                readOnly: true,
                                controller: contGrindRelatedHabit,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Related habit',
                                ),
                                onTap: () {
                                  //
                                  (contGrindCategory.text == '')
                                      ? ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          const SnackBar(
                                            closeIconColor: Colors.amber,
                                            content: Text(
                                              'Alert : Please select category',
                                            ),
                                          ),
                                        )
                                      : getHabitListWB();

                                  //
                                },
                              ),
                            ),
                          ),
                    //
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          14,
                        ),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffDDDDDD),
                            blurRadius: 6.0,
                            spreadRadius: 2.0,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: TextFormField(
                          controller: contGrindDescription,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Description',
                          ),
                          // validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter description';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

                    //
                    (strCreateGrindLoader == '1')
                        ? const CircularProgressIndicator()
                        : InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                //
                                funcCreateGrind();
                                //
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(content: Text('Processing Data')),
                                // );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(
                                10.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ),
                                color: const Color.fromRGBO(
                                  250,
                                  42,
                                  18,
                                  1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                      0,
                                      3,
                                    ), // changes position of shadow
                                  ),
                                ],
                              ),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  'Save and Continue',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
    );
  }

  //
  // create grind
  funcCreateGrind() async {
    setState(() {
      strCreateGrindLoader = '1';
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
      /*
      [action] => grandadd
    [userId] => 2
    [Priority] => sbd
    [grindName] => dhd
    [categoryId] => 1
    [Descrption] => ebd
    [time_to_complete] => 20
    */
      body: jsonEncode(
        <String, String>{
          'action': 'grandadd',
          'userId': prefs.getInt('userId').toString(),
          'Priority': contGrindPriority.text.toString(),
          'grindName': contGrindName.text.toString(),
          'categoryId': str_category_id.toString(),
          'Descrption': contGrindDescription.text.toString(),
          'time_to_complete': contGrindTime.text.toString(),
          'skillId': strSaveRelatedSkillId.toString(),
          'habitId': strSaveRelatedHabitId.toString(),
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

        setState(() {
          strCreateGrindLoader = '0';
          Navigator.pop(context, 'back_from_create_grind');
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
                          //
                          str_category_id =
                              arr_get_category_list[index]['id'].toString();
                          //
                          contGrindCategory.text =
                              arr_get_category_list[index]['name'].toString();
                          //
                          setState(() {});
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

  //

  // get skills
  get_skills_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : SKILLS LIST');
    }

    setState(() {
      strRelatedSkillLoader = '1';
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
        arrRelatedSkills.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          //
          arrRelatedSkills.add(get_data['data'][i]);
          //
        }

        if (arrRelatedSkills.isEmpty) {
          //
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Skill not found')),
          );
          //
          setState(() {
            strRelatedSkillLoader = '0';
          });
          //
        } else {
          setState(() {
            strRelatedSkillLoader = '0';
          });
          //
          openRelatedSkillPopUp('Please select skills');
          //
        }
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

  // ALERT
  Future<void> openRelatedSkillPopUp(
    String str_message,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: text_with_bold_style_black(
            str_message.toString(),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: ListView.builder(
                    itemCount: arrRelatedSkills.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          if (kDebugMode) {
                            print(arrRelatedSkills[index]['TrainingCount']
                                .toString());
                          }
                          if (arrRelatedSkills[index]['TrainingCount'] == 0) {
                            contGrindRelatedSkill.text = '';
                            strSaveRelatedSkillId = '';
                          } else {
                            contGrindRelatedSkill.text =
                                arrRelatedSkills[index]['SkillName'].toString();
                            strSaveRelatedSkillId =
                                arrRelatedSkills[index]['skillId'].toString();
                          }
                          //
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: text_with_regular_style(
                                '${index + 1}. ${arrRelatedSkills[index]['SkillName'].toString()}',
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: (arrRelatedSkills[index]
                                          ['TrainingCount'] ==
                                      0)
                                  ? Text(
                                      '      No training found',
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 14.0,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    ),
                            ),
                            //
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              color: Colors.grey,
                              width: MediaQuery.of(context).size.width,
                              height: 0.4,
                            )
                          ],
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
              child: const Text(
                'Dismiss',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // HABIT
  // get skills
  getHabitListWB() async {
    if (kDebugMode) {
      print('=====> POST : HABIT LIST');
    }

    setState(() {
      strRelatedHabitLoader = '1';
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
          'action': 'habitlist',
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
        arrRelatedHabit.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          //
          arrRelatedHabit.add(get_data['data'][i]);
          //
        }

        if (arrRelatedHabit.isEmpty) {
          //
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Habit not found',
              ),
            ),
          );
          //
          setState(() {
            strRelatedHabitLoader = '0';
          });
          //
        } else {
          setState(() {
            strRelatedHabitLoader = '0';
          });
          //
          openRelatedHabitPopUp('Please select habits');
          //
        }
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

  // ALERT
  Future<void> openRelatedHabitPopUp(
    String str_message,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: text_with_bold_style_black(
            str_message.toString(),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: ListView.builder(
                    itemCount: arrRelatedHabit.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          // if (kDebugMode) {
                          //   print(arrRelatedHabit[index]['TrainingCount']
                          //       .toString());
                          // }

                          contGrindRelatedHabit.text =
                              arrRelatedHabit[index]['name'].toString();
                          strSaveRelatedHabitId =
                              arrRelatedHabit[index]['habitId'].toString();

                          //
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: text_with_regular_style(
                                '${index + 1}. ${arrRelatedHabit[index]['name'].toString()}',
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: (arrRelatedHabit[index]
                            //               ['TrainingCount'] ==
                            //           0)
                            //       ? Text(
                            //           '      No training found',
                            //           style: TextStyle(
                            //             fontFamily: font_style_name,
                            //             fontSize: 14.0,
                            //             // fontWeight: FontWeight.bold,
                            //             color: Colors.red,
                            //           ),
                            //         )
                            //       : const SizedBox(
                            //           height: 0,
                            //         ),
                            // ),
                            //
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              color: Colors.grey,
                              width: MediaQuery.of(context).size.width,
                              height: 0.4,
                            )
                          ],
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
              child: const Text(
                'Dismiss',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
