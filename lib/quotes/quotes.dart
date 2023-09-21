// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/quotes/add_quotes/add_quotes.dart';
import 'package:journey_recorded/quotes/edit_quotes/edit_quotes.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  //
  var str_selected_category_id = '1';
  var str_selected_category_name = 'All';
  var arr_get_category_list = [];
  var str_category_loader = '0';
  var str_main_loader = '0';
  //
  var str_quotes_status = '1';
  var arr_quotes = [];
  //
  @override
  void initState() {
    super.initState();
    //

    get_category_list_WB();

    //
  }

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
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //

        for (var i = 0; i < get_data['data'].length; i++) {
          arr_get_category_list.add(get_data['data'][i]);
        }
        // setState(() {});
        str_category_loader = '1';
        get_quotes_list_WB(
          '1',
        );
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  // quotes list
  get_quotes_list_WB(
    String str_quote_type,
  ) async {
    print('=====> POST : QUOTE LIST');

    str_main_loader = '0';
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
          'action': 'quotlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'quoteType': str_quote_type.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_quotes.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          arr_quotes.add(get_data['data'][i]);
        }

        if (arr_quotes.isEmpty) {
          str_main_loader = '2';
        } else {
          str_main_loader = '1';
        }

        setState(() {});
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: text_bold_style_custom(
              'Quotes',
              Colors.white,
              16.0,
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: navigation_color,
            bottom: TabBar(
              indicatorColor: Colors.lime,
              isScrollable: true,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'Affirmations',
                    Colors.white,
                    14.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'Quotes',
                    Colors.white,
                    14.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'Strong Why',
                    Colors.white,
                    14.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text_regular_style_custom(
                    'Consequences',
                    Colors.white,
                    14.0,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     'Category',
                //     style: TextStyle(
                //       fontFamily: font_style_name,
                //       fontSize: 20.0,
                //       backgroundColor: Colors.transparent,
                //     ),
                //   ),
                // ),
              ],
              onTap: (value) {
                print(value);

                if (value == 0) {
                  str_quotes_status = '1';
                } else if (value == 1) {
                  str_quotes_status = '2';
                } else if (value == 2) {
                  str_quotes_status = '3';
                } else if (value == 3) {
                  str_quotes_status = '4';
                }

                str_selected_category_name = 'All';
                setState(() {});

                get_quotes_list_WB(
                  str_quotes_status.toString(),
                );

                // setState(() {});
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    // print('object');
                    add_quotes_push_via_future(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     // func_push_from_floating_button();
          //   },
          //   backgroundColor: Colors.amber,
          //   child: const Icon(Icons.add),
          // ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            //controller: _tabController,
            children: <Widget>[
              // tab 1
              if (str_main_loader == '0')
                Column(
                  children: <Widget>[
                    //
                    click_cateogory_UI(context),
                    //
                    const CustomeLoaderPopUp(
                      str_custom_loader: 'please wait...',
                      str_status: '3',
                    ),
                  ],
                )
              else if (str_main_loader == '2')
                Column(
                  children: <Widget>[
                    //
                    click_cateogory_UI(context),
                    //
                    const CustomeLoaderPopUp(
                      str_custom_loader: 'No Data Found',
                      str_status: '4',
                    ),
                  ],
                )
              else
                tab_1_UI(context),

              // tab 2
              if (str_main_loader == '0')
                Column(
                  children: <Widget>[
                    //
                    click_cateogory_UI(context),
                    //
                    const CustomeLoaderPopUp(
                      str_custom_loader: 'please wait...',
                      str_status: '3',
                    ),
                  ],
                )
              else if (str_main_loader == '2')
                Column(
                  children: <Widget>[
                    //
                    click_cateogory_UI(context),
                    //
                    const CustomeLoaderPopUp(
                      str_custom_loader: 'No Data Found',
                      str_status: '4',
                    ),
                  ],
                )
              else
                tab_1_UI(context),

              // tab 3
              if (str_main_loader == '0')
                Column(
                  children: <Widget>[
                    //
                    click_cateogory_UI(context),
                    //
                    const CustomeLoaderPopUp(
                      str_custom_loader: 'please wait...',
                      str_status: '3',
                    ),
                  ],
                )
              else if (str_main_loader == '2')
                Column(
                  children: <Widget>[
                    //
                    click_cateogory_UI(context),
                    //
                    const CustomeLoaderPopUp(
                      str_custom_loader: 'No Data Found',
                      str_status: '4',
                    ),
                  ],
                )
              else
                tab_1_UI(context),

              // tab 4
              if (str_main_loader == '0')
                Column(
                  children: <Widget>[
                    //
                    click_cateogory_UI(context),
                    //
                    const CustomeLoaderPopUp(
                      str_custom_loader: 'please wait...',
                      str_status: '3',
                    ),
                  ],
                )
              else if (str_main_loader == '2')
                Column(
                  children: <Widget>[
                    //
                    click_cateogory_UI(context),
                    //
                    const CustomeLoaderPopUp(
                      str_custom_loader: 'No Data Found',
                      str_status: '4',
                    ),
                  ],
                )
              else
                tab_1_UI(context),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView tab_1_UI(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          /*(str_category_loader == '0')
              ? const CircularProgressIndicator()
              : */
          click_cateogory_UI(context),
          //
          for (int i = 0; i < arr_quotes.length; i++) ...[
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 26.0,
                      ),
                      child: Text(
                        //
                        arr_quotes[i]['name'].toString(),
                        //
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 0.0,
                            left: 20.0,
                            right: 10.0,
                          ),
                          // height: 70,
                          // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(
                              2,
                              24,
                              72,
                              1,
                            ),
                            borderRadius: BorderRadius.circular(
                              12.0,
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
                          child: Padding(
                            padding: const EdgeInsets.all(
                              12.0,
                            ),
                            child: Text(
                              //
                              arr_quotes[i]['description'].toString(),
                              //
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 10.0,
                        ),
                        height: 40,
                        width: 40,
                        //
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(
                                0,
                                3,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            print('edit number');

                            edit_delete_quote_action_sheet(
                              context,
                              arr_quotes[i]['quoteId'].toString(),
                              arr_quotes[i]['categoryId'].toString(),
                              arr_quotes[i]['description'].toString(),
                              arr_quotes[i]['quoteType'].toString(),
                              arr_quotes[i]['name'].toString(),
                              arr_quotes[i]['categoryName'].toString(),
                            );
                          },
                          icon: Icon(
                            Icons.settings,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  InkWell click_cateogory_UI(BuildContext context) {
    return InkWell(
      onTap: () {
        open_category_list(context);
      },
      child: Container(
        color: Colors.amber,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                  right: 20,
                  bottom: 10,
                ),
                height: 60,
                // width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      //
                      str_selected_category_name.toString(),
                      //
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  Column tabbar_UI(BuildContext context) {
    if (str_main_loader == '0') {
      return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(
                left: 26.0,
              ),
              child: const Text(
                '123',
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 0.0,
              left: 20.0,
              right: 20.0,
            ),
            // height: 70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(
                2,
                24,
                72,
                1,
              ),
              borderRadius: BorderRadius.circular(
                12.0,
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
            child: Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: Text(
                '2112',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(
                left: 26.0,
              ),
              child: const Text(
                '123',
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 0.0,
              left: 20.0,
              right: 20.0,
            ),
            // height: 70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(
                2,
                24,
                72,
                1,
              ),
              borderRadius: BorderRadius.circular(
                12.0,
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
            child: Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: Text(
                '2112',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Future<void> edit_quotes(
    BuildContext context,
    String str_get_quote_id,
    String str_category_id,
    String str_description,
    String str_quote_type,
    String str_name,
    String str_category_name,
  ) async {
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

    print('result =====> ' + result);

    if (!mounted) return;

    print(str_quotes_status);

    get_quotes_list_WB(
      str_quotes_status.toString(),
    );
  }

  // open action sheet
  void open_category_list(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Categories',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 16.0,
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          //
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () {
              Navigator.pop(context);

              str_selected_category_name = 'All';
              setState(() {});

              get_quotes_list_WB(
                str_quotes_status.toString(),
              );
            },
            child: Text(
              'All',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //
          for (int i = 0; i < arr_get_category_list.length; i++) ...[
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);

                str_selected_category_name =
                    arr_get_category_list[i]['name'].toString();
                setState(() {});

                str_selected_category_id =
                    arr_get_category_list[i]['id'].toString();

                get_quotes_list_with_category_WB();
              },
              child: Text(
                //
                arr_get_category_list[i]['name'].toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // quotes list
  get_quotes_list_with_category_WB() async {
    print('=====> POST : QUOTE LIST');

    str_main_loader = '0';
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
          'action': 'quotlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'quoteType': str_quotes_status.toString(),
          'categoryId': str_selected_category_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_quotes.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          arr_quotes.add(get_data['data'][i]);
        }

        if (arr_quotes.isEmpty) {
          str_main_loader = '2';
        } else {
          str_main_loader = '1';
        }

        setState(() {});
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
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddQuotesScreen(
          str_add_quotes_main_id: prefs.getInt('userId').toString(),
          str_profession_type: 'Profile'.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_add_quotes') {
      get_quotes_list_WB(
        str_quotes_status.toString(),
      );
    }
  }

  // open action sheet
  void edit_delete_quote_action_sheet(
    BuildContext context,
    String str_get_quote_id,
    String str_category_id,
    String str_description,
    String str_quote_type,
    String str_name,
    String str_category_name,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Categories',
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 16.0,
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          //
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () {
              Navigator.pop(context);

              edit_quotes(
                context,
                str_get_quote_id.toString(),
                str_category_id.toString(),
                str_description.toString(),
                str_quote_type.toString(),
                str_name.toString(),
                str_category_name.toString(),
              );
            },
            child: Text(
              'Edit',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //

          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              delete_quote_WB(
                str_get_quote_id.toString(),
              );
            },
            child: Text(
              //
              'Delete',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          ),

          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
                // color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // delete list
  delete_quote_WB(
    String str_delete_id,
  ) async {
    print('=====> POST : QUOTE LIST');

    str_main_loader = '0';
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
          'quoteId': str_delete_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_quotes.clear();

        //
        get_quotes_list_WB(
          str_quotes_status.toString(),
        );
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
}
