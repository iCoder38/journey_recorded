import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class AllTaskUI extends StatelessWidget {
  const AllTaskUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.deepPurple,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 20.0,
              ),
              // height: 20,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: " ",
                      ),
                      TextSpan(
                        text: '''       Research all the licenses require for
                              this business.''',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 20.0,
                          color: app_yellow_color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 20.0,
              ),
              // height: 20,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.amber,
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
                      'Due 10 DAYS',
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
          ),
        ],
      ),
    );
  }
}
