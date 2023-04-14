// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/all_quotes_list/all_notes_in_quotes.dart';
import 'package:journey_recorded/all_quotes_list/all_quotes_in_quotes.dart';

class AllQuotesListScreen extends StatefulWidget {
  const AllQuotesListScreen(
      {super.key,
      required this.str_cateogry_name,
      required this.str_cateogry_id});

  final String str_cateogry_id;
  final String str_cateogry_name;

  @override
  State<AllQuotesListScreen> createState() => _AllQuotesListScreenState();
}

class _AllQuotesListScreenState extends State<AllQuotesListScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              //
              widget.str_cateogry_name,
              //
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
            backgroundColor: navigation_color,
            bottom: TabBar(
              indicatorColor: Colors.lime,
              isScrollable: true,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Skills'.toUpperCase(),
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
                    'Stats'.toUpperCase(),
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
                    'Quotes'.toUpperCase(),
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
                    'Notes'.toUpperCase(),
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
                    'Info'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 20.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                color: Colors.amber,
              ),
              Container(
                height: 40,
                width: 40,
                color: Colors.pink,
              ),

              // quotes list
              AllQuotesInQuotesScreen(
                str_category_id: widget.str_cateogry_id,
              ),

              // notes list
              AllNotesInQuotesScreen(
                str_category_id: widget.str_cateogry_id,
              ),
              Container(
                height: 40,
                width: 40,
                color: Colors.amber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
