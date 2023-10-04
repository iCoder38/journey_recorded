// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously, unused_element

import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:journey_recorded/task/create_task/create_task_validation.dart';
import 'package:journey_recorded/user_list/user_list.dart';

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
  GlobalKey<FormState> formKey = GlobalKey();
  //
  var str_user_select_which_profile = '0';
  var str_login_user_name = '';
  var str_login_user_id = '';
  //
  var str_create_task_loader = '0';
  var str_reminder_time = 'n.a.';
  //
  File? imageFile;
  var str_user_select_item = '0';
  //
  var str_save_and_continue_loader = '0';
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
    funGetLoginUserData();
    super.initState();
  }

  //
  funGetLoginUserData() async {
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    str_login_user_name = prefs.getString('fullName').toString();
    str_login_user_id = prefs.getInt('userId').toString();
    //
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
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  controller: cont_task_name,
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Task name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
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
                    // border: OutlineInputBorder(),
                    labelText: 'Due Date',
                    suffixIcon: Icon(
                      Icons.calendar_month,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
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
                    // // border: OutlineInputBorder(),
                    labelText: 'Select rewards type',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                  onTap: () {
                    //
                    openSelectRewardsType(context);
                  },
                ),
              ),
              (str_user_select_item == '1')
                  ? GestureDetector(
                      onTap: () {
                        //
                        showActionSheet_for_camera_gallery(context);
                      },
                      child: Column(
                        children: [
                          text_regular_style_custom(
                            'Upload Reward Image',
                            Colors.black,
                            14.0,
                          ),
                          //
                          const SizedBox(
                            height: 8,
                          ),
                          //
                          (imageFile == null)
                              ? Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.2,
                                      color: Colors.black,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.2,
                                      color: Colors.black,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.file(
                                      fit: BoxFit.cover,
                                      imageFile!,
                                      height: 150.0,
                                      width: 100.0,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(
                        10.0,
                      ),
                      child: TextFormField(
                        controller: cont_rewards,
                        decoration: const InputDecoration(
                          // border: OutlineInputBorder(),
                          labelText: 'Rewards',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
              (str_user_select_item == '1')
                  ? const SizedBox()
                  : Container(
                      margin: const EdgeInsets.all(
                        10.0,
                      ),
                      child: TextFormField(
                        controller: cont_deduct_rewards,
                        decoration: const InputDecoration(
                          // border: OutlineInputBorder(),
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
                    // border: OutlineInputBorder(),
                    labelText: 'Skills',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
              ),
              (str_user_select_which_profile == '1')
                  ? Container(
                      margin: const EdgeInsets.all(
                        10.0,
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: cont_request_assignment,
                        decoration: const InputDecoration(
                          // border: OutlineInputBorder(),
                          labelText: 'Request Assignment',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                        onTap: () {
                          print('object');

                          assignSelfOrotherPopup(context);
                        },
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(
                        10.0,
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller: cont_request_assignment,
                        decoration: const InputDecoration(
                          // border: OutlineInputBorder(),
                          labelText: 'Request Assignment',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter value';
                          }
                          return null;
                        },
                        onTap: () {
                          print('object');

                          assignSelfOrotherPopup(context);
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
                    // border: OutlineInputBorder(),
                    labelText: 'Reminder Date',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
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
                    // border: OutlineInputBorder(),
                    labelText: 'Reminder Time',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
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
                    // border: OutlineInputBorder(),
                    labelText: 'Reminder Warning',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  controller: const_task_Details,
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Task Details',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
              ),
              (str_create_task_loader == '0')
                  ? InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (str_user_select_item == '1') {
                            funcValidationBeforeUploadImage();
                          } else {
                            str_create_task_loader = '1';

                            if (str_user_select_which_profile.toString() ==
                                '1') {
                              setState(() {});
                              create_task_validation
                                  .func_create_task_validation(
                                cont_task_name.text.toString(),
                                cont_due_date.text.toString(),
                                cont_rewards.text.toString(),
                                cont_deduct_rewards.text.toString(),
                                cont_skills.text.toString(),
                                str_login_user_id.toString(),
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
                            } else {
                              setState(() {});
                              create_task_validation
                                  .func_create_task_validation(
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
                            }
                          }
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
                          child: (str_save_and_continue_loader == '1')
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
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
              setState(() {
                str_user_select_item = '0';
              });

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
              setState(() {
                str_user_select_item = '1';
              });
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
              setState(() {
                str_user_select_item = '0';
              });
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

  void assignSelfOrotherPopup(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Request assignment'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              setState(() {
                cont_request_assignment.text = str_login_user_name;

                str_user_select_which_profile = '1';
              });
            },
            child: Text(
              'Self',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              setState(() {
                str_user_select_which_profile = '0';
              });
              push_to_create_task(context);
            },
            child: Text(
              'Others',
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

  void showActionSheet_for_camera_gallery(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Camera option'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.camera,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                setState(() {
                  imageFile = File(pickedFile.path);
                });
              }
            },
            child: Text(
              'Open Camera',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.gallery,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                setState(() {
                  print('object');
                  imageFile = File(pickedFile.path);
                });
              }
            },
            child: Text(
              'Open Gallery',
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

  //
  funcValidationBeforeUploadImage() {
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          closeIconColor: Colors.amber,
          content: text_regular_style_custom(
            'Please upload an Image',
            Colors.white,
            14.0,
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      upload_image_to_server();
    }
  }

  upload_image_to_server() async {
    setState(() {
      str_save_and_continue_loader = '1';
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('ok');
    var request =
        await http.MultipartRequest('POST', Uri.parse(application_base_url));

    request.fields['action'] = 'addtask';
    request.fields['userId'] = prefs.getInt('userId').toString();

    request.fields['name'] = cont_task_name.text.toString();
    request.fields['description'] = const_task_Details.text.toString();
    request.fields['due_date'] = cont_due_date.text.toString();

    if (str_user_select_which_profile.toString() == '1') {
      request.fields['Assigment'] = str_login_user_id.toString();
    } else {
      request.fields['Assigment'] = get_ids.toString();
    }

    request.fields['skill'] = cont_skills.text.toString();
    request.fields['addreminder'] = cont_reminder_time.text.toString();
    request.fields['reminderWarning'] = cont_reminder_warning.text.toString();
    request.fields['profesionalId'] = widget.str_professional_id.toString();
    request.fields['profesionalType'] = widget.str_professional_type.toString();
    request.fields['categoryId'] = '5'.toString();
    request.fields['groupId_Main'] = widget.strGroupIdMain.toString();
    request.fields['groupId_Sub'] = widget.strGroupIdSub.toString();
    request.fields['rewardType'] = cont_rewards_type.text.toString();

    request.files.add(
      await http.MultipartFile.fromPath(
        'rewardImage',
        imageFile!.path,
      ),
    );

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responsedData = json.decode(responsed.body);
    print(responsedData);

    if (responsedData['status'].toString() == 'Success') {
      //
      setState(() {
        str_save_and_continue_loader = '0';
      });
      Navigator.pop(context, 'approved_check_list');
    }
  }
  //
}
