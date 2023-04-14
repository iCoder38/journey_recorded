import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class PhysicalScreen extends StatefulWidget {
  const PhysicalScreen({super.key});

  @override
  State<PhysicalScreen> createState() => _PhysicalScreenState();
}

class _PhysicalScreenState extends State<PhysicalScreen> {
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
          navigation_title_physical,

          ///
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),
      body: ListView.builder(
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
                  title: Text(
                    'Three-line ListTile',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    'A sufficiently long subtitle warrants three lines.',
                  ),
                  trailing: const Icon(
                    Icons.download,
                  ),
                  isThreeLine: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
