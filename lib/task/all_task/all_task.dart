// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/task/all_task/all_task_UI.dart';
import 'package:journey_recorded/task/rewards/rewards.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  //
  var arr_notes = [];
  var custom_dict = [
    {
      'date': '5-December-2022',
    },
    {
      'date': '6-December-2022',
    },
    {
      'date': '7-December-2022',
    },
  ];
  var arr_demo = ['qwerty', 'qwerty', 'qwerty'];
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // arr_notes.add(custom_dict);
    print(custom_dict.length);
    print(custom_dict);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: navigation_color,
            title: Text(
              ///
              navigation_title_all_task,

              ///
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
            actions: const [
              Padding(
                padding: EdgeInsets.only(
                  right: 20.0,
                ),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            bottom: TabBar(
              indicatorColor: Colors.lime,
              isScrollable: true,
              // labelColor: Colors.amber,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Rewards',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Reminder',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Agent',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Notes',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              tabbar_REWARDS_ui(context),
              tabbar_REMINDERS_ui(context),
              check_list_header_UI(context),
              // check_list_header_UI(context),
              tabbar_NOTES_ui(context),
            ],
          ),
        ),
      ),
    );
  }

  Column tabbar_REWARDS_ui(BuildContext context) {
    return Column(
      children: [
        const AllTaskUI(),
        //
        // tab bars (1)
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(
              250,
              187,
              9,
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
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 20,
              ),
              Text(
                'Check List'.toUpperCase(),
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // add button click
                  // RewardsScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RewardsScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(
                      32,
                      52,
                      160,
                      1,
                    ),
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        for (var i = 0; i < 4; i++) ...[
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                const Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.check_box,
                    color: Colors.pink,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Go online to review licenses. needed.',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
        ],
      ],
    );
  }

  Column tabbar_REMINDERS_ui(BuildContext context) {
    return Column(
      children: [
        const AllTaskUI(),
        //
        // tab bars (1)
        /*Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(
              250,
              187,
              9,
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
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 20,
              ),
              Text(
                'Check List'.toUpperCase(),
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // add button click
                  // RewardsScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RewardsScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(
                      32,
                      52,
                      160,
                      1,
                    ),
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),*/
        Container(
          height: 160,
          width: MediaQuery.of(context).size.width,
          color: Colors.pink,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  // width: 20,
                  height: 20,
                  color: Colors.purple,
                  child: Container(
                    margin: const EdgeInsets.all(
                      8.0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    color: const Color.fromRGBO(1, 24, 70, 1),
                    child: Center(
                      child: Text(
                        'time',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  // width: 20,
                  height: 20,
                  color: Colors.brown,
                  child: Container(
                    margin: const EdgeInsets.all(
                      8.0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    color: const Color.fromRGBO(1, 24, 70, 1),
                    child: Center(
                      child: Text(
                        'time',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: Colors.amber,
          child: Center(
            child: Text(
              'WARNING :',
              style: TextStyle(
                fontFamily: font_style_name,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        for (var i = 1; i < 4; i++) ...[
          Container(
            // height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  height: 30,
                  width: 30,
                  color: const Color.fromRGBO(1, 24, 70, 1),
                  child: Center(
                    child: Text(
                      i.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: font_style_name,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'If you fail this task, you will loose double the experience you intend to win.',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
        ],
      ],
    );
  }

  SingleChildScrollView tabbar_NOTES_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const AllTaskUI(),
          //
          // tab bars (1)

          for (var i = 0; i < custom_dict.length; i++) ...[
            Container(
              // height: 60,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromRGBO(
                244,
                244,
                244,
                1,
              ),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        //
                        custom_dict[i]['date'].toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (var i = 0; i < arr_demo.length; i++) ...[
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromRGBO(
                  255,
                  255,
                  255,
                  1,
                ),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          //
                          arr_demo[i],
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
          ],
          const SizedBox(
            height: 20,
          ),
          // arr_demo
        ],
      ),
    );
  }

  Container check_list_header_UI(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(
          250,
          187,
          9,
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
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          Text(
            'Check List'.toUpperCase(),
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              // add button click
              // RewardsScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RewardsScreen(),
                ),
              );
            },
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(
                  32,
                  52,
                  160,
                  1,
                ),
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              child: Center(
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
