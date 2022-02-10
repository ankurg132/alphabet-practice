import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:overcome_breakup/constants/colors.dart';
import 'package:overcome_breakup/screens/hindi_practice_screen.dart';

import '../constants/googlead.dart';
import 'home_screens.dart';

class AllHindiWordList extends StatefulWidget {
  const AllHindiWordList({Key? key}) : super(key: key);
  static const routeName = '/AllHindiWordList ';

  @override
  State<AllHindiWordList> createState() => _HindiPracticeState();
}

class _HindiPracticeState extends State<AllHindiWordList> {
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text('हिंदी प्रैक्टिक'),
      ),
      body: GridView.builder(
          itemCount: hindi.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (ctx, index) => Card(
            elevation: 10,
                child: ListTile(
                  title: Center(
                    child: Text(
                      hindi[index],
                      style: TextStyle(
                          fontSize: mediaquery.height*0.15, color: colors[index % colors.length]),
                    ),
                  ),
                  // subtitle: Text(hindi[index]),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(HindiPractice.routeName, arguments: index);
                  },
                ),
              )),
      bottomNavigationBar: AdmobBanner(
        adUnitId: getBannerAdUnitId()!,
        adSize: bannerSize!,
      ),
    );
  }
}
