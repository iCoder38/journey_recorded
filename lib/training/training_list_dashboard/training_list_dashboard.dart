// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:journey_recorded/training/training_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/custom_files/app_bar/app_bar.dart';

class TrainingListFromDashboard extends StatefulWidget {
  const TrainingListFromDashboard({super.key});

  @override
  State<TrainingListFromDashboard> createState() =>
      _TrainingListFromDashboardState();
}

class _TrainingListFromDashboardState extends State<TrainingListFromDashboard> {
  //
  var str_main_loader = '0';
  var loaderAlertMessage = 'qw';

  var arr_training_list = [];

  @override
  void initState() {
    super.initState();

    //
    get_goals_list_WB();
    //
  }

  get_goals_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : SKILL => TRAINING LIST 1.0');
    }
    //
    // str_main_loader = loaderAlertMessage.toString();

    loaderAlertMessage = '0';

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
        // get and parse data
        arr_training_list.clear();
        for (var i = 0; i < getData['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_training_list.add(getData['data'][i]);
        }

        if (arr_training_list.isEmpty) {
          str_main_loader = '0';
          loaderAlertMessage = '2';
        } else {
          str_main_loader = '3';
        }

        setState(() {
          // str_main_loader = loaderAlertMessage.toString();
        });
      } else {
        if (kDebugMode) {
          print(
            '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
          );
        }
      }
    } else {
      // return postList;
      if (kDebugMode) {
        print('something went wrong');
      }
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: "Training",
        str_back_button_status: '1',
      ),
      body: (str_main_loader == '0')
          ? (loaderAlertMessage == '2')
              ? const CustomeLoaderPopUp(
                  str_custom_loader: 'Training not added yet.',
                  str_status: '4',
                )
              : const CustomeLoaderPopUp(
                  str_custom_loader: 'Please wait...',
                  str_status: '0',
                )
          : Column(
              children: [
                for (int i = 0; i < arr_training_list.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        if (kDebugMode) {
                          print('12');
                        }
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainingListScreen(
                              str_skill_id:
                                  arr_training_list[i]['skillId'].toString(),
                              str_training_id:
                                  arr_training_list[i]['trainingId'].toString(),
                            ),
                          ),
                        );
                        //
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
    );
  }
}
