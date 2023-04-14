import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rewards',
          style: TextStyle(
            fontFamily: font_style_name,
          ),
        ),
        backgroundColor: navigation_color,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 80,
                    // width: 40,
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
                                'Experience',
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
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      20.0,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '50',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
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
                    height: 80,
                    // width: 40,
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
                                  0.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Currency',
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
                                  0.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      20.0,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '50',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
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
                    height: 80,
                    // width: 40,
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
                                bottomLeft: Radius.circular(
                                  18.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Monthly',
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
                                bottomRight: Radius.circular(
                                  18.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      20.0,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '50',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
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
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: Center(
                child: Text(
                  'Items :',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[100],
                  child: const Text("He'd have you all unravel at the"),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[200],
                  child: const Text('Heed not the rabble'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[300],
                  child: const Text('Sound of screams but the'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[400],
                  child: const Text('Who scream'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[500],
                  child: const Text('Revolution is coming...'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[600],
                  child: const Text('Revolution, they...'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
