import 'package:flutter/material.dart';
// image(image: Svg("assets/image4.svg"), text: "own your own space story-telling medium for free"),

import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
class AdsMineView extends StatefulWidget {
  const AdsMineView({super.key});

  @override
  State<AdsMineView> createState() => _FoolishWithoutStateState();
}

class _FoolishWithoutStateState extends State<AdsMineView> {
 @override
 initState(){
   super.initState();
   // Keep the screen on.
   KeepScreenOn.turnOn();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:ListView(
        children:[

          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId1)

          ),
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId2)

          ),
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId3)

          ),
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId4)

          ),
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId5)

          ),
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId6)

          ),
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId7)

          ),

          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId1)

          ),
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId2)

          ),
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId3)

          ),
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId4)

          ),
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId5)

          ),
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId6)

          ),
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId7)

          ),


        ]
      )
    );
  }

  @override
  dispose(){
   super.dispose();
   KeepScreenOn.turnOff();

  }
}
