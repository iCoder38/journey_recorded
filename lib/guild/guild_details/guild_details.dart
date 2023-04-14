// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/guild/guild_access_code/access_code.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuildDetailsScreen extends StatefulWidget {
  const GuildDetailsScreen(
      {super.key, this.dict_get_data, required this.str_from_list});

  final dict_get_data;
  final String str_from_list;

  @override
  State<GuildDetailsScreen> createState() => _GuildDetailsScreenState();
}

class _GuildDetailsScreenState extends State<GuildDetailsScreen> {
  //
  var custom_arr = [];
  var str_member_loader = '0';
  var arr_members_list = [];
  //
  var str_join_guild_now_status = '1';
  //
  var str_info_select = '1';
  var str_members_select = '0';
  //
  var str_login_id = '';
  //
  var str_already_joined = '0';
  //
  var str_members_count = '';
  //
  var str_quit_loader = '1';
  //
  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      print(widget.dict_get_data);
    }

    custom_arr = [
      {
        'question': 'Guild Name',
        'answer': widget.dict_get_data['name'].toString(),
      },
      {
        'question': 'Subject of Guild',
        'answer': widget.dict_get_data['subject'].toString(),
      },
      {
        'question': 'Donation',
        'answer': widget.dict_get_data['Donation'].toString(),
      },
      {
        'question': 'Creator Name',
        'answer': widget.dict_get_data['createrName'].toString(),
      },
      {
        'question': 'Access code',
        'answer': widget.dict_get_data['accessCode'].toString(),
      },
      {
        'question': 'Purpose of this guild',
        'answer': widget.dict_get_data['Description'].toString(),
      },
      {
        'question': 'Guild radius',
        'answer': widget.dict_get_data['miles'].toString(),
      },
      {
        'question': 'What is our goal to you',
        'answer': widget.dict_get_data['benefit'].toString(),
      },
    ];
    //
    func_get_my_login_id();
    //
  }

  func_get_my_login_id() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    str_login_id = prefs.getInt('userId').toString();
    print(widget.str_from_list);
    print(str_login_id);
    print(widget.dict_get_data['userId'].toString());

    if (widget.dict_get_data['youJoin'].toString() == 'Yes') {
      str_already_joined = '1';
    } else {
      str_already_joined = '0';
    }

    setState(() {});
  }

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
          },
        ),
        title: Text(
          //
          'Guild details',
          //
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          str_info_select = '1';
                          str_members_select = '0';
                        });
                      },
                      child: Container(
                        height: 80,
                        decoration: (str_info_select == '0')
                            ? const BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0,
                                  ),
                                ),
                              )
                            : const BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                  bottom: BorderSide(
                                    width: 3,
                                  ),
                                ),
                              ),
                        child: Align(
                          child: Text(
                            'Info',
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                              color: Colors.black,
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
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          str_info_select = '0';
                          str_members_select = '1';
                        });

                        get_members_list_WB();
                      },
                      child: Container(
                        height: 80,
                        decoration: (str_members_select == '0')
                            ? const BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0,
                                  ),
                                ),
                              )
                            : const BoxDecoration(
                                color: Colors.transparent,
                                border: Border(
                                  bottom: BorderSide(
                                    width: 3,
                                  ),
                                ),
                              ),
                        child: Align(
                          child: Text(
                            'Members $str_members_count',
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                              color: Colors.black,
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
                ],
              ),
            ),
            //
            if (str_info_select == '1')
              guild_details_info_UI(context)
            else
              (str_member_loader == '0')
                  ? const CustomeLoaderPopUp(
                      str_custom_loader: 'please wait...',
                      str_status: '3',
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            color: Colors.black,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: arr_members_list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                // print('object');
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => GuildDetailsScreen(
                                //       dict_get_data: arr_members_list[index],
                                //     ),
                                //   ),
                                // );
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
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: Align(
                                        child: Text(
                                          //
                                          // arr_guild_list[index]['name'].toString(),
                                          func_get_initials(
                                              arr_members_list[index]
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

                                  title: Text(
                                    //
                                    arr_members_list[index]['userName']
                                        .toString(),
                                    //
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Text(
                                  //   'Miles : ${arr_members_list[index]['miles']}',
                                  //   style: TextStyle(
                                  //     fontFamily: font_style_name,
                                  //     color: Colors.black,
                                  //   ),
                                  // ),
                                  /*Text(
                                //
                                'Total Member : ${arr_guild_list[index]['maxNumber']}',
                                // 'category name',
                                //
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 14.0,
                                  color: const Color.fromRGBO(
                                    30,
                                    58,
                                    118,
                                    1,
                                  ),
                                ),
                              ),*/
                                  /*trailing: Container(
                                height: 40,
                                width: 120,
                                decoration: const BoxDecoration(
                                  color: Colors.deepOrangeAccent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      25.0,
                                    ),
                                  ),
                                ),
                                child: Align(
                                  child: Text(
                                    //
                                    'Miles : ${arr_guild_list[index]['miles']}',
                                    //
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),*/
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
          ],
        ),
      ),
    );
  }

  Column guild_details_info_UI(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < custom_arr.length; i++) ...[
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: RichText(
                text: TextSpan(
                  //
                  text: custom_arr[i]['question'].toString(),
                  //
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
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
                      text: //
                          custom_arr[i]['answer'].toString(),
                      //
                      style: TextStyle(
                        fontFamily: font_style_name,
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
        ],
        if (widget.str_from_list == 'yes') ...[
          // user come from guild list
          (str_login_id.toString() == widget.dict_get_data['userId'].toString())
              ? const SizedBox(
                  height: 10,
                )
              : (widget.dict_get_data['youJoin'] == 'Yes')
                  ? Container(
                      margin: const EdgeInsets.all(
                        10.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        color: Colors.green,
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
                          'Joined',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        if (kDebugMode) {
                          print('join this guild now');
                        }
                        //
                        func_show_join_guild_alert();
                        //
                      },
                      child: Container(
                        margin: const EdgeInsets.all(
                          10.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                          color: Colors.green,
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
                          child: (str_quit_loader == '0')
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Join Guild now',
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
        ] else ...[
          // user come here from inside grid details
          (str_login_id.toString() == widget.dict_get_data['userId'].toString())
              ? const SizedBox(
                  height: 0,
                )
              : (widget.dict_get_data['youJoin'] == 'No')
                  ? InkWell(
                      onTap: () {
                        if (kDebugMode) {
                          print('join this guild now');
                        }
                        //
                        func_show_join_guild_alert();
                        //
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
                            'Join Guild now',
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
                  : InkWell(
                      onTap: () {
                        if (kDebugMode) {
                          print('quit this grid');
                        }

                        func_show_quit_guild_alert();
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
                          child: (str_quit_loader == '0')
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Quit',
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

          /*(widget.str_from_list == 'no')
                  ? (str_quit_loader == '0')
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : (widget.dict_get_data['youJoin'] == 'No')
                          ? Text(
                              'Join Guild now',
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Quit',
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                  : Text(
                      'Join Guild now',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),*/
        ]

        /*(str_login_id.toString() == widget.dict_get_data['userId'].toString())
            ? const SizedBox(
                height: 0,
              )
            : (str_join_guild_now_status == '0')
                ? const CustomeLoaderPopUp(
                    str_custom_loader: 'please wait...',
                    str_status: '3',
                  )
                : (str_already_joined == '1')
                    ? Container(
                        margin: const EdgeInsets.all(
                          10.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                          color: Colors.green,
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
                            'Joined',
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          //
                          (widget.str_from_list == 'no')
                              ? (widget.dict_get_data['youJoin'] == 'No')
                                  ? func_show_join_guild_alert() // join
                                  : func_show_quit_guild_alert() // quit
                              : func_show_join_guild_alert(); // join
                          //
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
                            child: (widget.str_from_list == 'no')
                                ? (str_quit_loader == '0')
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : (widget.dict_get_data['youJoin'] == 'No')
                                        ? Text(
                                            'Join Guild now',
                                            style: TextStyle(
                                              fontFamily: font_style_name,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            'Quit',
                                            style: TextStyle(
                                              fontFamily: font_style_name,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          )
                                : Text(
                                    'Join Guild now',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),*/
      ],
    );
  }

  get_members_list_WB() async {
    print('=====> POST : GOAL LIST');

    setState(() {
      str_member_loader = '0';
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
          'action': 'gulidjoinlist',
          // 'userId': prefs.getInt('userId').toString(),
          'gulidId': widget.dict_get_data['gluidId'].toString(),
          'pageNo': '',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        arr_members_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_members_list.add(get_data['data'][i]);
        }

        str_members_count = '( ${arr_members_list.length} )';

        setState(() {
          str_member_loader = '1';
        });
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

  func_show_quit_guild_alert() {
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
                  'Are you sure you want to quit this Guild ?',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'yes, quit',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  color: Colors.green,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //

                func_remove_save_and_continue_WB();
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

  //
  func_show_join_guild_alert() {
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
                  'Are you sure you want to join this Guild ?',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'yes, join',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  color: Colors.green,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccessCodeScreen(
                      str_access_code:
                          widget.dict_get_data['accessCode'].toString(),
                      str_guild_name: widget.dict_get_data['name'].toString(),
                      str_guild_id: widget.dict_get_data['gluidId'].toString(),
                    ),
                  ),
                );
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
  //

  func_save_and_continue_WB() async {
    if (kDebugMode) {
      print('object');
    }
    setState(() {
      str_join_guild_now_status = '0';
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
          'action': 'gulidjoin',
          'userId': prefs.getInt('userId').toString(),
          'gulidId': widget.dict_get_data['gluidId'].toString(),
          'join': 'Yes',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        arr_members_list.clear();

        setState(() {
          str_already_joined = '1';
          str_join_guild_now_status = '1';
        });
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
  func_remove_save_and_continue_WB() async {
    print('object');
    setState(() {
      str_quit_loader = '0';
      str_join_guild_now_status = '0';
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
          'action': 'gulidjoin',
          'userId': prefs.getInt('userId').toString(),
          'gulidId': widget.dict_get_data['gluidId'].toString(),
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
        //
        setState(() {
          str_quit_loader = '1';
        });
        Navigator.of(context)
          ..pop()
          ..pop('back');
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
