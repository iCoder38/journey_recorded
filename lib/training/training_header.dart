// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class TrainingHeaderScreen extends StatefulWidget {
  const TrainingHeaderScreen(
      {super.key,
      required this.str_skill_class,
      required this.str_next_level_xp});

  final String str_skill_class;
  final String str_next_level_xp;

  @override
  State<TrainingHeaderScreen> createState() => _TrainingHeaderScreenState();
}

class _TrainingHeaderScreenState extends State<TrainingHeaderScreen> {
  //
  var str_UI_show = 'n.a.';
  var str_bottom_bar_color = '0';
  //
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.amber,
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
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 5,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 200 - 30,
                width: 2,
                color: Colors.amber,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 10.0,
                  ),
                  height: 200 - 30,
                  color: Colors.amber,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.pink,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              //
                              //widget.str_category.toString(),
                              'category',
                              //
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.brown,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              '123',
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(
            2,
            26,
            78,
            1,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  child: Text(
                    'Skill Class : ${widget.str_skill_class}',
                    // 'skill class',

                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                width: 1,
                color: Colors.grey,
              ),
              Expanded(
                child: Align(
                  child: Text(
                    'Next LV XP : ${widget.str_next_level_xp}',
                    // 'next',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 52,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(
            250,
            0,
            28,
            1,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    /*str_UI_show = 'routine';
                    str_bottom_bar_color = 'routine_click';*/
                    setState(() {});
                  },
                  child: Container(
                    height: 80,
                    width: 120,
                    decoration: (str_bottom_bar_color == 'routine_click')
                        ? const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 3,
                              ),
                            ),
                          )
                        : const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 0,
                              ),
                            ),
                          ),
                    child: Align(
                      child: Text(
                        'Routine',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    str_UI_show = 'check_list';
                    str_bottom_bar_color = 'check_list_click';
                    setState(() {});
                  },
                  child: Container(
                    height: 80,
                    width: 120,
                    // color: Colors.transparent,
                    decoration: (str_bottom_bar_color == 'check_list_click')
                        ? const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 3,
                              ),
                            ),
                          )
                        : const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 0,
                              ),
                            ),
                          ),
                    child: Align(
                      child: Text(
                        'Check List',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    str_UI_show = 'stats';
                    str_bottom_bar_color = 'stats_click';
                    setState(() {});
                  },
                  child: Container(
                    height: 80,
                    width: 120,
                    decoration: (str_bottom_bar_color == 'stats_click')
                        ? const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 3,
                              ),
                            ),
                          )
                        : const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 0,
                              ),
                            ),
                          ),
                    child: Align(
                      child: Text(
                        'Stats',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    str_UI_show = 'frequency';
                    str_bottom_bar_color = 'frequency_click';
                    setState(() {});
                  },
                  child: Container(
                    height: 80,
                    width: 120,
                    decoration: (str_bottom_bar_color == 'frequency_click')
                        ? const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 3,
                              ),
                            ),
                          )
                        : const BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                width: 0,
                              ),
                            ),
                          ),
                    child: Align(
                      child: Text(
                        'Frequency',
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
            ),
          ),
        ),
      ],
    );
  }
}
