import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:journey_recorded/create_a_user/create_user.dart';

class InviteFriendScreen extends StatefulWidget {
  const InviteFriendScreen({super.key});

  @override
  State<InviteFriendScreen> createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigation_color,
        title: Text(
          ///
          navigation_title_invite_friends,

          ///
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              print('create a user');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateUserScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              //scrollDirection: Axis.vertical,
              //shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 0.0,
                    ),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Card(
                      child: ListTile(
                        leading: const FlutterLogo(size: 72.0),
                        trailing: IconButton(
                          onPressed: () {
                            showAdaptiveActionSheet(
                              context: context,
                              actions: <BottomSheetAction>[
                                BottomSheetAction(
                                  title: Text(
                                    'Dismiss from team',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      color: const Color.fromRGBO(
                                        33,
                                        164,
                                        230,
                                        1,
                                      ),
                                    ),
                                  ),
                                  onPressed: (_) {},
                                ),
                                BottomSheetAction(
                                  title: Text(
                                    'Accept invitation',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      color: navigation_color,
                                    ),
                                  ),
                                  onPressed: (_) {},
                                ),
                                BottomSheetAction(
                                  title: Text(
                                    'Add to team',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      color: Colors.red,
                                    ),
                                  ),
                                  onPressed: (_) {},
                                ),
                              ],
                              cancelAction:
                                  CancelAction(title: const Text('Cancel')),
                            );
                          },
                          icon: const Icon(
                            Icons.settings,
                          ),
                        ),
                        title: Text(
                          'Three-line ListTile',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: const Text(
                            'A sufficiently long subtitle warrants three lines.'),
                        /*trailing: Icon(
                              Icons.more_vert,
                            ),*/
                        isThreeLine: true,
                      ),
                    ),
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
