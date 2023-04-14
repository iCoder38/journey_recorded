import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class DetailsInfoScreen extends StatefulWidget {
  const DetailsInfoScreen({super.key});

  @override
  State<DetailsInfoScreen> createState() => _DetailsInfoScreenState();
}

class _DetailsInfoScreenState extends State<DetailsInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: TabBar(
              indicatorColor: Colors.lime,
              isScrollable: true,
              // labelColor: Colors.amber,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Info',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
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
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Quotes',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Team',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Reward',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Link',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: navigation_color,
            title: Text(
              ///
              navigation_title_goal_details,

              ///
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: app_yellow_color,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: app_yellow_color,
                  child: const Icon(
                    Icons.question_mark,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: app_yellow_color,
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            color: Colors.amber,
            child: TabBarView(
              children: <Widget>[
                Container(
                  color: Colors.pink,
                ),
                Container(
                  color: Colors.amber,
                ),
                Container(
                  color: Colors.pink,
                ),
                Container(
                  color: Colors.amber,
                ),
                Container(
                  color: Colors.pink,
                ),
                Container(
                  color: Colors.pink,
                ),
                // goals_details_LINK_ui(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
