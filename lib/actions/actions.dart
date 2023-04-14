// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class ActionsScreen extends StatefulWidget {
  const ActionsScreen({super.key});

  @override
  State<ActionsScreen> createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen> {
  //
  var str_team_loader = '0';
  // var arr_actions = [];
  var arr_actions_list = [];
  //
  @override
  void initState() {
    super.initState();
    get_team_list_WB();
  }

  get_team_list_WB() async {
    print('=====> POST : TEAM LIST');

    setState(() {
      // str_goal_loader = '0';
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
          'action': 'teamlist',
          'fromId': prefs.getInt('userId').toString(),
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
        // get and parse data
        arr_actions_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          //
          arr_actions_list.add(get_data['data'][i]);
        }

        //
        setState(() {
          str_team_loader = '1';
        });
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

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigation_color,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          //
          'Active Team',
          //
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),
      body: (str_team_loader == '0')
          ? const CustomeLoaderPopUp(
              str_custom_loader: 'please wait...',
              str_status: '3',
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromRGBO(
                      9,
                      44,
                      132,
                      1,
                    ),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 80,
                            color: Colors.transparent,
                            child: Align(
                              child: Text(
                                'Actions',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 60,
                          width: 2,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 80,
                            color: Colors.transparent,
                            child: Align(
                              child: Text(
                                'Completed Action',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  //

                  for (var i = 0; i < arr_actions_list.length; i++) ...[
                    ExpansionTile(
                      title: Text(
                        //
                        arr_actions_list[i]['taskName'].toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                        ),
                      ),
                      // subtitle: Text('Trailing expansion arrow icon'),

                      /*children: <Widget>[
                        for (var j = 0;
                            j < arr_actions[i]['checklist'].length;
                            j++) ...[
                          ListTile(
                            /*leading: Container(
                        width: 80,
                        height: 80,
                        color: Colors.yellow,
                      ),*/
                            title: Text(
                              //
                              arr_actions[i]['checklist'][j]['message']
                                  .toString(),
                              //
                              style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            /*subtitle: Text(
                        // 'skills : ${arr_send_teammate_request[j]['skill']}\nTask name : ${arr_send_teammate_request[j]['taskName']}',
                        'sub-title',
                      ),*/
                            trailing: InkWell(
                              onTap: () {
                                print('sub-title click');
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      print('object');
                                    },
                                    icon: (arr_actions[i]['checklist'][j]
                                                    ['message']
                                                .toString() ==
                                            '0')
                                        ? Icon(
                                            Icons.check_box_outline_blank,
                                            color: navigation_color,
                                          )
                                        : Icon(
                                            Icons.check_box,
                                            color: navigation_color,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            isThreeLine: false,
                          ),
                        ]
                      ],*/
                    ),
                  ],
                  //
                ],
              ),
            ),
    );
  }
}
