// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/custom_files/app_bar/app_bar.dart';
import 'package:journey_recorded/edit_business_profile/add_items/add_items.dart';
import 'package:journey_recorded/edit_business_profile/create_Service/create_service.dart';
import 'package:journey_recorded/edit_business_profile/create_special/create_special.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

class EditBusinessProfileScreen extends StatefulWidget {
  const EditBusinessProfileScreen(
      {super.key,
      required this.str_name,
      required this.str_phone,
      required this.str_email_address,
      required this.str_address,
      required this.str_business_website,
      required this.str_fax});

  final String str_fax;
  final String str_business_website;
  final String str_address;
  final String str_name;
  final String str_phone;
  final String str_email_address;

  @override
  State<EditBusinessProfileScreen> createState() =>
      _EditBusinessProfileScreenState();
}

class _EditBusinessProfileScreenState extends State<EditBusinessProfileScreen> {
  //
  var str_main_loader = '0';
  var str_UI_show = 'n.a.';
  var str_bottom_bar_color = '0';
  //

  //
  var arr_business_profile = [];
  //
  @override
  void initState() {
    super.initState();
    //
    str_UI_show = 'special';
    special_list_WB();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: 'Business',
        str_back_button_status: '1',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          func_push_from_floating_button();
        },
        backgroundColor: navigation_color,
        child: const Icon(Icons.add),
      ),
      body: header_UI(context),
    );
  }

  //
  SingleChildScrollView header_UI(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.amber,
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(
                    54,
                    30,
                    107,
                    1,
                  ),
                  Color.fromRGBO(
                    92,
                    21,
                    93,
                    1,
                  ),
                  Color.fromRGBO(
                    138,
                    0,
                    70,
                    1,
                  ),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    // height: 40,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          //
                          widget.str_name.toString(),
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 22.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          //
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: 40,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          //
                          widget.str_phone.toString(),
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: 40,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          //
                          widget.str_email_address.toString(),
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // height: 40,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(
                              250,
                              0,
                              28,
                              1,
                            ),
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                          ),
                          child: Align(
                            child: Text(
                              'Rate : 0',
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 52,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(
              250,
              0,
              28,
              1,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      //
                      special_list_WB();
                      //
                    },
                    child: Container(
                      height: 80,
                      width: 120,
                      decoration: (str_bottom_bar_color == 'special_click')
                          ? const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  width: 3,
                                ),
                              ),
                            )
                          : const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  width: 0,
                                ),
                              ),
                            ),
                      child: Align(
                        child: Text(
                          'Special',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      //
                      service_list_WB();
                      //
                    },
                    child: Container(
                      height: 80,
                      width: 120,
                      // color: Colors.transparent,
                      decoration: (str_bottom_bar_color == 'service_click')
                          ? const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  width: 3,
                                ),
                              ),
                            )
                          : const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  width: 0,
                                ),
                              ),
                            ),
                      child: Align(
                        child: Text(
                          'Service',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      //
                      product_list_WB();
                      //
                    },
                    child: Container(
                      height: 80,
                      width: 120,
                      decoration: (str_bottom_bar_color == 'items_click')
                          ? const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  width: 3,
                                ),
                              ),
                            )
                          : const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  width: 0,
                                ),
                              ),
                            ),
                      child: Align(
                        child: Text(
                          'Items',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      str_UI_show = 'contact_info';
                      str_bottom_bar_color = 'contact_info_click';
                      setState(() {});
                    },
                    child: Container(
                      height: 80,
                      width: 120,
                      decoration: (str_bottom_bar_color == 'contact_info_click')
                          ? const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  width: 3,
                                ),
                              ),
                            )
                          : const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  width: 0,
                                ),
                              ),
                            ),
                      child: Align(
                        child: Text(
                          'Contact Info',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      str_UI_show = 'employee';
                      str_bottom_bar_color = 'employee_click';
                      setState(() {});
                    },
                    child: Container(
                      height: 80,
                      width: 120,
                      decoration: (str_bottom_bar_color == 'employee_click')
                          ? const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  width: 3,
                                ),
                              ),
                            )
                          : const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  width: 0,
                                ),
                              ),
                            ),
                      child: Align(
                        child: Text(
                          'Employee ',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //
          (str_main_loader == '0')
              ? const CustomeLoaderPopUp(
                  str_custom_loader: 'Please wait...',
                  str_status: '4',
                )
              : business_main_UI(),
          //
        ],
      ),
    );
  }

// contact ui
  Column contact_info_UI(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            // margin: const EdgeInsets.all(
            //   20.0,
            // ),
            // height: 40,
            width: MediaQuery.of(context).size.width,
            // color: Colors.pink,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.pink,
              ),
            ),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Phone'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      //
                      widget.str_phone.toString(),
                      //
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Container(
                  height: .5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Fax'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      //
                      widget.str_fax.toUpperCase(),
                      //
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Container(
                  height: .5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),

                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Email'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      //
                      widget.str_email_address.toString(),
                      //
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Container(
                  height: .5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    _launchURL(widget.str_business_website.toString());
                  },
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Web Address'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 40,
                        // width: 120,
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              Icons.public,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              //
                              widget.str_business_website.toString(),
                              //
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 16.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.w400,
                              ),
                              //
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: .5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Address'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        //
                        widget.str_address.toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 14.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                /*Container(
                  height: .5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Description :'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 18,
                      bottom: 18.0,
                      right: 18.0,
                    ),
                    child: Text(
                      //
                      widget.str_description.toString(),
                      //
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                      ),
                      //
                    ),
                  ),
                ),*/
                Container(
                  height: .5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column business_main_UI() {
    if (str_UI_show == 'special') {
      return special_UI();
    } else if (str_UI_show == 'contact_info') {
      return contact_info_UI(context);
    } else if (str_UI_show == 'service') {
      return service_UI();
    } else {
      return Column(
        children: [
          for (int i = 0; i < arr_business_profile.length; i++) ...[
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                      // width: 60,
                      // height: 30,
                      child: (arr_business_profile[i]['image'].toString() == '')
                          ? Image.asset('assets/images/logo.png')
                          : Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                color: Colors.amber,
                                // shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                arr_business_profile[i]['image'].toString(),
                                fit: BoxFit.fill,
                              ),
                            )
                      // FadeInImage.assetNetwork(
                      //     placeholder: 'assets/images/loader.gif',
                      //     image: arr_business_profile[i]['image'].toString(),
                      //   ),
                      ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    //
                    arr_business_profile[i]['name'].toString(),
                    //
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(
                        250,
                        0,
                        28,
                        1,
                      ),
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                    child: Align(
                      child: Text(
                        //
                        '\$${arr_business_profile[i]['salePrice']}',
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
          ],
          /*GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              mainAxisExtent: 200,
              // childAspectRatio: 500,
            ),
            itemCount: arr_business_profile.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        // height: MediaQuery.of(context).size.height,
                        height: 40,
                        color: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                          child: (arr_business_profile[index]['image']
                                      .toString() ==
                                  '')
                              ? Image.asset('assets/images/logo.png')
                              : FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/loader.gif',
                                  image: arr_business_profile[index]['image']
                                      .toString(),
                                ),
                        ),
                      ),
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.height,
                      height: 40,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          //
                          arr_business_profile[index]['name'].toString(),
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.height,
                      height: 40,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          //
                          '\$${arr_business_profile[index]['salePrice']}',
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )*/
        ],
      );
    }
  }

  Column special_UI() {
    return Column(
      children: [
        for (int i = 0; i < arr_business_profile.length; i++) ...[
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 40,
                  // height: 30,
                  child: (arr_business_profile[i]['image'].toString() == '')
                      ? Image.asset('assets/images/logo.png')
                      : FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loader.gif',
                          image: arr_business_profile[i]['image'].toString(),
                        ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  //
                  arr_business_profile[i]['name'].toString(),
                  //
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(
                      250,
                      0,
                      28,
                      1,
                    ),
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: Align(
                    child: Text(
                      //
                      '\$${arr_business_profile[i]['price']}',
                      //
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
        ],
      ],
    );
  }

  // floating action button
  func_push_from_floating_button() {
    if (str_UI_show == 'special') {
      if (kDebugMode) {
        print('special click');
      }

      push_to_add_sub_goal(context);
    } else if (str_UI_show == 'service') {
      if (kDebugMode) {
        print('service click');
      }

      push_to_add_service_goal(context);
    } else if (str_UI_show == 'items') {
      if (kDebugMode) {
        print('items click');
      }

      push_to_items(context);
    }
    // print(str_UI_show);
  }

  Future<void> push_to_add_sub_goal(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateSpecialScreen(),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

    if (!mounted) return;

    special_list_WB();
  }

  Future<void> push_to_add_service_goal(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateServiceScreen(),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

    if (!mounted) return;

    service_list_WB();
  }

  Future<void> push_to_items(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddItemsScreen(),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

    if (!mounted) return;

    product_list_WB();
  }

  Column service_UI() {
    return Column(
      children: <Widget>[
        //
        for (var i = 0; i < arr_business_profile.length; i++) ...[
          ExpansionTile(
            title: Text(
              //
              arr_business_profile[i]['name'].toString(),
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            // subtitle: Text('Trailing expansion arrow icon'),

            children: <Widget>[
              for (var j = 0;
                  j < arr_business_profile[i]['subServices'].length;
                  j++) ...[
                ListTile(
                  /*leading: Container(
                    width: 80,
                    height: 80,
                    color: Colors.yellow,
                  ),*/
                  title: Text(
                    //
                    arr_business_profile[i]['subServices'][j]['name']
                        .toString(),
                    //
                    style: TextStyle(
                        fontFamily: font_style_name,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  /*subtitle: Text(
                    // 'skills : ${arr_send_teammate_request[j]['skill']}\nTask name : ${arr_send_teammate_request[j]['taskName']}',
                    'sub-title',
                  ),*/
                  trailing: InkWell(
                    onTap: () {
                      print('sub-title click');
                    },
                    child: Container(
                      height: 40,
                      width: 100 - 20,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          height: 40,
                          // width: 140,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(
                              250,
                              0,
                              28,
                              1,
                            ),
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          child: Align(
                            child: Text(
                              //
                              '\$${arr_business_profile[i]['subServices'][j]['price'].toString()}',
                              //
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  isThreeLine: false,
                ),
              ]
            ],
          ),
        ],
        /*for (var i = 0; i < 1; i++) ...[
          ExpansionTile(
            title: Text(
              //

              //'${'approve teammate'.toString().toUpperCase()} ($str_approved_teammate_count)',
              'approved',
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            // subtitle: Text('Trailing expansion arrow icon'),

            children: <Widget>[
              for (var j = 0; j < arr_approve_teammate.length; j++) ...[
                ListTile(
                  leading: Container(
                    width: 80,
                    height: 80,
                    color: Colors.yellow,
                    child: Image.network(
                      arr_approve_teammate[j]['From_profile_picture']
                          .toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    //

                    arr_approve_teammate[j]['To_userName'].toString(),
                    //
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'skills : ${arr_send_teammate_request[j]['skill']}\nTask name : ${arr_send_teammate_request[j]['taskName']}',
                  ),
                  trailing: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                          255,
                          255,
                          255,
                          1,
                        ),
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      /*child: Center(
                                child: Text(
                                  '\$500',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),*/
                    ),
                  ),
                  isThreeLine: true,
                ),
              ]
            ],
          ),
        ]*/
      ],
    );
  }

  // APIs
  Future special_list_WB() async {
    print('=====> POST : SPECIAL LIST');

    setState(() {
      str_main_loader = '0';
      str_UI_show = 'special';
      str_bottom_bar_color = 'special_click';
    });
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'speciallist',
          'userId': prefs.getInt('userId').toString(),
          'serviceType': 'Special',
          'pageNo': '1',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      //
      arr_business_profile.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arr_business_profile.add(i);
          //
        }
        if (arr_business_profile.isEmpty) {
          setState(() {
            str_main_loader = '1';
          });
        } else {
          setState(() {
            str_main_loader = '2';
          });
        }
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  //
  // service list
  Future service_list_WB() async {
    print('=====> POST : SERVICE LIST');

    setState(() {
      str_main_loader = '0';
      str_UI_show = 'service';
      str_bottom_bar_color = 'service_click';
    });
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'speciallist',
          'userId': prefs.getInt('userId').toString(),
          'serviceType': 'Service',
          'pageNo': '1',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      //
      arr_business_profile.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arr_business_profile.add(i);
          //
        }
        if (arr_business_profile.isEmpty) {
          setState(() {
            str_main_loader = '1';
          });
        } else {
          setState(() {
            str_main_loader = '2';
          });
        }
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  // product list
  Future product_list_WB() async {
    print('=====> POST : SERVICE LIST');

    setState(() {
      str_main_loader = '0';
      str_UI_show = 'items';
      str_bottom_bar_color = 'items_click';
    });
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'productlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '1',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      //
      arr_business_profile.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          //
          arr_business_profile.add(i);
          //
        }
        if (arr_business_profile.isEmpty) {
          setState(() {
            str_main_loader = '1';
          });
        } else {
          setState(() {
            str_main_loader = '2';
          });
        }
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  // open browser
  _launchURL(String str_url) async {
    var url = 'https:\\$str_url';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
