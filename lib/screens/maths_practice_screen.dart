// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:overcome_breakup/screens/painter.dart';

import '../constants/colors.dart';

import 'home_screens.dart';

class MathsPractice extends StatefulWidget {
  const MathsPractice({Key? key}) : super(key: key);
  static const routeName = '/MathsPractice';

  @override
  State<MathsPractice> createState() => _HindiPracticeState();
}

class _HindiPracticeState extends State<MathsPractice> {
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return WillPopScope(
      onWillPop: () {
        interstitialAd.show();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Maths $index'),
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
                      '$index',
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
