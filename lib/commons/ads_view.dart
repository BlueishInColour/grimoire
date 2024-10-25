// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// import 'ads_helper.dart';
// Widget adaptiveAdsView(){
//   if(kIsWeb){
//     return SizedBox.shrink();
//   }
//   else{
//     return AdsView();
//   }
// }
//
// class AdsView extends StatefulWidget {
//   /// The requested size of the banner. Defaults to [AdSize.banner].
//   final AdSize adSize;
//
//   /// The AdMob ad unit to show.
//   ///
//   /// TODO: replace this test ad unit with your own ad unit
//   final adUnitId = AdHelper.getAdmobAdId(adsName:Ads.addUnitId);
//
//   AdsView({
//     super.key,
//     this.adSize = AdSize.banner,
//   });
//
//   @override
//   State<AdsView> createState() => _AdsViewState();
// }
//
// class _AdsViewState extends State<AdsView> {
//   /// The banner ad to show. This is `null` until the ad is actually loaded.
//   BannerAd? _bannerAd;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SizedBox(
//         width: widget.adSize.width.toDouble(),
//         height: widget.adSize.height.toDouble(),
//         child: _bannerAd == null
//         // Nothing to render yet.
//             ? SizedBox.shrink()
//         // The actual ad.
//             : AdWidget(ad: _bannerAd!),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _loadAd();
//   }
//
//   @override
//   void dispose() {
//     _bannerAd?.dispose();
//     super.dispose();
//   }
//
//   /// Loads a banner ad.
//   void _loadAd() {
//     final bannerAd = BannerAd(
//       size: widget.adSize,
//       adUnitId: widget.adUnitId,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: (ad) {
//           if (!mounted) {
//             ad.dispose();
//             return;
//           }
//           setState(() {
//             _bannerAd = ad as BannerAd;
//           });
//         },
//         // Called when an ad request failed.
//         onAdFailedToLoad: (ad, error) {
//           debugPrint('BannerAd failed to load: $error');
//           ad.dispose();
//         },
//       ),
//     );
//
//     // Start loading.
//     bannerAd.load();
//   }
// }