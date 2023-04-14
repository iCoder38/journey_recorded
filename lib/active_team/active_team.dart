import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/check_request/check_request.dart';

class ActiveTeamScreen extends StatefulWidget {
  const ActiveTeamScreen({super.key});

  @override
  State<ActiveTeamScreen> createState() => _ActiveTeamScreenState();
}

class _ActiveTeamScreenState extends State<ActiveTeamScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: navigation_color,
            title: Text(
              //
              navigation_title_active_team,
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.lime,
              isScrollable: true,
              // labelColor: Colors.amber,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Actions',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ),
                  child: Text(
                    'Completed Actions',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                children: [
                  for (var i = 0; i < 2; i++) ...[
                    InkWell(
                      onTap: () {
                        if (kDebugMode) {
                          print('object');
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckRequestScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 20.0,
                        ),
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Create an Insurance Company Create an Insurance Company',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                right: 20.0,
                              ),
                              height: 40,
                              width: 40,
                              color: Colors.transparent,
                              child: const Icon(
                                Icons.expand_more,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                    ),
                  ],

                  /*for (var i = 0; i < 2; i++) ...[
                    ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      //scrollDirection: Axis.vertical,
                      //shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.pink,
                        );
                      },
                    ),
                  ]*/
                ],
              ),
              const Text(
                '2',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
