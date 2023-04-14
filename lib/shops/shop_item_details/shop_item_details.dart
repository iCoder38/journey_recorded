import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class ShopitemDetailsScreen extends StatefulWidget {
  const ShopitemDetailsScreen({super.key});

  @override
  State<ShopitemDetailsScreen> createState() => _ShopitemDetailsScreenState();
}

class _ShopitemDetailsScreenState extends State<ShopitemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ///
          navigation_title_shops,

          ///

          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            // margin: const EdgeInsets.all(10.0),
            color: Colors.amber[600],
            width: MediaQuery.of(context).size.width,
            height: 140,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.amber[800],
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  // child: Row(children: []),
                ),
                //
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    // width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.amber[800],
                      borderRadius: BorderRadius.circular(
                        14,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Text(
                              'data',
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'data',
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 18,
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
          //
          Container(
            margin: const EdgeInsets.all(10.0),
            color: Colors.amber[600],
            width: MediaQuery.of(context).size.width,
            // height: 48.0,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'data',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 18,
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
