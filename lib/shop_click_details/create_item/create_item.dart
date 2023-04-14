import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class CreateItemScreen extends StatefulWidget {
  const CreateItemScreen({super.key});

  @override
  State<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Item',
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
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item name',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Assets, Liabilities, Other',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Purchase Date',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Value at purchase:',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Purchased Price',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '1st Payment',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Monthly Payments',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'How Many Monthly Payments',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Improvement Expenses',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Purchase Add. Or Property Add.',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                  labelText: 'Description',
                ),
                maxLines: 3,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Upload Picture',
                  labelText: 'Upload Picture',
                ),
                maxLines: 3,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                10.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
                color: const Color.fromRGBO(
                  250,
                  42,
                  18,
                  1,
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
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Save and Continue',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
