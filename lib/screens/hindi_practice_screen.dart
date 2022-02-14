// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;
import 'package:overcome_breakup/screens/painter.dart';

import '../constants/colors.dart';
import 'home_screens.dart';

class HindiPractice extends StatefulWidget {
  HindiPractice({Key? key}) : super(key: key);
  static const routeName = '/hindipractice';

  @override
  State<HindiPractice> createState() => _HindiPracticeState();
}

class _HindiPracticeState extends State<HindiPractice> {
  // List data = [];
  // bool isLoading = true;

  // Future<String> loadJsonData() async {
  //   var jsonText = await http.get(Uri.parse(
  //       "https://raw.githubusercontent.com/ankurg132/ankurg132.github.io/master/alphabet_practice.json"));

  //   // print(jsonText);
  //   setState(() => data = json.decode(jsonText.body));
  //   setState(() {
  //     isLoading = false;
  //   });
  //   return 'success';
  // }

  @override
  void initState() {
    super.initState();
    // loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return WillPopScope(
      onWillPop: () {
        // interstitialAd.show();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('हिंदी ${hindi[index]}'),
        ),
        body: SingleChildScrollView(
          // key: ,
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  SizedBox(
                    height: mediaquery.height * 0.25,
                    child: Text(
                      '${hindi[index]}',
                      style: TextStyle(
                          fontSize: mediaquery.height * 0.2,
                          color: colors[index % colors.length]),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Card(
                  elevation: 10,
                  child: SizedBox(
                      height: mediaquery.height * 0.7, child: DrawingSheet())),
            ],
          ),
        ),
      ),
    );
  }
}
