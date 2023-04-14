// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyGuildMembersScreen extends StatefulWidget {
  const MyGuildMembersScreen(
      {super.key, required this.str_guild_id, required this.str_remove_member});

  final String str_guild_id;
  final String str_remove_member;

  @override
  State<MyGuildMembersScreen> createState() => _MyGuildMembersScreenState();
}

class _MyGuildMembersScreenState extends State<MyGuildMembersScreen> {
  //
  var removing_loader = '0';
  var str_guild_loader = '0';
  var arr_members = [];
  //
  @override
  void initState() {
    super.initState();
    //
    getMemberListWB();
    //
  }

  //
  getMemberListWB() async {
    print('=====> POST : MEMBERS LIST');

    // setState(() {
    //   str_guild_loader = '1';
    // });
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
          'action': 'gulidjoinlist',
          'gulidId': widget.str_guild_id.toString(),
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        arr_members.clear();
        for (var i = 0; i < getData['data'].length; i++) {
          arr_members.add(getData['data'][i]);
        }

        if (removing_loader == '1') {
          Navigator.of(context).pop();
          removing_loader = '0';
        }

        if (arr_members.isEmpty) {
          setState(() {
            str_guild_loader = '2';
            // str_save_and_continue_loader = '1';
          });
        } else {
          setState(() {
            str_guild_loader = '1';
            // str_save_and_continue_loader = '1';
          });
        }
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
            onPressed: () {
              Navigator.pop(context, 'back');
            }),
        title: Text(
          //
          'Members',
          //
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: (str_guild_loader == '2')
            ? const CustomeLoaderPopUp(
                str_custom_loader: 'No User found.',
                str_status: '4',
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: arr_members.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(
                      top: 0.0,
                    ),
                    height: 80,
                    color: Colors.transparent,
                    child: ListTile(
                      // iconColor: Colors.pink,
                      leading: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(
                            40.0,
                          ),
                        ),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            // color: Colors.blueAccent[200],
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: (arr_members[index]['profile_picture']
                                      .toString() !=
                                  '')
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    arr_members[index]['profile_picture']
                                        .toString(),
                                  ),
                                  radius: 60,
                                )
                              : Align(
                                  child: Text(
                                    //
                                    func_get_initials(arr_members[index]
                                            ['userName']
                                        .toString()),

                                    //
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      trailing: (widget.str_remove_member == 'no')
                          ? const SizedBox(
                              width: 0,
                            )
                          : IconButton(
                              onPressed: () {
                                func_remove_member_popup(
                                    arr_members[index]['userId'].toString());
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),

                      title: Text(
                        //
                        arr_members[index]['userName'].toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          text:
                              'Total Member : ${arr_members[index]['maxNumber']}',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.orange,
                            // fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: '\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '${arr_members[index]['userAddress']}',
                              style: TextStyle(
                                fontFamily: font_style_name,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

//
  func_remove_member_popup(get_user_id) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Journey Recorded',
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Are you sure you want to remove this member ?',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'yes, remove',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  color: Colors.green,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //

                func_save_and_continue_WB(get_user_id.toString());
                //
              },
            ),
            TextButton(
              child: Text(
                'dismiss',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
// }
  }

  loader_show(get_user_id) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Align(
                  child: Text(
                    'removing...',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
// }
  }

  func_save_and_continue_WB(
    str_user_id,
  ) async {
    //
    if (kDebugMode) {
      print('object');
    }
    //
    setState(() {
      // str_join_guild_now_status = '0';
    });

    //
    removing_loader = '1';
    loader_show('');
    //
    // SharedPreferences prefs = await SharedPreferences.getInstance();
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
          'action': 'gulidjoin',
          'userId': str_user_id.toString(),
          'gulidId': widget.str_guild_id.toString(),
          'join': 'No',
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

        getMemberListWB();
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
  func_get_initials(String str_name) {
    var initials_are = str_name.split(' ');

    var final_initial_name = '';
    // print(initials_are.length);
    // if (initials_are.length == 1) {
    final_initial_name = initials_are[0][0].toString().toUpperCase();
    /*}else if (initials_are.length == 2) {
      final_initial_name =
          (initials_are[0][0] + initials_are[1][0]).toString().toUpperCase();
    } else {
      final_initial_name = initials_are[0][0].toString().toUpperCase();
    }*/
    return final_initial_name;
  }
  //
}
