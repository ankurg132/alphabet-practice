import 'package:flutter/material.dart';
import 'package:overcome_breakup/screens/painter.dart';
// import 'package:unity_ads_plugin/unity_ads_plugin.dart';

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
        // UnityAds.showVideoAd(placementId: AdManager.interstitialVideoAdPlacementId);
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
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
