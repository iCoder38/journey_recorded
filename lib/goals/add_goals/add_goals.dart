// ignore_for_file: non_constant_identifier_names, unused_element

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/language_translate_texts/language_translate_text.dart';
import 'package:journey_recorded/goals/add_goals/add_modal/add_modal.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddGoals extends StatefulWidget {
  const AddGoals({super.key});

  @override
  State<AddGoals> createState() => _AddGoalsState();
}

class _AddGoalsState extends State<AddGoals> {
  //
  var strUserSelectLanguage = 'en';
  final ConvertLanguage languageTextConverter = ConvertLanguage();
  //
  var arr_get_category_list = [];
  //
  var str_goal_for_id = '';
  var str_category_id = '';
  var txt_category = '';
  //
  // password
  late final TextEditingController cont_goal_for;
  // password
  late final TextEditingController cont_name_of_goal;
  // password
  late final TextEditingController cont_deadline;
  // password
  late final TextEditingController cont_notes;
  // password
  late final TextEditingController cont_quest;
  // password
  late final TextEditingController cont_add;
  // password
  late final TextEditingController cont_about;
  // password
  late final TextEditingController cont_category;
  //
  // late SingleValueDropDownController _cnt;
  //
  // MODAL
  final create_goal_service = CreateGoalModals();
  //
  var strGoalFor = '';
  var strGoalCategory = '';
  var strGoalNameOfGoal = '';
  var strGoalDeadline = '';
  var strGoalAboutYourGoal = '';
  var strSaveAndContinue = '';
  //
  @override
  void initState() {
    //
    funcSelectLanguage();
    //
    cont_goal_for = TextEditingController();
    cont_name_of_goal = TextEditingController();
    cont_deadline = TextEditingController();
    cont_notes = TextEditingController();
    cont_quest = TextEditingController();
    cont_add = TextEditingController();
    cont_about = TextEditingController();
    cont_category = TextEditingController();

    get_category_list_WB();
    super.initState();
  }

  @override
  void dispose() {
    cont_goal_for.dispose();
    cont_name_of_goal.dispose();
    cont_deadline.dispose();
    cont_notes.dispose();
    cont_quest.dispose();
    cont_add.dispose();
    cont_about.dispose();
    cont_category.dispose();
    super.dispose();
  }

// /********** LANGUAGE SELECTED **********************************************/
  funcSelectLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strUserSelectLanguage = prefs.getString('selected_language').toString();
    if (kDebugMode) {
      print('user already selected ====> $strUserSelectLanguage');
    }
    //
    funcSetConvertor();
  }

// /********** LANGUAGE SELECTED **********************************************/

  funcSetConvertor() {
    if (strUserSelectLanguage == 'en') {
      //
      strGoalFor = create_goal_goal_for_en;
      strGoalCategory = create_goal_category_en;
      strGoalNameOfGoal = create_goal_name_of_goal_en;
      strGoalDeadline = create_goal_deadline_en;
      strGoalAboutYourGoal = create_goal_about_your_goal_en;
      strSaveAndContinue = str_save_and_continue_en;
    } else {
      //
      strGoalFor = create_goal_goal_for_sp;
      strGoalCategory = create_goal_category_sp;
      strGoalNameOfGoal = create_goal_name_of_goal_sp;
      strGoalDeadline = create_goal_deadline_sp;
      strGoalAboutYourGoal = create_goal_about_your_goal_sp;
      strSaveAndContinue = str_save_and_continue_sp;
    }
    setState(() {});
  }

// get category list
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
          // 'userId': prefs.getInt('userId').toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print('dushu');
    // print(get_data['data']);
    print('dushu');
    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_get_category_list = get_data['data'];
        /*for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data']);
          arr_get_category_list.add(get_data['data']);
        }
        print('dushu');
        print(arr_get_category_list);*/
        // setState(() {});
        /*print('dushu');
        print(arr_get_category_list);
        print('dushu');*/
        setState(() {});
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
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: navigation_color,
          title: text_bold_style_custom(
            //
            languageTextConverter.funcConvertLanguage(
              //
              'create_a_goal',
              strUserSelectLanguage,
            ),
            Colors.white,
            16.0,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    asasas('str_message');
                  },
                  controller: cont_goal_for,
                  //keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    border: const OutlineInputBorder(),
                    hintText: strGoalFor,
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  onTap: () {
                    category_list_POPUP('str_message');
                  },
                  controller: cont_category,
                  //keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down,
                    ),
                    border: const OutlineInputBorder(),
                    hintText: strGoalCategory,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  controller: cont_name_of_goal,
                  // keyboardType: TextInputType.de,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: strGoalNameOfGoal,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  controller: cont_deadline,
                  readOnly: true, // when true user cannot edit text
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: strGoalDeadline,
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      if (kDebugMode) {
                        print(pickedDate);
                      }
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      if (kDebugMode) {
                        print(formattedDate);
                      }

                      setState(() {
                        cont_deadline.text =
                            formattedDate; //set foratted date to TextField value.
                      });
                    } else {
                      if (kDebugMode) {
                        print("Date is not selected");
                      }
                    }
                  },
                ),
              ),
              /*Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  controller: cont_notes,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Notes',
                  ),
                ),
              ),*/
              /*Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  controller: cont_quest,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quest/Mission',
                  ),
                ),
              ),*/
              /*Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  controller: cont_add,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add quote, affirmation, or consequence',
                    labelText: 'Add quote, affirmation, or consequence',
                  ),
                  maxLines: 3,
                ),
              ),*/
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  controller: cont_about,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: strGoalAboutYourGoal,
                  ),
                  maxLines: 3,
                ),
              ),
              InkWell(
                onTap: () {
                  func_save_and_continue_WB();
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
                    child: text_bold_style_custom(
                      //
                      strSaveAndContinue,
                      Colors.white,
                      16.0,
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
  func_save_and_continue_WB() {
    // print(cont_goal_for.text);
    /*if (cont_goal_for.text == '') {
      _showMyDialog('Goal for field should not be empty.');
    } else */
    if (cont_name_of_goal.text == '') {
      _showMyDialog('Name of Goal for field should not be empty.');
    } else if (cont_deadline.text == '') {
      _showMyDialog('Deadline for field should not be empty.');
    } /*else if (cont_notes.text == '') {
      _showMyDialog('Notes for field should not be empty.');
    } else if (cont_quest.text == '') {
      _showMyDialog('Quest/Mission field should not be empty.');
    } else if (cont_add.text == '') {
      _showMyDialog('Add qoutes field should not be empty.');
    }*/
    else if (cont_about.text == '') {
      _showMyDialog('About your goal field should not be empty.');
    } else {
      print('all values done.');
      create_goal_service
          .create_goal_WB(
        str_goal_for_id.toString(),
        cont_name_of_goal.text,
        str_category_id.toString(),
        // cont_notes.text,
        cont_deadline.text,
        // cont_quest.text,
        cont_about.text,
        // cont_add.text,
      )
          .then(
        (value) {
          print('Status Return =====> ${value.success_alert}');

          if (value.success_alert.toLowerCase() == 'fails') {
            // fails
            setState(() {});

            _showMyDialog(
              value.message.toString(),
            );
          } else {
            // success
            print('=====> Add Goal Success <======');

            Navigator.pop(context, value.message.toString());
          }
        },
      );
    }
  }

  // ALERT
  Future<void> _showMyDialog(
    String str_message,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: text_bold_style_custom(
            //
            languageTextConverter.funcConvertLanguage(
              //
              'alert_alert',
              strUserSelectLanguage,
            ),
            Colors.black,
            12.0,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  str_message,
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ALERT
  Future<void> asasas(
    String str_message,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: text_bold_style_custom(
            //
            languageTextConverter.funcConvertLanguage(
              //
              'alert_please_select_goal',
              strUserSelectLanguage,
            ),
            Colors.black,
            12.0,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      str_goal_for_id = '1';
                      cont_goal_for.text = 'Self/Individual';
                    });
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        'Self/Individual',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      str_goal_for_id = '2';
                      cont_goal_for.text = 'Shop or authority';
                    });
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        'Shop or authority',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      str_goal_for_id = '3';
                      cont_goal_for.text = 'For Team or shop';
                    });
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        'For Team or shop',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                          cont_category.text =
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
