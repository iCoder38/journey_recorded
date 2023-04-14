import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class CheckRequestScreen extends StatelessWidget {
  const CheckRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          //
          navigation_title_request,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: Center(
                child: Text(
                  'DUE DATE : 45 DAYS',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Container(
                // height: 60,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    '''Hello Allen Chandler, you have been invited by Juan Rojas to join him in his

goalto Start an insurance business. He believes you would be an important

addition to his plan. Will you agree to have a meeting with

him and discuss the details of the

request and compensation. Can you please respond within 5 business days, because this invitation
has gone to a few qualified people.

Thanks.''',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      height: 60,
                      // width: 120,

                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                          32,
                          232,
                          106,
                          1,
                        ),
                        borderRadius: BorderRadius.circular(
                          12.0,
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
                      child: Center(
                        child: Text(
                          'Accept'.toUpperCase(),
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
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      height: 60,
                      // width: 120,

                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                          250,
                          0,
                          30,
                          1,
                        ),
                        borderRadius: BorderRadius.circular(
                          12.0,
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
                      child: Center(
                        child: Text(
                          'Decline'.toUpperCase(),
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
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
