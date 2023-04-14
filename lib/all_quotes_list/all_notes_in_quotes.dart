import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AllNotesInQuotesScreen extends StatefulWidget {
  const AllNotesInQuotesScreen({super.key, required this.str_category_id});

  final String str_category_id;

  @override
  State<AllNotesInQuotesScreen> createState() => _AllNotesInQuotesScreenState();
}

class _AllNotesInQuotesScreenState extends State<AllNotesInQuotesScreen> {
  //
  var str_quote_list_loader = '0';
  //
  var arr_notes_list = [];
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    func_quotes_list_WB();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          if (str_quote_list_loader == '0')
            const CustomeLoaderPopUp(
              str_custom_loader: 'Please wait...',
              str_status: '3',
            )
          else if (str_quote_list_loader == '2')
            const CustomeLoaderPopUp(
              str_custom_loader: 'no data found...',
              str_status: '1',
            )
          else
            Container(
              // margin: const EdgeInsets.only(
              //   top: 20.0,
              //   left: 20.0,
              //   right: 20.0,
              // ),
              height: 140,
              width: MediaQuery.of(context).size.width,

              decoration: const BoxDecoration(
                color: Colors.pink,
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(
                      54,
                      30,
                      107,
                      1,
                    ),
                    Color.fromRGBO(
                      92,
                      21,
                      93,
                      1,
                    ),
                    Color.fromRGBO(
                      138,
                      0,
                      70,
                      1,
                    ),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(
                        width: 2.0,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 20.0,
                        left: 20.0,
                      ),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        border: Border.all(
                          width: 2.0,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Text(
                                'NEXT LV XP: 1,200',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'CHANGE CATEGORY',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          for (int i = 0; i < arr_notes_list.length; i++) ...[
            Container(
              // height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 20.0,
                  // bottom: 20.0,
                ),
                // height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(1, 24, 72, 1),
                  borderRadius: BorderRadius.circular(
                    20.0,
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
                  // 248 224 28
                  border: Border.all(
                    color: const Color.fromRGBO(
                      248,
                      224,
                      28,
                      1,
                    ),
                    width: 4.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    //
                    arr_notes_list[i]['message'].toString(),
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
          ],
        ],
      ),
    );
  }

  // notes
  func_quotes_list_WB() async {
    print('=====> POST : NOTE LIST');

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
          'action': 'notelist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'profesionalId': '',
          'profesionalType': '',
          'categoryId': widget.str_category_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        //
        arr_notes_list.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_notes_list.add(get_data['data'][i]);
        }

        if (arr_notes_list.isEmpty) {
          str_quote_list_loader = '2';
        } else {
          str_quote_list_loader = '1';
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
}
