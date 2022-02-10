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
    // var jsonText = await rootBundle.loadString('assets/data.json');
    var jsonText = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/ankurg132/ankurg132.github.io/master/alphabet_practice.json"));
    if (jsonText.statusCode != 200) {
      AwesomeDialog(
        context: context, showCloseIcon: true,
        dialogType: DialogType.INFO_REVERSED,
        animType: AnimType.BOTTOMSLIDE, //awesome_dialog: ^2.1.1
        title: 'Not Login?',

        btnOkText: 'Login',
        btnOkColor: Theme.of(context).primaryColor,
        btnOkOnPress: () {},
      ).show();
      return "";
    }
    print(jsonText);
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
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: mediaquery.height * 0.25,
                  child: Image.network(
                    'https://th.bing.com/th/id/R.d9572d4313850780faa70613e8a71e28?rik=vsqRty%2f%2bjmerWA&riu=http%3a%2f%2fwww.indif.com%2fkids%2fcoloring_sheets%2fimages%2fhindialphabetcoloring_1.jpg&ehk=KV3odF91XbiIE4Idnud4QhWzw30CQk7yssY7lAoemSw%3d&risl=&pid=ImgRaw&r=0',
                    width: mediaquery.width * 0.6,
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Save',
                        style: const TextStyle(),
                      ),
                    ),
                    SizedBox(height: mediaquery.height * 0.05),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Share',
                        style: const TextStyle(),
                      ),
                    ),
                  ],
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
