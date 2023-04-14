// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/app_bar/app_bar.dart';
import 'package:journey_recorded/grind/edit_grind/edit_grind.dart';

class GrindDetailsScreen extends StatefulWidget {
  const GrindDetailsScreen({super.key, this.dictShowFullData});

  final dictShowFullData;

  @override
  State<GrindDetailsScreen> createState() => _GrindDetailsScreenState();
}

class _GrindDetailsScreenState extends State<GrindDetailsScreen> {
  //
  var customParse = [];
  //
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print(widget.dictShowFullData);
    }
    //
    customParse = [
      {
        'title': 'Grind name',
        'name': widget.dictShowFullData['grindName'].toString(),
      },
      {
        'title': 'Category name',
        'name': widget.dictShowFullData['categoryName'].toString(),
      },
      {
        'title': 'Priority',
        'name': widget.dictShowFullData['Priority'].toString(),
      },
      {
        'title': 'Descrption',
        'name': widget.dictShowFullData['Descrption'].toString(),
      },
      {
        'title': 'Skill name',
        'name': widget.dictShowFullData['skillName'].toString(),
      },
      {
        'title': 'Habit',
        'name': widget.dictShowFullData['habitName'].toString(),
      },
    ];
    //
  }
  //

/*
grindName: hh,
categoryName: SPIRITUAL, 
skillId: , 
skillName: , 
userId: 3, 
habitId: 10, 
habitName: and habit, 
totalPoint: , 
status: 1, 
Priority: gh, 
Descrption: hh, 
time_to_complete: , 
created: Mar 31st, 2023, 11:04 am
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: 'Grind Details',
        str_back_button_status: '1',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          // as
          pushToCreateGrind(context);
          //
        },
        backgroundColor: navigation_color,
        child: const Icon(
          Icons.edit,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            for (int i = 0; i < customParse.length; i++) ...[
              /*(customParse[i]['name'].toString() == '')
                  ? const SizedBox()
                  : */
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: text_with_bold_style_black(
                    //
                    customParse[i]['title'].toString(),
                    //
                  ),
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.only(
                  top: 0.0,
                  left: 10,
                  right: 10,
                ),
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: 48.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: text_with_regular_style(
                    //
                    customParse[i]['name'].toString(),
                    //
                  ),
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: 0.3,
              ),
              //
            ],
          ],
        ),
      ),
    );
  }

  //
  Future<void> pushToCreateGrind(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditGrindScreen(
          getSelectedGrindData: widget.dictShowFullData,
        ),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    if (!mounted) return;

    if (result == 'back_from_create_grind') {
      setState(() {
        // strGrindLoader = '0';
        // getGrindWB();
      });
    } else {
      //

      //
    }
  }
  //
}
