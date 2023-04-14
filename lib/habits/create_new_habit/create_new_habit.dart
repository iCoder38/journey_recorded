// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journey_recorded/Utils.dart';

import 'package:http/http.dart' as http;
import 'package:journey_recorded/habits/create_new_habit/create_new_habit_modal.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CreateNewHabitScreen extends StatefulWidget {
  const CreateNewHabitScreen({
    super.key,
    required this.str_fetch_get_name_your_habit,
    required this.str_fetch_get_category_id,
    required this.str_fetch_get_category_name,
    required this.str_fetch_get_user_name,
    required this.str_fetch_get_priority,
    required this.str_fetch_get_reminder_date,
    required this.str_fetch_get_reminder_time,
    required this.str_fetch_get_start,
    required this.str_fetch_get_trigger,
    required this.str_fetch_get_why,
    required this.str_fetch_get_danger,
    required this.str_fetch_get_pro,
    required this.str_fetch_get_specify,
    required this.str_fetch_get_habit_id,
    required this.str_fetch_get_time,
    required this.str_fetch_get_skill,
  });

  final String str_fetch_get_habit_id;
  final String str_fetch_get_name_your_habit;
  final String str_fetch_get_category_id;
  final String str_fetch_get_category_name;
  final String str_fetch_get_user_name;
  final String str_fetch_get_priority;

  final String str_fetch_get_time;
  final String str_fetch_get_skill;

  final String str_fetch_get_reminder_date;
  final String str_fetch_get_reminder_time;

  final String str_fetch_get_start;
  final String str_fetch_get_trigger;
  final String str_fetch_get_why;
  final String str_fetch_get_danger;
  final String str_fetch_get_pro;
  final String str_fetch_get_specify;

  @override
  State<CreateNewHabitScreen> createState() => _CreateNewHabitScreenState();
}

class _CreateNewHabitScreenState extends State<CreateNewHabitScreen> {
  var str_start_count = 0;

  //
  CreateHabitsModals create_new_habit_service = CreateHabitsModals();
  //
  var str_create_new_habit_loader = '0';
  //
  var arr_get_category_list = [];
  //
  var str_category_id = '';
  //
  var strRelatedSkillLoader = '0';
  var arrRelatedSkills = [];
  var strSaveRelatedSkillId = '';
  //

  late final TextEditingController cont_name_your_habit;
  late final TextEditingController cont_category;
  late final TextEditingController cont_user_name;
  late final TextEditingController cont_priority;

  late final TextEditingController contGrindTime;
  late final TextEditingController contGrindSkillName;

  late final TextEditingController cont_reminder_date;
  late final TextEditingController cont_reminder_time;

  // late final TextEditingController cont_reminder;
  late final TextEditingController cont_start;
  late final TextEditingController cont_trigger;
  late final TextEditingController cont_why;
  late final TextEditingController cont_danger;
  late final TextEditingController cont_pro;
  late final TextEditingController cont_specify;
  //
  @override
  void initState() {
    super.initState();
    //

    cont_name_your_habit = TextEditingController(
        text: widget.str_fetch_get_name_your_habit.toString());
    cont_category = TextEditingController(
        text: widget.str_fetch_get_category_name.toString());
    cont_user_name =
        TextEditingController(text: widget.str_fetch_get_user_name.toString());
    cont_priority =
        TextEditingController(text: widget.str_fetch_get_priority.toString());

    cont_reminder_date = TextEditingController(
        text: widget.str_fetch_get_reminder_date.toString());
    cont_reminder_time = TextEditingController(
        text: widget.str_fetch_get_reminder_time.toString());

    cont_start =
        TextEditingController(text: widget.str_fetch_get_start.toString());
    cont_trigger =
        TextEditingController(text: widget.str_fetch_get_trigger.toString());
    cont_why = TextEditingController(text: widget.str_fetch_get_why.toString());
    cont_danger =
        TextEditingController(text: widget.str_fetch_get_danger.toString());
    cont_pro = TextEditingController(text: widget.str_fetch_get_pro.toString());
    cont_specify =
        TextEditingController(text: widget.str_fetch_get_specify.toString());
    //

    contGrindTime =
        TextEditingController(text: widget.str_fetch_get_time.toString());
    contGrindSkillName =
        TextEditingController(text: widget.str_fetch_get_skill.toString());

    if (widget.str_fetch_get_name_your_habit != '') {
      str_start_count = int.parse(widget.str_fetch_get_start);
      str_category_id = widget.str_fetch_get_category_id.toString();
    }

    get_category_list_WB();
    //
  }

  @override
  void dispose() {
    cont_name_your_habit.dispose();
    cont_category.dispose();
    cont_user_name.dispose();
    cont_priority.dispose();
    // cont_reminder.dispose();

    cont_reminder_date.dispose();
    cont_reminder_time.dispose();

    contGrindTime.dispose();
    contGrindSkillName.dispose();

    cont_start.dispose();
    cont_trigger.dispose();
    cont_why.dispose();
    cont_danger.dispose();
    cont_pro.dispose();
    cont_specify.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          //
          navigation_title_create_new_habit,
          //
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
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
          IconButton(
            onPressed: () {
              if (kDebugMode) {
                print('object');
              }
              delete_habit(
                'Delete',
                widget.str_fetch_get_habit_id.toString(),
              );
            },
            icon: const Icon(
              Icons.delete_forever,
            ),
          )
        ],
      ),
      /*
      Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'please wait...',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              */
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: (str_create_new_habit_loader == '0')
            ? Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Center(
                  child: Text(
                    'please wait...',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      controller: cont_name_your_habit,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      controller: cont_category,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Select Category',
                      ),
                      onTap: () {
                        print('click category');
                        category_list_POPUP('str_message');
                      },
                    ),
                  ),
                  /*Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      controller: cont_user_name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),*/

                  //
                  (widget.str_fetch_get_name_your_habit != '')
                      ? Container(
                          margin: const EdgeInsets.all(
                            10.0,
                          ),
                          child: TextFormField(
                            readOnly: true,
                            controller: contGrindTime,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Time to complete the activity',
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(
                            10.0,
                          ),
                          child: TextFormField(
                            readOnly: false,
                            controller: contGrindTime,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Time to complete the activity',
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
                    (widget.str_fetch_get_name_your_habit != '')
                        ? const SizedBox()
                        : Container(
                            margin: const EdgeInsets.all(
                              10.0,
                            ),
                            child: TextFormField(
                              readOnly: true,
                              controller: contGrindSkillName,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Related skil',
                              ),
                              onTap: () {
                                //
                                (cont_category.text == '')
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(
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
                  ],

                  //
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: cont_reminder_date,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Reminder date',
                        suffixIcon: Icon(
                          Icons.calendar_month,
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

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
                            cont_reminder_date.text = formattedDate;
                          });
                        } else {
                          if (kDebugMode) {
                            print("Date is not selected");
                          }
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: cont_reminder_time,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Reminder time',
                        suffixIcon: Icon(
                          Icons.calendar_month,
                        ),
                      ),
                      onTap: () async {
                        if (kDebugMode) {
                          print('time');
                        }
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );

                        if (pickedTime != null) {
                          // print(pickedTime.format(context)); //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm()
                              .parse(pickedTime.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime =
                              DateFormat('HH:mm').format(parsedTime);
                          print(formattedTime); //output 14:59:00

                          //
                          cont_reminder_time.text = formattedTime.toString();
                          //
                        } else {
                          print("Time is not selected");
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      controller: cont_priority,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Priority',
                      ),
                    ),
                  ),
                  /*Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: cont_reminder,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Reminder Alarm',
                      ),
                      onTap: () async {
                        print('time');
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );

                        if (pickedTime != null) {
                          print(pickedTime.format(context)); //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm()
                              .parse(pickedTime.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime =
                              DateFormat('HH:mm').format(parsedTime);
                          print(formattedTime); //output 14:59:00

                          //
                          cont_reminder.text = formattedTime.toString();
                          //
                        } else {
                          print("Time is not selected");
                        }
                      },
                    ),
                  ),*/
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(
                        2.0,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            // width: 60,
                            height: 40,
                            color: Colors.transparent,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Start %',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 16.0,
                                  color: const Color.fromRGBO(
                                    111,
                                    111,
                                    111,
                                    1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // print('minus');
                              func_start_count_algo('-');
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: Align(
                            child: Text(
                              //
                              str_start_count.toString(),
                              //
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // print('add');
                              func_start_count_algo('+');
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    /*child: TextFormField(
                      controller: cont_start,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Start %',
                        suffixIcon: Icon(
                          Icons.abc,
                        ),
                      ),
                    ),*/
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      controller: cont_trigger,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Trigger',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      controller: cont_why,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Why',
                      ),
                      maxLines: 5,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      controller: cont_danger,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Danger',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      controller: cont_pro,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Pro',
                      ),
                      maxLines: 5,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    child: TextFormField(
                      controller: cont_specify,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Specify',
                      ),
                      maxLines: 5,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print('next move');
                      }
                      create_new_habit_service
                          .create_new_habits_WB(
                            widget.str_fetch_get_habit_id.toString(),
                            cont_priority.text.toString(),
                            cont_name_your_habit.text.toString(),
                            str_category_id.toString(),
                            cont_reminder_date.text.toString(),
                            cont_reminder_time.text.toString(),
                            str_start_count.toString(),
                            cont_trigger.text.toString(),
                            cont_why.text.toString(),
                            cont_danger.text.toString(),
                            cont_pro.text.toString(),
                            cont_specify.text.toString(),
                            contGrindTime.text.toString(),
                            strSaveRelatedSkillId.toString(),
                          )
                          .then((value) => {
                                // Navigator.pop(context,
                                // 'get_back_from_edit_notes'.toString()),

                                Navigator.of(context)
                                  ..pop()
                                  ..pop(''),
                              });
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
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
      ),
    );
  }

  //
  get_category_list_WB() async {
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
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_get_category_list = get_data['data'];

        str_create_new_habit_loader = '1';
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
  func_start_count_algo(
    String str_digits,
  ) {
    if (str_digits == '+') {
      if (str_start_count != 100) {
        str_start_count += 1;
        // print(str_start_count);
      }
    } else if (str_digits == '-') {
      if (str_start_count != 0) {
        str_start_count -= 1;
        // print(str_start_count);
      }
    }
    setState(() {});
  }

  // delete habit

  Future<void> delete_habit(
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
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Are you sure you want to delete ${widget.str_fetch_get_name_your_habit.toString()} ?',
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
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
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
            TextButton(
              child: Text(
                'yes, delete',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                delete_habbit_WB();
              },
            ),
          ],
        );
      },
    );
  }

  // delete
  delete_habbit_WB() async {
    if (kDebugMode) {
      print('=====> POST : GET CATEGORY');
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
          'action': 'habbitdelete',
          'userId': prefs.getInt('userId').toString(),
          'habitId': widget.str_fetch_get_habit_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        Navigator.of(context)
          ..pop()
          ..pop('');
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

  //
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
                            contGrindSkillName.text = '';
                            strSaveRelatedSkillId = '';
                          } else {
                            contGrindSkillName.text =
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
  //
}
