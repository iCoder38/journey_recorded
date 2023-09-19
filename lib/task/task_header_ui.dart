import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/task/all_task/all_task.dart';

class TaskHeaderUI extends StatelessWidget {
  const TaskHeaderUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: Colors.pink,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllTaskScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      top: 10.0,
                    ),
                    height: 60,
                    width: 100,
                    decoration: const BoxDecoration(
                      // color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          60.0,
                        ),
                        bottomLeft: Radius.circular(
                          10.0,
                        ),
                        bottomRight: Radius.circular(
                          60.0,
                        ),
                        topRight: Radius.circular(
                          10.0,
                        ),
                      ),
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Color.fromRGBO(250, 220, 10, 1),
                      //     Color.fromRGBO(252, 215, 10, 1),
                      //     Color.fromRGBO(251, 195, 11, 1),
                      //     Color.fromRGBO(250, 180, 10, 1),
                      //   ],
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      // ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/btn_round.png]'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'Alls'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  height: 60,
                  width: 180,
                  decoration: const BoxDecoration(
                    // color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        60.0,
                      ),
                      bottomLeft: Radius.circular(
                        10.0,
                      ),
                      bottomRight: Radius.circular(
                        60.0,
                      ),
                      topRight: Radius.circular(
                        10.0,
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(250, 220, 10, 1),
                        Color.fromRGBO(252, 215, 10, 1),
                        Color.fromRGBO(251, 195, 11, 1),
                        Color.fromRGBO(250, 180, 10, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'CATEGORIES'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  height: 60,
                  width: 160,
                  decoration: const BoxDecoration(
                    // color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        60.0,
                      ),
                      bottomLeft: Radius.circular(
                        10.0,
                      ),
                      bottomRight: Radius.circular(
                        60.0,
                      ),
                      topRight: Radius.circular(
                        10.0,
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(250, 220, 10, 1),
                        Color.fromRGBO(252, 215, 10, 1),
                        Color.fromRGBO(251, 195, 11, 1),
                        Color.fromRGBO(250, 180, 10, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Actions'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    right: 10.0,
                  ),
                  height: 60,
                  width: 120,
                  decoration: const BoxDecoration(
                    // color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        60.0,
                      ),
                      bottomLeft: Radius.circular(
                        10.0,
                      ),
                      bottomRight: Radius.circular(
                        60.0,
                      ),
                      topRight: Radius.circular(
                        10.0,
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(250, 220, 10, 1),
                        Color.fromRGBO(252, 215, 10, 1),
                        Color.fromRGBO(251, 195, 11, 1),
                        Color.fromRGBO(250, 180, 10, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Filter'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
