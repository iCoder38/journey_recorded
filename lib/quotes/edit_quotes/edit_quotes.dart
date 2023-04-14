// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:journey_recorded/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditQuotesScreen extends StatefulWidget {
  const EditQuotesScreen(
      {super.key,
      required this.str_quotes_id,
      // required this.name,
      required this.description,
      required this.categoryId,
      required this.quote_type_id,
      required this.quote_type_name,
      required this.category_name});

  final String str_quotes_id;
  // final String name;
  final String description;
  final String categoryId;
  final String category_name;
  final String quote_type_id;
  final String quote_type_name;

  @override
  State<EditQuotesScreen> createState() => _EditQuotesScreenState();
}

class _EditQuotesScreenState extends State<EditQuotesScreen> {
  //
  var arr_get_category_list = [];
  //
  var str_goal_for_id = '';
  var str_category_id;
  var txt_category = '';
  //
  var str_quote_type_id;
  // var str_quotes_name = '';
  var str_edit_quotes_type;
  //
  var arr_quotes_list = [
    {
      'id': '1',
      'name': 'Affirmation',
    },
    {
      'id': '2',
      'name': 'Quotes',
    },
    {
      'id': '3',
      'name': 'Strong whys',
    },
    {
      'id': '4',
      'name': 'Consequences',
    },
  ];

  // quotes : edit : category
  TextEditingController cont_category =
      TextEditingController(text: 'please wait...');

  // quotes : edit : type
  TextEditingController cont_quote_type =
      TextEditingController(text: 'please wait...');

  // quotes : edit : password
  TextEditingController cont_text =
      TextEditingController(text: 'please wait...');

  @override
  void initState() {
    /*cont_category = TextEditingController();
    cont_quote_type = TextEditingController();
    cont_text = TextEditingController();*/

    get_category_list_WB();

    // parse value
    cont_quote_type.text = widget.quote_type_name;
    cont_text.text = widget.description;
    cont_category.text = widget.category_name;
    str_category_id = widget.categoryId.toString();
    str_quote_type_id = widget.quote_type_id.toString();

    super.initState();
  }

  @override
  void dispose() {
    /*cont_category.dispose();
    cont_quote_type.dispose();
    cont_text.dispose();*/

    super.dispose();
  }

// get category list
  get_category_list_WB() async {
    print('=====> POST : GET CATEGORY');

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'category',
          // 'userId': prefs.getInt('userId').toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print('dushu');
    // print(get_data['data']);
    print('dushu');
    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_get_category_list = get_data['data'];

        print('dushu');
        print(arr_get_category_list);
        print('dushu');
        setState(() {});
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
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
          'Edit quotes',
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                onTap: () {
                  category_list_POPUP();
                },
                controller: cont_category,

                readOnly: true,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.category,
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                onTap: () {
                  quotes_type_POPUP('');
                },
                controller: cont_quote_type,
                readOnly: true,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.merge_type,
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Quote Type',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                controller: cont_text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Text',
                  labelText: 'Text',
                ),
                maxLines: 3,
              ),
            ),
            InkWell(
              onTap: () {
                func_edit_quote_WB();
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
                    'Edit Quote',
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
      ),
    );
  }

  // ALERT
  Future<void> category_list_POPUP() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Please select Category',
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 16.0,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: ListView.builder(
                    itemCount: arr_get_category_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          //
                          str_category_id =
                              arr_get_category_list[index]['id'].toString();
                          //
                          cont_category.text =
                              arr_get_category_list[index]['name'].toString();
                          //
                          setState(() {});
                        },
                        child: ListTile(
                          leading: const Icon(
                            Icons.category,
                          ),
                          title: Text(
                            arr_get_category_list[index]['name'].toString(),
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
              ],
              //
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

  // ALERT
  Future<void> quotes_type_POPUP(
    String str_message,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Please select Quote Type',
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 16.0,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: ListView.builder(
                    itemCount: arr_quotes_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          //
                          str_quote_type_id =
                              arr_quotes_list[index]['id'].toString();
                          //
                          cont_quote_type.text =
                              arr_quotes_list[index]['name'].toString();
                          //
                          setState(() {});
                        },
                        child: ListTile(
                          leading: const Icon(
                            Icons.category,
                          ),
                          title: Text(
                            //
                            arr_quotes_list[index]['name'].toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
              ],
              //
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

  // get category list
  func_edit_quote_WB() async {
    print('=====> POST : QUOTES TYPE');

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
          'action': 'addquot',
          'quoteId': widget.str_quotes_id.toString(),
          'userId': prefs.getInt('userId').toString(),
          'name': cont_quote_type.text.toString(),
          'description': cont_text.text.toString(),
          'categoryId': str_category_id.toString(),
          'quoteType': str_quote_type_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print('dushu');
    // print(get_data['data']);
    print('dushu');
    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        // arr_get_category_list = get_data['data'];

        print('dushu');
        // print(arr_get_category_list);
        print('dushu');
        // setState(() {});

        Navigator.pop(context, '1'.toString());
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
