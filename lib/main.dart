import 'dart:io';

// import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overcome_breakup/constants/colors.dart';
// import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import './screens/home_screens.dart';
import 'screens/all_english_words.dart';
import 'screens/all_hindi_words.dart';
import 'screens/all_maths_letters.dart';
import 'screens/english_practice_screen.dart';
import 'screens/hindi_practice_screen.dart';
import 'screens/maths_practice_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  HttpOverrides.global = MyHttpOverrides();
  // Admob.initialize();
//   UnityAds.init(
//     gameId: '4608643',
// onComplete: () => print('Initialization Complete'),
  // );
  // Admob.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Writing Practice Kids',
      theme: ThemeData(primaryColor: MyColors.primaryColor,buttonColor: MyColors.primaryColor),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        AllHindiWordList.routeName: (ctx) => AllHindiWordList(),
        AllEnglishWordList.routeName: (ctx) => AllEnglishWordList(),
        AllMathsWordList.routeName: (ctx) => AllMathsWordList(),
        EnglishPractice.routeName: (ctx) => EnglishPractice(),
        HindiPractice.routeName: (ctx) => HindiPractice(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        MathsPractice.routeName: (ctx) => MathsPractice(),
      },
    );
  }
}