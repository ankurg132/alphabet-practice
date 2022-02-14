// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:overcome_breakup/constants/unityads.dart';
import 'package:overcome_breakup/screens/home_screens.dart';
import 'package:overcome_breakup/screens/painter.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../constants/colors.dart';

class EnglishPractice extends StatefulWidget {
  const EnglishPractice({Key? key}) : super(key: key);
  static const routeName = '/hindipfsddfractice';

  @override
  State<EnglishPractice> createState() => _HindiPracticeState();
}

class _HindiPracticeState extends State<EnglishPractice> {
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return WillPopScope(
      onWillPop: () {
        UnityAds.showVideoAd(placementId: AdManager.interstitialVideoAdPlacementId);
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('English ${english[index]}'),
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
                      '${english[index]}',
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
