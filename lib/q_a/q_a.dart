// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/drawer.dart';

class QuestionAndAnswerScreen extends StatefulWidget {
  const QuestionAndAnswerScreen({super.key});

  @override
  State<QuestionAndAnswerScreen> createState() =>
      _QuestionAndAnswerScreenState();
}

class _QuestionAndAnswerScreenState extends State<QuestionAndAnswerScreen> {
  //
  var str_screen_loader = '0';
  //
  var arr_faq_list = [];
  //
  @override
  void initState() {
    //
    get_faq_list_wb();
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          //
          'FAQ(s)', Colors.white, 16.0,
        ),
        backgroundColor: navigation_color,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: const navigationDrawer(),
      body: (str_screen_loader == '0')
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  for (int i = 0; i < arr_faq_list.length; i++) ...[
                    ExpansionTile(
                      title: text_bold_style_custom(
                        //
                        arr_faq_list[i]['question'].toString(),
                        Colors.black,
                        14.0,
                      ),
                      children: <Widget>[
                        Builder(
                          builder: (BuildContext context) {
                            return Container(
                              padding: const EdgeInsets.all(14),
                              alignment: Alignment.center,
                              child: text_regular_style_custom(
                                //
                                arr_faq_list[i]['answer'].toString(),
                                Colors.black,
                                14.0,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
    );
  }

  //
  // get mission details
  get_faq_list_wb() async {
    if (kDebugMode) {
      print('=====> POST : FAQ');
    }

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'faq',
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
        //
        // arr_quest_list.clear();
        // //
        for (var i = 0; i < getData['data'].length; i++) {
          arr_faq_list.add(getData['data'][i]);
        }

        // get_category_list_WB();
        setState(() {
          str_screen_loader = '1';
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
}
