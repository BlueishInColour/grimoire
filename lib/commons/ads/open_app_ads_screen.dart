//
//
// import 'package:flutter/cupertino.dart';
//
// import 'app_open_ads_manager.dart';
//
// class OpenAppAdsScreen extends StatefulWidget {
//   OpenAppAdsScreen({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _OpenAppAdsScreenState createState() => _OpenAppAdsScreenState();
// }
//
// /// Example home page for an app open ad.
// class _OpenAppAdsScreenState extends State<OpenAppAdsScreen> {
//   int _counter = 0;
//   late AppLifecycleReactor _appLifecycleReactor;
//
//   @override
//    initState() {
//     super.initState();
//
//     AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
//     _appLifecycleReactor = AppLifecycleReactor(
//         appOpenAdManager: appOpenAdManager);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
