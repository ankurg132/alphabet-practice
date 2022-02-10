// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, avoid_print

import 'dart:async' show Future;
import 'package:admob_flutter/admob_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:overcome_breakup/constants/colors.dart';
import 'package:overcome_breakup/constants/unityads.dart';
import 'package:overcome_breakup/screens/all_english_words.dart';
import 'package:overcome_breakup/widgets/home_page_widget.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import 'all_hindi_words.dart';
import 'all_maths_letters.dart';
import 'hindi_practice_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int daysCompleted = 0;

class GoogleAdManager {
  static String get getBannerAdUnitId {
    return 'ca-app-pub-8472786689816889/8416712347';
  }

  static String get getInterstitialAdUnitId {
    return 'ca-app-pub-8472786689816889/4669039027';
  }
}

AdmobBannerSize? bannerSize;
late AdmobInterstitial interstitialAd;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // print("INITHOMEMAIN");
    UnityAds.init(
      gameId: AdManager.gameId,
      // testMode: true,
      onComplete: () => print(
          '-------------------Initialization Complete-------------------'),
      onFailed: (error, message) =>
          print('-------------------Initialization Failed-------------------'),
    );
    bannerSize = AdmobBannerSize.BANNER;

    interstitialAd = AdmobInterstitial(
      adUnitId: GoogleAdManager.getInterstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );
    interstitialAd.load();

    // if (data.isEmpty) {
    //   loadJsonData();
    // }
    // sharedpref();
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text('Alphabet Practice'),
      ),
      backgroundColor: MyColors.backColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: (() {
                Navigator.of(context).pushNamed(
                  AllHindiWordList.routeName,
                );
              }),
              child: SizedBox(
                width: mediaquery.width * 0.7,
                child: Center(
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/hindi.png',
                          width: mediaquery.width * 0.7,
                          height: mediaquery.height * 0.3,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          'Hindi Practice ',
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AllEnglishWordList.routeName,
                );
              },
              child: SizedBox(
                width: mediaquery.width * 0.7,
                child: Center(
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/english.png',
                          // width: mediaquery.width * 0.7,
                          height: mediaquery.height * 0.3,
                          // fit: BoxFit.fitWidth,
                        ),
                        Text(
                          'English Alphabet',
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AllMathsWordList.routeName,
                  // arguments: product.id
                );
              },
              child: Center(
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/math.png',
                        width: mediaquery.width * 0.7,
                        height: mediaquery.height * 0.3,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Math Practice',
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Alphabet Practice',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
              ),
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                const snackBar = SnackBar(
                  content: Text(
                      'Developed by The Breakup Association for the Overcome of Breakup'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            ListTile(
              title: Text('View Ads to Support Us'),
              onTap: () {
                UnityAds.showVideoAd(
                    placementId: AdManager.interstitialVideoAdPlacementId);
              },
            ),
            // ListTile(
            //   title: Text('Open Unity Ads Page'),
            //   onTap: () {
            //     // UnityAds.showVideoAd(placementId: 'Interstitial_Android');
            //     Navigator.of(context).pushNamed(
            //       UnityAdsPage.routeName,
            //     );
            //   },
            // ),
          ],
        ),
      ),
      bottomNavigationBar: AdmobBanner(
          adUnitId: GoogleAdManager.getBannerAdUnitId,
          adSize: AdmobBannerSize.BANNER),
    );
  }
}

class AdManager {
  static String get gameId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '4601948';
    }
    // if (defaultTargetPlatform == TargetPlatform.iOS) {
    //   return 'your_ios_game_id';
    // }
    return '';
  }

  static String get bannerAdPlacementId {
    return 'Banner_Android';
  }

  static String get interstitialVideoAdPlacementId {
    return 'Interstitial_Android';
  }

  static String get rewardedVideoAdPlacementId {
    return 'Rewarded_Android';
  }
}
