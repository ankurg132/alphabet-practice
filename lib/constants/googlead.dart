import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  _MyMaterialAppState createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();

    bannerSize = AdmobBannerSize.BANNER;

    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );
    interstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdmobFlutter'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'FullscreenDialog',
              style:  TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ), // .withBottomAdmobBanner(context),
      bottomNavigationBar: Builder(
        builder: (BuildContext context) {
          return Container(
            color: Colors.blueGrey,
            child: SafeArea(
              child: SizedBox(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          final isLoaded = await interstitialAd.isLoaded;
                          if (isLoaded ?? false) {
                            interstitialAd.show();
                          } else {}
                        },
                        child: const Text(
                          'Show Interstitial',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: PopupMenuButton(
                        initialValue: bannerSize,
                        offset: const Offset(0, 20),
                        onSelected: (AdmobBannerSize newSize) {
                          setState(() {
                            bannerSize = newSize;
                          });
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<AdmobBannerSize>>[
                          const PopupMenuItem(
                            value: AdmobBannerSize.BANNER,
                            child: const Text('BANNER'),
                          ),
                          const PopupMenuItem(
                            value: AdmobBannerSize.LARGE_BANNER,
                            child: const Text('LARGE_BANNER'),
                          ),
                          const PopupMenuItem(
                            value: AdmobBannerSize.MEDIUM_RECTANGLE,
                            child: const Text('MEDIUM_RECTANGLE'),
                          ),
                          const PopupMenuItem(
                            value: AdmobBannerSize.FULL_BANNER,
                            child: Text('FULL_BANNER'),
                          ),
                          const PopupMenuItem(
                            value: AdmobBannerSize.LEADERBOARD,
                            child: Text('LEADERBOARD'),
                          ),
                          PopupMenuItem(
                            value: AdmobBannerSize.SMART_BANNER(context),
                            child: const Text('SMART_BANNER'),
                          ),
                          PopupMenuItem(
                            value: AdmobBannerSize.ADAPTIVE_BANNER(
                              width: MediaQuery.of(context).size.width.toInt() -
                                  40, // considering EdgeInsets.all(20.0)
                            ),
                            child: const Text('ADAPTIVE_BANNER'),
                          ),
                        ],
                        child: const Center(
                          child: const Text(
                            'Banner size',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Push Page',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                padding: const EdgeInsets.all(20.0),
                itemCount: 1000,
                itemBuilder: (BuildContext context, int index) {
                  if (index != 0 && index % 6 == 0) {
                    return Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: AdmobBanner(
                            adUnitId: getBannerAdUnitId()!,
                            adSize: bannerSize!,
                            listener: (AdmobAdEvent event,
                                Map<String, dynamic>? args) {},
                            onBannerCreated:
                                (AdmobBannerController controller) {
                              // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                              // Normally you don't need to worry about disposing this yourself, it's handled.
                              // If you need direct access to dispose, this is your guy!
                              // controller.dispose();
                            },
                          ),
                        ),
                        Container(
                          height: 100.0,
                          margin: const EdgeInsets.only(bottom: 20.0),
                          color: Colors.cyan,
                        ),
                      ],
                    );
                  }
                  return Container(
                    height: 100.0,
                    margin: const EdgeInsets.only(bottom: 20.0),
                    color: Colors.cyan,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
    // .withBottomAdmobBanner(context);
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }
}

String? getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-8472786689816889/8416712347';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-8472786689816889/8416712347';
  }
  return null;
}

String? getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-8472786689816889/4669039027';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-8472786689816889/4669039027';
  }
  return null;
}
