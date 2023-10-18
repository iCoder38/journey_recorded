// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables, unused_local_variable

import 'dart:convert';
import 'dart:math';

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
  var arrStoreProfessionalIds = [];
  var arrStoreProfessionalNames = [];
  //
  var arrRemoveIds = [];
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
          'mainProfesionalId': '',
          'mainProfesionalType': '',
          'groupId_Main': '',
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
        // get and parse data
        arr_actions_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          //
          arr_actions_list.add(get_data['data'][i]);
        }
        funcManageAllMembers();
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

  funcManageAllMembers() {
    main();
  }

  void main() {
    // print('==================================================================');
    // print(arr_actions_list);
    // print('==================================================================');
    //
    var save_data_for_names = [];
    /*for (int i = 0; i < arr_actions_list.length; i++) {
      var names = {
        'id': arr_actions_list[i]['profesionalId'].toString(),
        'task_name': arr_actions_list[i]['taskName'].toString()
      };
      save_data_for_names.add(names);
    }*/
    //
    arrStoreProfessionalIds.clear();
    print(arr_actions_list);
    for (int i = 0; i < arr_actions_list.length; i++) {
      /*var fetch = {
        'id': arr_actions_list[i]['profesionalId'].toString(),
        'name': arr_actions_list[i]['taskName'].toString()
      };*/
      arrStoreProfessionalIds
          .add(arr_actions_list[i]['profesionalId'].toString());
    }
    print('================ FULL IDs ====================');
    print(arrStoreProfessionalIds);
    print(arrStoreProfessionalIds.length);
    print('======= AFTER REMOVE DUPLICATE IDs ===========');
    var idsAfterRemoveDuplicate = arrStoreProfessionalIds.toSet().toList();
    // print(idsAfterRemoveDuplicate);
    print('==================================================================');
    print('======= CREATE CUSTOM AFTER REMOVE IDs ===========');
    print(idsAfterRemoveDuplicate);

    //
    for (int i = 0; i < idsAfterRemoveDuplicate.length; i++) {
      var list1 = {
        'id': idsAfterRemoveDuplicate[i].toString(),
        'name': arr_actions_list[i]['taskName'].toString(),
        'data': [],
      };
      arrRemoveIds.add(list1);
    }
    // print(arrRemoveIds);
    // print(arrRemoveIds.length);
    print('==================================================================');
    print('======= LOOP FOR MAIN ARRAY DATA =================================');
    var arrMainArrayToCustom = [];
    //
    for (int i = 0; i < arr_actions_list.length; i++) {
      var list1 = {
        'id': arr_actions_list[i]['profesionalId'].toString(),
        'name': arr_actions_list[i]['To_userName'].toString(),
        'skills': arr_actions_list[i]['To_skill'].toString(),
      };
      arrMainArrayToCustom.add(list1);
    }
    // print(arrMainArrayToCustom);
    // print(arrMainArrayToCustom.length);
    print('==================================================================');
    for (int i = 0; i < arrRemoveIds.length; i++) {
      for (int j = 0; j < arrMainArrayToCustom.length; j++) {
        if (arrRemoveIds[i]['id'].toString() ==
            arrMainArrayToCustom[j]['id'].toString()) {
          (arrRemoveIds[i]['data'] as List)
              .add(arrMainArrayToCustom[j]..remove('id'));
//         with woNum
//         (list1[i]['materials'] as List).add(list2[j]);
        }
      }
    }
    print('===================== CHECK ==================================');
    print(arrRemoveIds);
    // print(arrRemoveIds.length);
    // print(save_data_for_names);
    // final loop
    var sum = 0;
    for (int p = 0; p < arrRemoveIds.length; p++) {
      //
      // print(arrRemoveIds[p]);
      for (int o = 0; o < save_data_for_names.length; o++) {
        //
        // print(save_data_for_names[0]);
        if (arrRemoveIds[p]['id'].toString() ==
            save_data_for_names[o]['id'].toString()) {
          // print('object');
          sum += 1;
        }
      }
    }
    print(sum);
    setState(() {
      str_team_loader = '1';
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          'Active Team',
          Colors.white,
          14.0,
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
                          child: GestureDetector(
                            onTap: () {
                              //
                              funcManageAllMembers();
                            },
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

                  for (var i = 0; i < arrRemoveIds.length; i++) ...[
                    ExpansionTile(
                      title: Text(
                        //
                        arrRemoveIds[i]['name'].toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                        ),
                      ),
                      children: [
                        for (var j = 0;
                            j < arrRemoveIds[i]['data'].length;
                            j++) ...[
                          // Text(
                          //   arrRemoveIds[i]['data'][j]['name'].toString(),
                          // )
                          ListTile(
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                // color: Colors.blueAccent[200],
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: Center(
                                child: text_bold_style_custom(
                                  func_get_initials(
                                    //
                                    arrRemoveIds[i]['data'][j]['name']
                                        .toString(),
                                  ),
                                  Colors.white,
                                  16.0,
                                ),
                              ),
                            ),
                            title: text_bold_style_custom(
                              //
                              arrRemoveIds[i]['data'][j]['name'].toString(),
                              Colors.black,
                              18.0,
                            ),
                            subtitle: text_regular_style_custom(
                              //
                              'Skills : ${arrRemoveIds[i]['data'][j]['skills']}',
                              Colors.orange,
                              14.0,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ],
                  //
                ],
              ),
            ),
    );
  }

  func_get_initials(String str_name) {
    var initials_are = str_name.split(' ');

    var final_initial_name = '';
    // print(initials_are.length);
    if (initials_are.length == 1) {
      final_initial_name = initials_are[0][0].toString().toUpperCase();
    } else if (initials_are.length == 2) {
      final_initial_name =
          (initials_are[0][0] + initials_are[1][0]).toString().toUpperCase();
    } else {
      final_initial_name = initials_are[0][0].toString().toUpperCase();
    }
    return final_initial_name;
  }
}
