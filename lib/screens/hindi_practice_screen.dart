// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:overcome_breakup/screens/painter.dart';

class HindiPractice extends StatefulWidget {
  HindiPractice({Key? key}) : super(key: key);
  static const routeName = '/hindipractice';

  @override
  State<HindiPractice> createState() => _HindiPracticeState();
}

class _HindiPracticeState extends State<HindiPractice> {
  List data = [];
  bool isLoading = true;

  Future<String> loadJsonData() async {
    var jsonText = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/ankurg132/ankurg132.github.io/master/alphabet_practice.json"));

    // print(jsonText);
    setState(() => data = json.decode(jsonText.body));
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
      body: SingleChildScrollView(
        // key: ,
        child: Column(
          children: [
            Row(
              children: [
                Spacer(
                    //flex: 2,
                    ),
                SizedBox(
                  height: mediaquery.height * 0.35,
                  child: Image.network(
                    'https://th.bing.com/th/id/R.d9572d4313850780faa70613e8a71e28?rik=vsqRty%2f%2bjmerWA&riu=http%3a%2f%2fwww.indif.com%2fkids%2fcoloring_sheets%2fimages%2fhindialphabetcoloring_1.jpg&ehk=KV3odF91XbiIE4Idnud4QhWzw30CQk7yssY7lAoemSw%3d&risl=&pid=ImgRaw&r=0',
                    // width: mediaquery.width * 0.6,
                    fit: BoxFit.contain,
                  ),
                ),
                Spacer(
                    //flex: 2,
                    ),
              ],
            ),
            Card(
                elevation: 10,
                child: SizedBox(
                    height: mediaquery.height * 0.7, child: DrawingSheet())),
          ],
        ),
      ),
    );
  }
}
