import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class EditGoalTaskScreen extends StatefulWidget {
  const EditGoalTaskScreen({super.key});

  @override
  State<EditGoalTaskScreen> createState() => _EditGoalTaskScreenState();
}

class _EditGoalTaskScreenState extends State<EditGoalTaskScreen> {
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
          navigation_title_edit_goals_task,

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
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Business Plan',
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 18.0,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(
                            235,
                            0,
                            65,
                            1,
                          ),
                          borderRadius: BorderRadius.circular(
                            20.0,
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
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(
                            40,
                            210,
                            222,
                            1,
                          ),
                          borderRadius: BorderRadius.circular(
                            20.0,
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
                        child: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
