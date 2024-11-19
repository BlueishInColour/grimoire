import 'dart:io';

import 'package:flutter/foundation.dart';

enum Ads {
  addUnitId1,
  addUnitId2,
  addUnitId3,
  addUnitId4,
  addUnitId5,
  addUnitId6,
  addUnitId7,

  //If Only single ids in app
  bannerAdUnitId,
  interstitialAdUnitId,
  rewardedAdUnitId,

  //If more than one ids in app
  bannerAdHomeScreenId,
  bannerAdSettingScreenId,
  interstitialHomeAdUnitId,
  interstitialSettingAdUnitId,
}

class AdHelper {
  static String getAdmobAdId({required Ads adsName}) {
    // check platform
    final isPlatformAndroid = !kIsWeb;

    // Testing IDs added from admob websites platform-wise.

    final testAppUnitId =
    isPlatformAndroid ? 'ca-app-pub-5507566531768621/9969527150' : "ca-app-pub-3940256099942544~1458002511";
    final testBannerAdId =
    isPlatformAndroid ? 'ca-app-pub-5507566531768621/9969527150' : "ca-app-pub-3940256099942544/2934735716";
    final testInterstitialAdId =
    isPlatformAndroid ? "ca-app-pub-3940256099942544/1033173712" : "ca-app-pub-3940256099942544/4411468910";
    final testRewardAdId =
    isPlatformAndroid ? "ca-app-pub-3940256099942544/5224354917" : "ca-app-pub-3940256099942544/1712485313";

    if (kDebugMode) {
      // If in debug mode
      switch (adsName) {
        case Ads.addUnitId1:
        case Ads.addUnitId2:
        case Ads.addUnitId3:
        case Ads.addUnitId4:
        case Ads.addUnitId5:
        case Ads.addUnitId6:
        case Ads.addUnitId7:
          return testAppUnitId;

      // for all banner ads in app in Debug mode
        case Ads.bannerAdUnitId:
        case Ads.bannerAdHomeScreenId:
        case Ads.bannerAdSettingScreenId:
          return testBannerAdId;

      // for all interstitial ads in app in Debug mode
        case Ads.interstitialAdUnitId:
        case Ads.interstitialHomeAdUnitId:
        case Ads.interstitialSettingAdUnitId:
          return testInterstitialAdId;

      // for all reward ads in app in Debug mode
        case Ads.rewardedAdUnitId:
          return testRewardAdId;

        default:
          return "null";
      }
    } else {
      switch (adsName) {
      // Release mode real Ads id declare here based on enum Ads
        case Ads.addUnitId1:
          return isPlatformAndroid ? "ca-app-pub-5507566531768621/2890374605" : "iOS_unit_id";

        case Ads.addUnitId2:
          return isPlatformAndroid ? "ca-app-pub-5507566531768621/1412010436" : "iOS_unit_id";

        case Ads.addUnitId3:
          return isPlatformAndroid ? "ca-app-pub-5507566531768621/1626928580" : "iOS_unit_id";

        case Ads.addUnitId4:
          return isPlatformAndroid ? "ca-app-pub-5507566531768621/4820068137" : "iOS_unit_id";

        case Ads.addUnitId5:
          return isPlatformAndroid ? "ca-app-pub-5507566531768621/6472765423" : "iOS_unit_id";

        case Ads.addUnitId6:
          return isPlatformAndroid ? "ca-app-pub-5507566531768621/5159683752" : "iOS_unit_id";

        case Ads.addUnitId7:
          return isPlatformAndroid ? "ca-app-pub-5507566531768621/3846602083" : "iOS_unit_id";

        case Ads.bannerAdUnitId:
          return isPlatformAndroid ? "ca-app-pub-5507566531768621/2890374605" : "iOS_banner_id";

        case Ads.interstitialAdUnitId:
          return isPlatformAndroid ? "android_interstitial_id" : "iOS_interstitial_id";

        case Ads.rewardedAdUnitId:
          return isPlatformAndroid ? "android_reward_id" : "iOS_reward_id";

      //IF Multiple Banner/Reward Just add one by based on Enum
        case Ads.bannerAdHomeScreenId:
          return isPlatformAndroid ? "android_banner_home_id" : "iOS_banner_home_id";

        case Ads.interstitialSettingAdUnitId:
          return isPlatformAndroid ? "android_interstitial_setting_id" : "iOS_interstitial_setting_id";

        default:
          return "null";
      }
    }
  }
}