// ignore_for_file: non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddQuotesScreen extends StatefulWidget {
  const AddQuotesScreen(
      {super.key,
      required this.str_add_quotes_main_id,
      required this.str_profession_type});

  final String str_add_quotes_main_id;
  final String str_profession_type;

  @override
  State<AddQuotesScreen> createState() => _AddQuotesScreenState();
}

class _AddQuotesScreenState extends State<AddQuotesScreen> {
  var str_create_quote_loader = '0';
  //
  var arr_get_category_list = [];
  //
  var str_goal_for_id = '';
  var str_category_id = '';
  var txt_category = '';
  //
  var str_quote_type_id = '';
  // var str_quotes_name = '';
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
  // password
  late final TextEditingController cont_category;
  // password
  late final TextEditingController cont_quote_type;
  // password
  late final TextEditingController cont_text;
  //
  @override
  void initState() {
    // print('rajputana');
    // print(widget.str_add_quotes_main_id.toString());
    cont_category = TextEditingController();
    cont_quote_type = TextEditingController();
    cont_text = TextEditingController();

    get_category_list_WB();

    super.initState();
  }

  @override
  void dispose() {
    cont_category.dispose();
    cont_quote_type.dispose();
    cont_text.dispose();

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
    // print('dushu');
    // print(get_data['data']);
    // print('dushu');
    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_get_category_list = get_data['data'];

        // print('dushu');
        // print(arr_get_category_list);
        // print('dushu');
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

  // get category list
  get_quotes_type_WB() async {
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
          'name': cont_quote_type.text.toString(),
          'userId': prefs.getInt('userId').toString(),
          'categoryId': str_category_id.toString(),
          'quoteType': str_quote_type_id.toString(),
          'description': cont_text.text.toString(),
          'profesionalId': widget.str_add_quotes_main_id.toString(),
          'profesionalType': widget.str_profession_type.toString(),
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

        Navigator.pop(context, 'get_back_from_add_quotes');
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
          'Create quotes',
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
          onPressed: () => Navigator.pop(
            context,
            'get_back_from_add_quotes',
          ),
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
                // keyboardType: TextInputType.number,
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
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Text',
                ),
              ),
            ),
            (str_create_quote_loader == '0')
                ? InkWell(
                    onTap: () {
                      str_create_quote_loader = '1';
                      setState(() {});
                      get_quotes_type_WB();
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
                : Container(
                    margin: const EdgeInsets.all(
                      10.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                      color: Colors.transparent,
                    ),
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          CircularProgressIndicator(
                            color: navigation_color,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'submitting...',
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                            ),
                          )
                        ],
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
}
