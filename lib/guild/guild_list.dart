// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/guild/guild.dart';
import 'package:journey_recorded/guild/guild_after_join/guild_after_join.dart';
import 'package:journey_recorded/guild/guild_details/guild_details.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuildList extends StatefulWidget {
  const GuildList({super.key});

  @override
  State<GuildList> createState() => _GuildListState();
}

class _GuildListState extends State<GuildList> {
  //
  var str_show_delete = '0';
  //
  var str_login_id = '';
  //
  var str_guild_loader = '0';
  var arr_guild_list = [];
  //
  TextEditingController cont_search = TextEditingController();
  //
  var str_save_and_continue_loader = '0';
  //
  @override
  void initState() {
    super.initState();
    //
    get_goals_list_WB('');
    //
  }

  get_goals_list_WB(
    String str_search,
  ) async {
    print('=====> POST : GUILD LIST');

    // setState(() {
    //   str_guild_loader = '1';
    // });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getInt('userId').toString());
    //
    str_login_id = prefs.getInt('userId').toString();
    //
    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'gulidlist',
          'userId': prefs.getInt('userId').toString(),
          'searchKey': str_search.toString(),
          // 'own': '',
          // 'subGoal': '2'
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
        arr_guild_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          arr_guild_list.add(get_data['data'][i]);
        }

        if (str_show_delete == '1') {
          str_show_delete = '0';
          Navigator.of(context).pop();
        }

        if (arr_guild_list.isEmpty) {
          setState(() {
            str_guild_loader = '2';
            str_save_and_continue_loader = '1';
          });
        } else {
          setState(() {
            str_guild_loader = '1';
            str_save_and_continue_loader = '1';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigation_color,
        toolbarHeight: 170,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: (str_save_and_continue_loader == '0')
            ? const CircularProgressIndicator()
            : Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.chevron_left,
                          ),
                        ),
                        //
                        Text(
                          //
                          // text_nearby_friend,
                          'Guild',
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 58,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        14.0,
                      ),
                    ),
                    child: TextField(
                      controller: cont_search,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) {
                        if (kDebugMode) {
                          print("Go button is clicked");
                        }
                        //
                        setState(() {
                          str_save_and_continue_loader = '0';
                        });
                        //
                        get_goals_list_WB(
                          cont_search.text.toString(),
                        );
                        //
                        // func_get_all_users_near_you();
                        //
                      },
                      decoration: const InputDecoration(
                        // labelText: "Search",
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

        /*Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Chats',
                    style: TextStyle(
                      fontFamily: font_family_name,
                      color: Colors.black,
                    ),
                  ),
                  TextField(
                    controller: cont_search,
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            25.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),*/
        /*Text(
          'User Profile'.toUpperCase(),
          style: TextStyle(
            fontFamily: font_family_name,
          ),
        ),*/
        /*leading: IconButton(
          onPressed: () {
            if (kDebugMode) {
              print('');
            }
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
          ),
        ),*/
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              /*gradient: LinearGradient(
              colors: [
                Color.fromRGBO(170, 0, 20, 1),
                Color.fromRGBO(180, 30, 20, 1),
                Color.fromRGBO(218, 115, 32, 1),
                Color.fromRGBO(227, 142, 36, 1),
                Color.fromRGBO(236, 170, 40, 1),
                Color.fromRGBO(248, 198, 40, 1),
                Color.fromRGBO(252, 209, 42, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),*/
              ),
        ),
      ),
      /*appBar: AppBar(
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
          'Guild',
          //
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (kDebugMode) {
            print('qwkhfcfhgvjb');
          }
          //
          push_to_add_guild(context);
        },
        backgroundColor: navigation_color,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: (str_guild_loader == '2')
            ? const CustomeLoaderPopUp(
                str_custom_loader: 'No Data found.',
                str_status: '4',
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: arr_guild_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print(arr_guild_list[index]);
                      }
                      //
                      if (arr_guild_list[index]['youJoin'].toString() ==
                          'Yes') {
                        if (kDebugMode) {
                          print('object 1');
                        }

                        //
                        push_to_guilld_details(context, arr_guild_list[index]);
                        //
                      } else {
                        if (kDebugMode) {
                          print('object ??');
                        }

                        // push_to_guild_details(
                        //   context,
                        //   arr_guild_list[index],
                        // );

                        //
                        push_to_guilld_details(context, arr_guild_list[index]);
                        //
                      }
                      //
                    },
                    child: Container(
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
                            child: (arr_guild_list[index]['imge'].toString() !=
                                    '')
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      arr_guild_list[index]['imge'].toString(),
                                    ),
                                    radius: 60,
                                  )
                                : Align(
                                    child: Text(
                                      //
                                      func_get_initials(arr_guild_list[index]
                                              ['name']
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

                        trailing: (arr_guild_list[index]['userId'].toString() ==
                                str_login_id.toString())
                            ? IconButton(
                                onPressed: () {
                                  if (kDebugMode) {
                                    print('object');
                                  }
                                  //
                                  func_show_delete_guild_alert(
                                      arr_guild_list[index]['gluidId']
                                          .toString());

                                  //
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              )
                            : const SizedBox(
                                height: 0,
                              ),

                        title: Text(
                          //
                          arr_guild_list[index]['name'].toString(),
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
                                'Total Member : ${arr_guild_list[index]['maxNumber']}',
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
                                text:
                                    'Miles : ${arr_guild_list[index]['miles']}',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> push_to_guild_details(BuildContext context, dict_value) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuildDetailsScreen(
          dict_get_data: dict_value,
          str_from_list: 'yes',
        ),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    if (!mounted) return;

    if (result.toString() == 'back') {
      print('object 32');
    }

    setState(() {
      str_guild_loader = '0';
      str_save_and_continue_loader = '0';
    });
    get_goals_list_WB('');
  }

  //
  Future<void> push_to_guilld_details(BuildContext context, dict_value) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuildAfterJoinScreen(
          dict_value: dict_value,
        ),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    if (!mounted) return;

    if (result.toString() == 'back') {
      print('object 32');
    }

    setState(() {
      str_guild_loader = '0';
      str_save_and_continue_loader = '0';
    });
    get_goals_list_WB('');
  }

  Future<void> push_to_add_guild(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GuildScreen(),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    if (!mounted) return;

    setState(() {
      str_guild_loader = '0';
      str_save_and_continue_loader = '0';
    });
    get_goals_list_WB('');
  }

//
  func_show_delete_guild_alert(get_guild_id) {
    // Future<void> _showMyDialog() async {
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
                  'Are you sure you want to delete this Guild ?',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'yes, delete',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  color: Colors.green,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //

                func_delete_guild_WB(get_guild_id.toString());
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
                    'deleting...',
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

  func_delete_guild_WB(
    str_guild_id,
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
    str_show_delete = '1';
    loader_show('');
    //
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
          'action': 'guliddelete',
          'userId': prefs.getInt('userId').toString(),
          'gulidId': str_guild_id.toString(),
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

        get_goals_list_WB('');
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
}
