// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journey_recorded/Utils.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateTrainingScreen extends StatefulWidget {
  const CreateTrainingScreen(
      {super.key,
      required this.str_skill_id,
      required this.str_skill_class,
      required this.strCategoryId,
      required this.strCategoryName});

  final String str_skill_id;
  final String str_skill_class;
  final String strCategoryId;
  final String strCategoryName;

  @override
  State<CreateTrainingScreen> createState() => _CreateTrainingScreenState();
}

class _CreateTrainingScreenState extends State<CreateTrainingScreen> {
  //
  var arr_get_category_list = [];
  var str_category_id = '';
  var txt_category = '';
  //
  late final TextEditingController cont_name;
  late final TextEditingController cont_category;
  late final TextEditingController cont_select_frequncy;
  late final TextEditingController cont_select_day;
  late final TextEditingController cont_reminder_date;
  late final TextEditingController cont_reminder_time;
  //
  var str_select_frequncy = '';
  //
  @override
  void initState() {
    super.initState();

    cont_name = TextEditingController();
    cont_category =
        TextEditingController(text: widget.strCategoryName.toString());
    cont_select_frequncy = TextEditingController();
    cont_select_day = TextEditingController();
    cont_reminder_date = TextEditingController();
    cont_reminder_time = TextEditingController();

    get_category_list_WB();
  }

  @override
  void dispose() {
    cont_name.dispose();
    cont_category.dispose();
    cont_select_frequncy.dispose();
    cont_select_day.dispose();
    cont_reminder_date.dispose();
    cont_reminder_time.dispose();

    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          'Training',
          Colors.white,
          16.0,
        ),
        backgroundColor: navigation_color,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop('training_added'),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(
              10.0,
            ),
            child: TextFormField(
              onTap: () {
                // category_list_POPUP('str_message');
              },
              controller: cont_name,
              //keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                /*suffixIcon: Icon(
                  Icons.arrow_drop_down,
                ),*/
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
              readOnly: true,
              onTap: () {
                // category_list_POPUP('str_message');
              },
              controller: cont_category,
              //keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                ),
                border: OutlineInputBorder(),
                labelText: 'Category',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(
              10.0,
            ),
            child: TextFormField(
              readOnly: true,
              onTap: () {
                select_frequency_action_Sheet(context);
              },
              controller: cont_select_frequncy,
              //keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                ),
                border: OutlineInputBorder(),
                labelText: 'Select frequency',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(
              10.0,
            ),
            child: TextFormField(
              onTap: () {
                select_select_day_action_Sheet(context);
              },
              controller: cont_select_day,
              //keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                ),
                border: OutlineInputBorder(),
                labelText: 'Select',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(
              10.0,
            ),
            child: TextFormField(
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate);

                  setState(() {
                    cont_reminder_date.text = formattedDate;
                  });
                } else {
                  print("Date is not selected");
                }
              },
              controller: cont_reminder_date,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.calendar_month,
                ),
                border: OutlineInputBorder(),
                labelText: 'Reminder date',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(
              10.0,
            ),
            child: TextFormField(
              onTap: () async {
                if (kDebugMode) {
                  print('time');
                }
                final TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (newTime != null) {
                  setState(() {
                    if (kDebugMode) {
                      print(newTime.format(context));
                    }

                    cont_reminder_time.text = newTime.format(context);
                  });
                }
                /*print('time');
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
                  String formattedTime = DateFormat('HH:mm').format(parsedTime);
                  print(formattedTime); //output 14:59:00

                  //
                  cont_reminder_time.text = formattedTime.toString();
                  //
                } else {
                  print("Time is not selected");
                }*/
              },
              controller: cont_reminder_time,
              //keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.schedule,
                ),
                border: OutlineInputBorder(),
                labelText: 'Reminder time',
              ),
            ),
          ),
          InkWell(
            onTap: () {
              func_create_training_WB();
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
          )
        ],
      ),
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
                          Navigator.of(context).pop('training_added');
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
                Navigator.of(context).pop('training_added');
              },
            ),
          ],
        );
      },
    );
  }

  // open action sheet
  void select_frequency_action_Sheet(
    BuildContext context,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Select stats',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 16.0,
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          //
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () {
              Navigator.pop(context);
              str_select_frequncy = 'Strength';
              cont_select_frequncy.text = str_select_frequncy;
            },
            child: Text(
              'Strength',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 16.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //

          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              str_select_frequncy = 'Speed';
              cont_select_frequncy.text = str_select_frequncy;
            },
            child: Text(
              //
              'Speed',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 16.0,
                // fontWeight: FontWeight.bold,
                //color: Colors.redAccent,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              str_select_frequncy = 'Endurance';
              cont_select_frequncy.text = str_select_frequncy;
            },
            child: Text(
              //
              'Endurance',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 16.0,
                // fontWeight: FontWeight.bold,
                //color: Colors.redAccent,
              ),
            ),
          ),

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
                // color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // open action sheet
  void select_select_day_action_Sheet(
    BuildContext context,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Select frequency',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 16.0,
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          //
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () {
              Navigator.pop(context);
              // str_select_frequncy = 'Strength';
              cont_select_day.text = 'Daily';
            },
            child: Text(
              'Daily',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 16.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //

          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              cont_select_day.text = 'Every Saturday';
            },
            child: Text(
              //
              'Every Saturday',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 16.0,
                // fontWeight: FontWeight.bold,
                //color: Colors.redAccent,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              cont_select_day.text = 'Mon,Wed,Fri';
            },
            child: Text(
              //
              'Mon,Wed,Fri',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 16.0,
                // fontWeight: FontWeight.bold,
                //color: Colors.redAccent,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              cont_select_day.text = 'Tue,Thu,Sat';
            },
            child: Text(
              //
              'Tue,Thu,Sat',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 16.0,
                // fontWeight: FontWeight.bold,
                //color: Colors.redAccent,
              ),
            ),
          ),

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
                // color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // create training
  func_create_training_WB() async {
    /*
    [action] => trainingadd
    [userId] => 42
    [trainingId] => 3
    [TrainingName] => vhggcc
    [categoryId] => 1
    [skillId] => 3
    [TStats] => Strength
    [Frequency] => Daily
    [totalMinute] => 0
    [SetReminder] => 2023-01-09 23:34
    */

    var time = '${cont_reminder_date.text} ${cont_reminder_time.text}';

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
          'action': 'trainingadd',
          'userId': prefs.getInt('userId').toString(),
          // 'trainingId': cont_skill_name.text.toString(),
          'TrainingName': cont_name.text.toString(),
          'categoryId': widget.strCategoryId.toString(),
          'skillId': widget.str_skill_id.toString(),
          'TStats': cont_select_frequncy.text.toString(),
          'Frequency': cont_select_day.text.toString(),
          // 'totalMinute': cont_skill_description.text.toString(),
          'SetReminder': time.toString(),
          'totalMinute': '0', 'SkillClass': widget.str_skill_class.toString(),
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
        Navigator.pop(context, 'training_added');
        //
      } else {
        // str_save_and_continue_loader = '0';
        setState(() {});
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // str_save_and_continue_loader = '0';
      setState(() {});
      // return postList;
      print('something went wrong');
    }
  }
}
