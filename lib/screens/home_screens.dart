import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:overcome_breakup/constants/colors.dart';
import 'package:overcome_breakup/screens/all_english_words.dart';
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
                          style: const TextStyle(fontSize: 20),
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
                          'assets/eng.png',
                          // width: mediaquery.width * 0.7,
                          height: mediaquery.height * 0.3,
                          // fit: BoxFit.fitWidth,
                        ),
                        Text(
                          'English Alphabet',
                          style: const TextStyle(fontSize: 20),
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
                        style: const TextStyle(fontSize: 20),
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
                  content: Text('Developed by Someone'),
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
      bottomNavigationBar: UnityBannerAd(placementId: AdManager.bannerAdPlacementId,),
      // bottomNavigationBar: admob.AdmobBanner(
      //   adUnitId: getBannerAdUnitId()!,
      //   adSize: admob.AdmobBannerSize.ADAPTIVE_BANNER(width: 320, ),
      //   listener: (admob.AdmobAdEvent event, Map<String, dynamic>? args) {},
      //   onBannerCreated: (admob.AdmobBannerController controller) {
      //   },
      // ),
    );
  }
}

class AdManager {
  static String get gameId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return '4608643';
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
