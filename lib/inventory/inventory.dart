// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/inventory/edit_inventory/edit_inventory.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  //
  var arr_inventory_header = [
    {'name': 'ASSETS'},
    {'name': 'LIABILITIES'},
    {'name': 'OTHER'},
  ];
  var arr_inventory_sub_tiles = [
    {'name': '2014 dodge ram'},
    {'name': 'Rent house 1'},
    {'name': 'Job'},
  ];
  //
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
          navigation_title_inventory,

          ///
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            //
            category_finance_UI(context),
            //
            const SizedBox(
              height: 40.0,
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            for (var i = 0; i < arr_inventory_header.length; i++) ...[
              ExpansionTile(
                title: Text(
                  //
                  arr_inventory_header[i]['name'].toString(),
                  //
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18.0,
                  ),
                ),
                // subtitle: Text('Trailing expansion arrow icon'),

                children: <Widget>[
                  for (var j = 0; j < arr_inventory_sub_tiles.length; j++) ...[
                    ListTile(
                      leading: const FlutterLogo(size: 72.0),
                      title: Text(
                        arr_inventory_sub_tiles[j]['name'].toString(),
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Text(
                          'A sufficiently long subtitle warrants three lines.'),
                      trailing: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditInventoryScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 80,
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
                              '\$500',
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      isThreeLine: true,
                    ),
                  ]
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Column category_finance_UI(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 10.0,
          ),
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Container(
            height: 40,
            width: 40,
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      color: const Color.fromRGBO(
                        235,
                        235,
                        235,
                        1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          18.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Category',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      color: const Color.fromRGBO(
                        235,
                        235,
                        235,
                        1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(
                          18.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Finance',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 0.0,
          ),
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Container(
            height: 40,
            width: 40,
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      color: const Color.fromRGBO(
                        255,
                        255,
                        255,
                        1,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(
                          0.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Lost or Gain',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      color: const Color.fromRGBO(
                        255,
                        255,
                        255,
                        1,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(
                          0.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '\$1.000',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 0.0,
          ),
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Container(
            height: 40,
            width: 40,
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      color: const Color.fromRGBO(
                        255,
                        255,
                        255,
                        1,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(
                          18.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Finance',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      color: const Color.fromRGBO(
                        255,
                        255,
                        255,
                        1,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(
                          18.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Monthly',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
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
