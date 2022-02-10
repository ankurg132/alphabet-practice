// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:overcome_breakup/constants/colors.dart';
import 'package:overcome_breakup/screens/hindi_practice_screen.dart';
import 'package:overcome_breakup/screens/maths_practice_screen.dart';
import 'package:overcome_breakup/screens/painter.dart';

import 'english_practice_screen.dart';

class AllMathsWordList extends StatefulWidget {
  const AllMathsWordList({Key? key}) : super(key: key);
  static const routeName = '/AllMathsWordList ';

  @override
  State<AllMathsWordList> createState() => _HindiPracticeState();
}

class _HindiPracticeState extends State<AllMathsWordList> {
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text('Math  '),
      ),
      body: GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (ctx, index) => Card(
            elevation: 10,
                child: ListTile(
                  title: Center(
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: mediaquery.height * 0.16,
                          color: colors[index % colors.length]),
                    ),
                  ),
                  // subtitle: Text(hindi[index]),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(MathsPractice.routeName, arguments: index);
                  },
                ),
              )),
    );
  }
}
