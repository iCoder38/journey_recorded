// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen(
      {super.key,
      required this.str_category_id,
      required this.str_category_name});

  final String str_category_id;
  final String str_category_name;

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  //
  var str_select_status = '1';
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          //
          widget.str_category_name,
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
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(
              4.0,
            ),
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: <Widget>[
                if (str_select_status == '1')
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        print('goal click');
                        str_select_status = '1';
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          color: const Color.fromRGBO(9, 44, 132, 1),
                        ),
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Text(
                            'Goal',
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                else if (str_select_status == '2')
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        print('goal click');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          color: Colors.white,
                        ),
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Text(
                            'Goal',
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      print('sub-goal click');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        color: Colors.white,
                      ),
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text(
                          'Sub-Goal',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      print('mission click');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        color: Colors.white,
                      ),
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text(
                          'Mission',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
