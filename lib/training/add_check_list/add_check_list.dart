// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class AddCheckListScreen extends StatefulWidget {
  const AddCheckListScreen(
      {super.key,
      required this.str_training_id_check_list,
      this.get_dict_training_data});

  final String str_training_id_check_list;

  final get_dict_training_data;

  @override
  State<AddCheckListScreen> createState() => _AddCheckListScreenState();
}

class _AddCheckListScreenState extends State<AddCheckListScreen> {
  //
  late final TextEditingController cont_select_routine;
  late final TextEditingController cont_description;
  //
  var main_loader = '0';
  var str_routine_id = '0';
  var str_save_continue_loader = '1';
  var arr_select_routine = [];

  //
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('data ===> ');
      print(widget.get_dict_training_data);
    }

    if (widget.get_dict_training_data != '') {
      // not empty
      //

      cont_select_routine = TextEditingController(
        text: widget.get_dict_training_data['message'].toString(),
      );
      cont_description = TextEditingController(
        text: widget.get_dict_training_data['message'].toString(),
      );
      //
      str_routine_id = widget.get_dict_training_data['routineId'].toString();
      //
    } else {
      //
      print('object 12.24');
      cont_select_routine = TextEditingController();
      cont_description = TextEditingController();
      //
    }

    get_routine_list_WB();
  }

  @override
  void dispose() {
    cont_select_routine.dispose();
    cont_description.dispose();

    super.dispose();
  }

// get routine list
  get_routine_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : ROUTINE LIST');
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
          'action': 'routinelist',
          'profesionalId': widget.str_training_id_check_list.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);

    if (kDebugMode) {
      // print(get_data);
    }

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_select_routine = get_data['data'];
        main_loader = '1';

        if (widget.get_dict_training_data != '') {
          // print(arr_select_routine);
          for (int i = 0; i < arr_select_routine.length; i++) {
            if (arr_select_routine[i]['routineId'].toString() ==
                widget.get_dict_training_data['routineId'].toString()) {
              if (kDebugMode) {
                print(arr_select_routine[i]['message'].toString());
              }
              //
              cont_select_routine.text =
                  arr_select_routine[i]['message'].toString();
              //
            }
          }
        }

        setState(() {});
      } else {
        if (kDebugMode) {
          print(
            '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
          );
        }
      }
    } else {
      // return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          //
          'Create Check List',
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
      ),
      body: (main_loader == '0')
          ? const CustomeLoaderPopUp(
              str_custom_loader: 'please wait....', str_status: '4')
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(
                    10.0,
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller: cont_select_routine,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Select Routine',
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                        )),
                    // maxLines: 5,
                    onTap: () {
                      routine_list(context);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(
                    10.0,
                  ),
                  child: TextFormField(
                    controller: cont_description,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                    maxLines: 5,
                  ),
                ),
                (str_save_continue_loader == '1')
                    ? InkWell(
                        onTap: () {
                          if (widget.get_dict_training_data != '') {
                            //
                            func_edit_check_list_WB();
                            //
                          } else {
                            //
                            func_create_check_list_WB();
                            //
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
                      )
                    : const CircularProgressIndicator()
              ],
            ),
    );
  }

  // open action sheet
  void routine_list(
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
          for (int i = 0; i < arr_select_routine.length; i++) ...[
            CupertinoActionSheetAction(
              isDestructiveAction: false,
              onPressed: () {
                Navigator.pop(context);

                str_routine_id = arr_select_routine[i]['routineId'].toString();
                cont_select_routine.text =
                    arr_select_routine[i]['message'].toString();
              },
              child: Text(
                //
                arr_select_routine[i]['message'].toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],

          //

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

  //
  // create training
  func_create_check_list_WB() async {
    str_save_continue_loader = '0';
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
          'action': 'addchecklist',
          'userId': prefs.getInt('userId').toString(),
          'routineId': str_routine_id.toString(),
          'message': cont_description.text.toString(),
          'profesionalId': widget.str_training_id_check_list.toString(),
          'profesionalType': 'Training'.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);

    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        Navigator.pop(context, 'check_list_added');
        //
      } else {
        str_save_continue_loader = '1';
        setState(() {});
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      str_save_continue_loader = '1';
      setState(() {});
    }
  }

  // edit training
  func_edit_check_list_WB() async {
    setState(() {
      str_save_continue_loader = '0';
    });
    // print(str_routine_id);
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
          'action': 'addchecklist',
          'userId': prefs.getInt('userId').toString(),
          'checklistId':
              widget.get_dict_training_data['checklistId'].toString(),
          'routineId': str_routine_id.toString(),
          'message': cont_description.text.toString(),
          'profesionalId': widget.str_training_id_check_list.toString(),
          'profesionalType': 'Training'.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);

    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        Navigator.pop(context, 'check_list_added');
        //
      } else {
        str_save_continue_loader = '1';
        setState(() {});
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      str_save_continue_loader = '1';
      setState(() {});
    }
  }
}
