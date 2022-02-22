import 'package:flutter/material.dart';
import 'package:overcome_breakup/constants/colors.dart';
// import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'english_practice_screen.dart';
import 'home_screens.dart';

class AllEnglishWordList extends StatefulWidget {
  AllEnglishWordList({Key? key}) : super(key: key);
  static const routeName = '/AllEnglishWordList ';

  @override
  State<AllEnglishWordList> createState() => _HindiPracticeState();
}

class _HindiPracticeState extends State<AllEnglishWordList> {
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text('English  '),
      ),
      body: GridView.builder(
          itemCount: english.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (ctx, index) => Card(
                elevation: 10,
                child: ListTile(
                  title: Stack(children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.brush_outlined,
                              color: colors[index % colors.length],
                              size: 40,
                            ))),
                    Center(
                      child: Text(
                        english[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: mediaquery.height * 0.16,
                            color: colors[index % colors.length]),
                      ),
                    )
                  ]),
                  // subtitle: Text(hindi[index]),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(EnglishPractice.routeName, arguments: index);
                  },
                ),
              )),
              // bottomNavigationBar: UnityBannerAd(placementId: AdManager.bannerAdPlacementId,),
    );
  }
}
