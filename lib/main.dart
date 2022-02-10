//https://picsum.photos/200/300   //  ⌘ ñ
//use lint
//import '../widget/detailscreen.dart';
// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overcome_breakup/constants/unityads.dart';
import 'package:overcome_breakup/screens/painter.dart';
import './screens/home_screens.dart';
import 'constants/googlead.dart';
import 'screens/all_english_words.dart';
import 'screens/all_hindi_words.dart';
import 'screens/all_maths_letters.dart';
import 'screens/english_practice_screen.dart';
import 'screens/hindi_practice_screen.dart';
import 'screens/maths_practice_screen.dart';
import 'widgets/home_page_widget.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  HttpOverrides.global = MyHttpOverrides();
  Admob.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'homepage',
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
        UnityAdsPage.routeName: (ctx) => UnityAdsPage(),
      },
    );
  }
}
