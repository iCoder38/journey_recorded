// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/goals/add_notes_in_goal/add_notes_in_goal.dart';
import 'package:journey_recorded/goals/edit_notes_in_goal/edit_notes_in_goal.dart';
import 'package:journey_recorded/goals/goals_details/goal_common_header/goal_common_header.dart';
import 'package:journey_recorded/single_classes/single_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class GoalNotesScreen extends StatefulWidget {
  const GoalNotesScreen(
      {super.key,
      required this.str_get_goal_id,
      required this.str_get_due_date,
      required this.str_get_parse_name,
      required this.str_professional_type});

  final String str_get_goal_id;
  final String str_get_due_date;
  final String str_get_parse_name;
  final String str_professional_type;

  @override
  State<GoalNotesScreen> createState() => _GoalNotesScreenState();
}

class _GoalNotesScreenState extends State<GoalNotesScreen> {
  //
  var str_notes_loader_status = '0';
  var arr_notes_list = [];
  //
  //
  final GetDifferenceBetweenDate parse_days_left = GetDifferenceBetweenDate();
  //
  // slider
  double _currentSliderValue = 0;
  //
  var str_get_message;
  var str_note_id;
  var str_profession_id;
  var str_professional_type;
  var str_user_id;
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    func_notes_WB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('add notes click');
          add_note_push_via_future(context);
        },
        backgroundColor: navigation_color,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            //
            // header
            GoalCommonHeaderScreen(
              str_get_parse_name: widget.str_get_parse_name.toString(),
              str_get_due_date: widget.str_get_due_date.toString(),
              str_goal_id: widget.str_get_goal_id,
            ),

            //
            if (str_notes_loader_status == '0') ...[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        str_loader_title.toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                //scrollDirection: Axis.vertical,
                //shrinkWrap: true,
                itemCount: arr_notes_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 0.0,
                      ),
                      // height: 100,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: ListTile(
                        // leading: const FlutterLogo(size: 72.0),
                        title: Text(
                          //
                          arr_notes_list[index]['created'].toString(),
                          // '12',
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Container(
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            //
                            arr_notes_list[index]['message'].toString(),
                            // '2',
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        /*trailing: Icon(
                          Icons.more_vert,
                        ),*/
                        isThreeLine: true,
                        trailing: Column(
                          children: <Widget>[
                            Expanded(
                              child: IconButton(
                                onPressed: (() {
                                  // print(index);
                                  str_get_message = arr_notes_list[index]
                                          ['message']
                                      .toString();
                                  str_note_id = arr_notes_list[index]['noteId']
                                      .toString();
                                  str_profession_id = widget.str_get_goal_id;
                                  str_professional_type = 'Goal';

                                  gear_popup(
                                    'Manage Notes',
                                    arr_notes_list[index]['noteId'].toString(),
                                  );
                                }),
                                icon: const Icon(
                                  Icons.settings,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  // NOTES
  Future func_notes_WB() async {
    print('=====> POST : NOTES 1');

    setState(() {
      str_notes_loader_status = '0';
    });
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
          'action': 'notelist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'profesionalId': widget.str_get_goal_id.toString(),
          'profesionalType': widget.str_professional_type,
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      arr_notes_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          // print('object');

          arr_notes_list.add(i);
        }

        setState(() {
          // str_panel_number = 'notes';
          str_notes_loader_status = '1';
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

  // ALERT
  Future<void> gear_popup(
    String str_title,
    String note_id_is,
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
                InkWell(
                  onTap: () {
                    print('edit 2');
                    Navigator.pop(context);

                    _navigateAndDisplaySelection(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.edit,
                            size: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Edit Note',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    print(' delete note');

                    Navigator.pop(context);

                    delete_notes_WB(
                      note_id_is,
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.delete_forever,
                            size: 16.0,
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: ' Delete Note',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
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
          ],
        );
      },
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotesInGoalScreen(
          str_message: str_get_message,
          str_note_id: str_note_id.toString(),
          str_professional_id: str_profession_id.toString(),
          str_professional_type: str_professional_type.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_edit_notes') {
      arr_notes_list.clear();
      setState(() {
        func_notes_WB();
      });
    }
  }

  delete_notes_WB(
    String note_id,
  ) async {
    print('=====> POST : DELETE NOTES');

    str_notes_loader_status = '0';
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
          'action': 'notedelete',
          'userId': prefs.getInt('userId').toString(),
          'noteId': note_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_notes_list = [];
        //
        func_notes_WB();
        //

      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
      print('something went wrong');
    }
  }

  Future<void> add_note_push_via_future(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNotesInGoalScreen(
          str_profession_id: widget.str_get_goal_id.toString(),
          str_profession_type: widget.str_professional_type,
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_add_notes') {
      arr_notes_list.clear();
      setState(() {
        func_notes_WB();
      });
    }
  }
}
