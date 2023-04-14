// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateCheckListScreen extends StatefulWidget {
  const CreateCheckListScreen(
      {super.key,
      required this.str_professional_type,
      required this.str_professional_id,
      required this.str_edit_status,
      required this.str_check_list_id,
      required this.str_message});

  final String str_message;
  final String str_check_list_id;
  final String str_edit_status;
  final String str_professional_id;
  final String str_professional_type;

  @override
  State<CreateCheckListScreen> createState() => _CreateCheckListScreenState();
}

class _CreateCheckListScreenState extends State<CreateCheckListScreen> {
  //

  late final TextEditingController cont_create_checklist;
  //
  @override
  void initState() {
    super.initState();
    cont_create_checklist = TextEditingController();
    // print(widget.str_edit_status);

    cont_create_checklist.text = widget.str_message.toString();
  }

  @override
  void dispose() {
    cont_create_checklist.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          //
          'Create Checklist'.toString().toUpperCase(),
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
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 20.0,
            ),
            // height: 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: (widget.str_edit_status == '1')
                ? TextFormField(
                    controller: cont_create_checklist,
                    // initialValue: widget.str_message.toString(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'create...',
                      labelText: 'Create Checklist',
                    ),
                    maxLines: 3,
                  )
                : TextFormField(
                    controller: cont_create_checklist,
                    // initialValue: widget.str_message.toString(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'create...',
                      labelText: 'Create Checklist',
                    ),
                    maxLines: 3,
                    onTap: () {
                      print('');
                    },
                  ),
          ),
          InkWell(
            onTap: () {
              (widget.str_edit_status == '1')
                  ? func_create_checklist_WB()
                  : func_edit_checklist_WB();
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
                child: (widget.str_edit_status == '1')
                    ? Text(
                        'Create',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Edit',
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
    );
  }

  func_create_checklist_WB() async {
    print('=====> POST : NOTES 1');

    //
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
          'profesionalId': widget.str_professional_id.toString(),
          'profesionalType': 'Task',
          'message': cont_create_checklist.text.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      // arr_notes_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        Navigator.pop(context, 'back_from_create_checklist');
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  func_edit_checklist_WB() async {
    print('=====> POST : NOTES 1');

    //
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
          'checklistId': widget.str_check_list_id.toString(),
          'profesionalId': widget.str_professional_id.toString(),
          'profesionalType': 'Task',
          'message': cont_create_checklist.text.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      // arr_notes_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        Navigator.pop(context, 'back_from_create_checklist');
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
