import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

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
          navigation_title_finance,

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
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    ' LIABILITIES',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    ' MONTHLY ',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    ' TOTAL EXPENSES',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' \$6.000 ',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              // scrollDirection: Axis.vertical,
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
                        title: Text(
                          'Three-line ListTile',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: const Text(
                            'A sufficiently long subtitle warrants three lines.'),
                        trailing: Container(
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
