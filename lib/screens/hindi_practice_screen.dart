// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;
import 'package:overcome_breakup/screens/painter.dart';

class HindiPractice extends StatefulWidget {
  HindiPractice({Key? key}) : super(key: key);
  static const routeName = '/hindipractice';

  @override
  State<HindiPractice> createState() => _HindiPracticeState();
}

class _HindiPracticeState extends State<HindiPractice> {
  late var data;
  List images = [];
  bool isLoading = true;

  Future<String> loadJsonData() async {
    var jsonText = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/ankurg132/ankurg132.github.io/master/alphabet_practice.json"));
    // print(jsonText);
    setState(() => data = json.decode(jsonText.body));
    print(data[0]['images']);
    setState(() {
      images = data[0]['images'];
    });
    setState(() {
      isLoading = false;
    });
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('हिंदी प्रैक्टिक'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context,index)=>
                            Container(
                              width: mediaquery.width * 0.5,
                              height: mediaquery.height * 0.5,
                              child: Image.network(
                                images[index],
                                fit: BoxFit.cover,
                              ),
                            )
                          )
                  ),
                  Card(
                      elevation: 10,
                      child: SizedBox(
                          height: mediaquery.height * 0.7,
                          child: DrawingSheet())),
                ],
              ),
            
    );
  }
}
