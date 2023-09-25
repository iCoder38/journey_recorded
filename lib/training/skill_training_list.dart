// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:journey_recorded/training/create_task/create_training.dart';
import 'package:journey_recorded/training/training_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkillTrainingListScreen extends StatefulWidget {
  const SkillTrainingListScreen(
      {super.key, required this.str_skill_id, required this.strClassName});

  final String str_skill_id;
  final String strClassName;

  @override
  State<SkillTrainingListScreen> createState() =>
      _SkillTrainingListScreenState();
}

class _SkillTrainingListScreenState extends State<SkillTrainingListScreen> {
  //
  var str_main_loader = '0';
  var arr_training_list = [];
  //
  @override
  void initState() {
    super.initState();

    get_goals_list_WB();
  }

  // get cart
  get_goals_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : SKILL => TRAINING LIST');
    }

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
          'action': 'traininglist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'skillId': widget.str_skill_id.toString()
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
        arr_training_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_training_list.add(get_data['data'][i]);
        }

        if (arr_training_list.isEmpty) {
          str_main_loader = '2';
        } else {
          str_main_loader = '3';
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
    return Scaffold(
      appBar: AppBar(
        title: text_bold_style_custom(
          'Training',
          Colors.white,
          16.0,
        ),
        backgroundColor: navigation_color,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: <Widget>[
          if (str_main_loader == '0')
            const CustomeLoaderPopUp(
              str_custom_loader: 'please wait...',
              str_status: '3',
            )
          else if (str_main_loader == '2')
            InkWell(
              onTap: () {
                if (kDebugMode) {
                  print('object');
                }

                push_add_training(context);
              },
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Align(
                  child: RichText(
                    text: TextSpan(
                      text: 'Training not Added Yet.',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: '\n\nClick here to ',
                        ),
                        const TextSpan(
                          text: ' +Add',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '  training.',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          else
            Column(
              children: [
                for (int i = 0; i < arr_training_list.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainingListScreen(
                              str_category: arr_training_list[i]['categoryName']
                                  .toString(),
                              str_next_level_xp:
                                  '${int.parse(arr_training_list[i]['currentLavel'].toString()) + 1}',
                              str_skill_class:
                                  arr_training_list[i]['SkillClass'].toString(),
                              str_frequncy:
                                  arr_training_list[i]['Frequency'].toString(),
                              str_skill_name:
                                  arr_training_list[i]['skillName'].toString(),
                              str_stats:
                                  arr_training_list[i]['TStats'].toString(),
                              str_training_name: arr_training_list[i]
                                      ['TrainingName']
                                  .toString(),
                              str_description: arr_training_list[i]
                                      ['description']
                                  .toString(),
                              str_hr_to_learn: arr_training_list[i]
                                      ['HourToLearn']
                                  .toString(),
                              str_image:
                                  arr_training_list[i]['image'].toString(),
                              str_skill_id:
                                  arr_training_list[i]['skillId'].toString(),
                              str_date_time: arr_training_list[i]['SetReminder']
                                  .toString(),
                              str_training_id:
                                  arr_training_list[i]['trainingId'].toString(),
                            ),
                          ),
                        );*/
                      },
                      child: Container(
                        height: 46,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 20,
                              height: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: (arr_training_list[i]['image']
                                          .toString() ==
                                      '')
                                  ? Image.asset('assets/images/logo.png')
                                  : FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/loader.gif',
                                      image: arr_training_list[i]['image']
                                          .toString(),
                                    ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.transparent,
                                child: Text(
                                  //
                                  arr_training_list[i]['TrainingName']
                                      .toString(),
                                  //
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 18.0,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                right: 20.0,
                              ),
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(
                                  250,
                                  0,
                                  60,
                                  1,
                                ),
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  //
                                  'Level : ${int.parse(arr_training_list[i]['currentLavel'].toString()) + 1}',
                                  //
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
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
                  // const SizedBox(
                  //   height: 10,
                  // ),
                ],
              ],
            ),
        ],
      ),
    );
  }

  //
  Future<void> push_add_training(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTrainingScreen(
          str_skill_id: widget.str_skill_id.toString(),
          str_skill_class: widget.strClassName.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'training_added') {
      setState(() {
        str_main_loader = '0';
      });
      get_goals_list_WB();
    }
  }
}
