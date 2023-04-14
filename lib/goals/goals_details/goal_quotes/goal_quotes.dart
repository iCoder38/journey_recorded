// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/goals/goals_details/goal_common_header/goal_common_header.dart';
import 'package:journey_recorded/quotes/add_quotes/add_quotes.dart';
import 'package:journey_recorded/quotes/edit_quotes/edit_quotes.dart';
import 'package:journey_recorded/single_classes/single_class.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class GoalQuotesScreen extends StatefulWidget {
  const GoalQuotesScreen(
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
  State<GoalQuotesScreen> createState() => _GoalQuotesScreenState();
}

class _GoalQuotesScreenState extends State<GoalQuotesScreen> {
  //
  final GetDifferenceBetweenDate parse_days_left = GetDifferenceBetweenDate();
  //

  var str_quotes = '0';
  var arr_quotes_list = [];
  //

  //
  var str_get_quote_id;
  var str_category_name;
  var str_category_id;
  var str_description;
  var str_quote_type;
  var str_name;

  //
  // slider
  double _currentSliderValue = 0;
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // str_parse_name = widget.str_get_parse_name;

    print('INIT STATE CALL');
    parse_days_left.func_difference_between_date(widget.str_get_due_date);

    // WEBSERVICE HIT
    func_quotes_WB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('add quote');

          add_quotes_push_via_future(context);
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
            if (str_quotes == '0') ...[
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
                      child: Text(str_loader_title.toString()),
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
                itemCount: arr_quotes_list.length,
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
                          arr_quotes_list[index]['name'].toString(),
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
                            arr_quotes_list[index]['description'].toString(),
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
                                  str_get_quote_id = arr_quotes_list[index]
                                          ['quoteId']
                                      .toString();
                                  str_category_name = arr_quotes_list[index]
                                          ['categoryName']
                                      .toString();
                                  str_category_id = arr_quotes_list[index]
                                          ['categoryId']
                                      .toString();
                                  str_description = arr_quotes_list[index]
                                          ['description']
                                      .toString();
                                  str_quote_type = arr_quotes_list[index]
                                          ['quoteId']
                                      .toString();
                                  str_name =
                                      arr_quotes_list[index]['name'].toString();

                                  gear_popup(
                                    arr_quotes_list[index]['name'].toString(),
                                    arr_quotes_list[index]['quoteId']
                                        .toString(),
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

// QUOTES
  Future func_quotes_WB() async {
    print('=====> POST : QUOTES');

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
          'action': 'quotlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'profesionalId': widget.str_get_goal_id.toString(),
          'profesionalType': widget.str_professional_type.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      arr_quotes_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          // print('object');

          arr_quotes_list.add(i);
        }

        setState(() {
          str_quotes = '1';
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
    String goal_id_is,
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
                    print('edit quotes');
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
                          text: ' Edit Quote',
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
                    print('delete quotes');

                    Navigator.pop(context);
                    delete_goal_WB(goal_id_is);
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
                          text: ' Delete Quotes',
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
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditQuotesScreen(
          str_quotes_id: str_get_quote_id.toString(),
          categoryId: str_category_id.toString(),
          description: str_description.toString(),
          quote_type_id: str_quote_type.toString(),
          quote_type_name: str_name.toString(),
          category_name: str_category_name.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == '1') {
      arr_quotes_list.clear();

      setState(() {
        func_quotes_WB();
      });
    }
  }

  // DELETE ALERT
  Future<void> delete_goal_quotes_POPUP(String str_title) async {
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
                    print('edit');
                    Navigator.pop(context);

                    _navigateAndDisplaySelection(context);
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
                          text: ' Are you sure you want to delete this quote ?',
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
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'yes,delete',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 14.0,
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
  }

  // QUOTES
  Future func_delete_quotes_WB() async {
    print('=====> POST : DELETE QUOTES');

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
          'action': 'quotlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'profesionalId': widget.str_get_goal_id.toString(),
          'profesionalType': 'Goal',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    // print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          // print('object');

          arr_quotes_list.add(i);
        }

        setState(() {
          str_quotes = '1';
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

  // delete goal
  delete_goal_WB(
    String quote_id,
  ) async {
    print('=====> POST : DELETE QUOTES');

    str_loader_title = '0';
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
          'action': 'quotedelete',
          'userId': prefs.getInt('userId').toString(),
          'quoteId': quote_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_quotes_list = [];
        //
        func_quotes_WB();
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

  Future<void> add_quotes_push_via_future(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddQuotesScreen(
          str_add_quotes_main_id: widget.str_get_goal_id.toString(),
          str_profession_type: widget.str_professional_type.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_add_quotes') {
      // arr_notes_list.clear();
      str_quotes = '0';
      setState(() {});
      print('YES I CAME FROM ADD QUOTE');
      func_quotes_WB();
    }
  }
}
