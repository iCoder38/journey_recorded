// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/task/create_task/create_task_validation.dart';
import 'package:journey_recorded/user_list/user_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen(
      {super.key,
      required this.str_professional_id,
      required this.str_professional_type,
      required this.strGroupIdMain,
      required this.strGroupIdSub});

  final String str_professional_id;
  final String str_professional_type;
  //
  final String strGroupIdMain;
  final String strGroupIdSub;

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  //
  var str_create_task_loader = '0';
  var str_reminder_time = 'n.a.';
  //
  CreateTaskValidation create_task_validation = CreateTaskValidation();
  //
  late final TextEditingController cont_task_name;
  late final TextEditingController cont_due_date;
  late final TextEditingController cont_rewards_type;
  late final TextEditingController cont_rewards;
  late final TextEditingController cont_deduct_rewards;
  late final TextEditingController cont_skills;
  late final TextEditingController cont_request_assignment;
  late final TextEditingController cont_reminder_date;
  late final TextEditingController cont_reminder_time;
  late final TextEditingController cont_reminder_warning;
  late final TextEditingController const_task_Details;
  //
  var get_ids = '';
  var get_names = '';

  @override
  void initState() {
    cont_task_name = TextEditingController();
    cont_due_date = TextEditingController();
    cont_rewards_type = TextEditingController();
    cont_rewards = TextEditingController();
    cont_deduct_rewards = TextEditingController();
    cont_skills = TextEditingController();
    cont_request_assignment = TextEditingController();
    cont_reminder_date = TextEditingController();
    cont_reminder_time = TextEditingController();
    cont_reminder_warning = TextEditingController();
    const_task_Details = TextEditingController();
    //
    print('============ GROUP ID MAIN AND SUB ID =====================');
    print(widget.strGroupIdMain);
    print(widget.strGroupIdSub);
    print('============================================================');
    //
    super.initState();
  }

  @override
  void dispose() {
    cont_task_name.dispose();
    cont_due_date.dispose();
    cont_rewards_type.dispose();
    cont_rewards.dispose();
    cont_deduct_rewards.dispose();
    cont_skills.dispose();
    cont_request_assignment.dispose();
    cont_reminder_date.dispose();
    cont_reminder_time.dispose();
    cont_reminder_warning.dispose();
    const_task_Details.dispose();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Task',
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                controller: cont_task_name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task name',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                controller: cont_due_date,
                readOnly: true,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Due Date',
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
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(formattedDate);

                    setState(() {
                      cont_due_date.text = formattedDate;
                    });
                  } else {
                    print("Date is not selected");
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
                controller: cont_rewards_type,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select rewards type',
                ),
                onTap: () {
                  //
                  openSelectRewardsType(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                controller: cont_rewards,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Rewards',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                controller: cont_deduct_rewards,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Deduct Rewards',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                controller: cont_skills,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Skills',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                readOnly: true,
                controller: cont_request_assignment,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Request Assignment',
                ),
                onTap: () {
                  print('object');
                  push_to_create_task(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                readOnly: true,
                controller: cont_reminder_date,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Reminder Date',
                ),
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
                  labelText: 'Reminder Time',
                ),
                onTap: () async {
                  print('time');
                  final TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (newTime != null) {
                    setState(() {
                      print(newTime.format(context));

                      // print(DateFormat.jm()
                      // .format(DateTime.parse(newTime.format(context))));
                      str_reminder_time = newTime.toString();
                      cont_reminder_time.text = newTime.format(context);
                    });
                  }
                },
                /*TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  if (pickedTime != null) {
                    print(pickedTime.format(context)); //output 10:51 PM
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());

                    print(
                        'parsed time====> $parsedTime'); //output 1970-01-01 22:53:00.000
                    String formattedTime =
                        DateFormat('HH:mm').format(parsedTime);
                    print('time====> s$formattedTime'); //output 14:59:00

                    //
                    str_reminder_time = formattedTime.toString();
                    cont_reminder_time.text = formattedTime.toString();
                    //
                  } else {
                    print("Time is not selected");
                  }*/
                // },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                controller: cont_reminder_warning,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Reminder Warning',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                controller: const_task_Details,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Details',
                ),
              ),
            ),
            (str_create_task_loader == '0')
                ? InkWell(
                    onTap: () {
                      str_create_task_loader = '1';
                      // add reminder
                      // date + str_reminder_time
                      setState(() {});
                      create_task_validation.func_create_task_validation(
                        cont_task_name.text.toString(),
                        cont_due_date.text.toString(),
                        cont_rewards.text.toString(),
                        cont_deduct_rewards.text.toString(),
                        cont_skills.text.toString(),
                        get_ids.toString(),
                        cont_reminder_date.text.toString(),
                        cont_reminder_time.text.toString(),
                        cont_reminder_warning.text.toString(),
                        const_task_Details.text.toString(),
                        widget.str_professional_id.toString(),
                        widget.str_professional_type.toString(),
                        // new
                        cont_rewards_type.text.toString(),
                        widget.strGroupIdMain.toString(),
                        widget.strGroupIdSub.toString(),
                        context,
                      );
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
                : Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      color: Colors.transparent,
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void openSelectRewardsType(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Rewards'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              cont_rewards_type.text = 'Cash';
            },
            child: Text(
              'Cash',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              cont_rewards_type.text = 'Items';
            },
            child: Text(
              'Items',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              //
              cont_rewards_type.text = 'Experience';
            },
            child: Text(
              'Experience',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> push_to_create_task(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserListScreen(),
      ),
    );

    // print('result =====> ' + result);
    print(result);

    if (!mounted) return;

    //
    // final splitted = result.split(' # ');
    // print(splitted);
    //
    // for (int i = 0; i < splitted.length; i++) {
    // print(splitted[i][0]);
    // print(splitted[i][1]);
    // print(splitted[i][2]);
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    get_ids = prefs.getString('save_task_members_ids').toString();
    get_names = prefs.getString('save_task_members_names').toString();
    //
    print(get_ids);
    print(get_names);
    //
    await prefs.setString('save_task_members_ids', '');
    await prefs.setString('save_task_members_names', '');
    //
    setState(() {
      cont_request_assignment.text = get_names.toString();
    });
  }
}
