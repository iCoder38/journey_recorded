// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:journey_recorded/training/training_header.dart';

class TrainingQuotesScreen extends StatefulWidget {
  const TrainingQuotesScreen(
      {super.key,
      required this.str_training_quote_skill_class,
      required this.str_training_quote_next_level});

  final String str_training_quote_skill_class;
  final String str_training_quote_next_level;
  @override
  State<TrainingQuotesScreen> createState() => _TrainingQuotesScreenState();
}

class _TrainingQuotesScreenState extends State<TrainingQuotesScreen> {
  // quotes
  var str_main_loader = '0';
  var arr_quotes_list = [];
  //
  @override
  void initState() {
    super.initState();
    func_quotes_WB();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          // header
          TrainingHeaderScreen(
            str_skill_class: widget.str_training_quote_skill_class.toString(),
            str_next_level_xp: widget.str_training_quote_next_level.toString(),
          ),
          //
          if (str_main_loader == 'quotes_loader_start')
            const CustomeLoaderPopUp(
              str_custom_loader: 'please wait...',
              str_status: '3',
            )
          else if (str_main_loader == 'quotes_data_empty')
            const CustomeLoaderPopUp(
              str_custom_loader: 'Quotes not Added Yet',
              str_status: '4',
            )
          else
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
                                //print(index);
                                /*str_get_quote_id = arr_quotes_list[index]
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

                              gear_popup_2(
                                arr_quotes_list[index]['name'].toString(),
                                arr_quotes_list[index]['quoteId'].toString(),
                              );*/
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
      ),
    );
  }

  // QUOTES
  Future func_quotes_WB() async {
    print('=====> POST : QUOTES');

    // str_UI_show = 'n.a.';
    // str_bottom_bar_color = '0';

    setState(() {
      str_main_loader = 'quotes_loader_start';
    });

    // SharedPreferences prefs = await SharedPreferences.getInstance();

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
          // 'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'profesionalId': '21'.toString(),
          'profesionalType': 'Training',
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

        if (arr_quotes_list.isEmpty) {
          setState(() {
            str_main_loader = 'quotes_data_empty';
          });
        } else {
          setState(() {
            str_main_loader = 'quotes_loader_stop';
          });
        }
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
