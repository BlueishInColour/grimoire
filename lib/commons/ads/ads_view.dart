import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_ad_manager_web/flutter_ad_manager_web.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ads_helper.dart';
Widget adaptiveAdsView(String adUnitId,{
AdSize adSize = AdSize.banner,}){
  if(kIsWeb){
    return
        SizedBox.shrink();
      // SizedBox(
      //   height: 50,
        //
        // child: FlutterAdManagerWeb(
        //   debug: true,
        //   width: 1100,
        //   height: 100, adUnitCode: adUnitCode,
        //
        // ),
      // );
  }
  else{
    return AdsView(adUnitId: adUnitId,adSize: adSize,);
  }
}

class AdsView extends StatefulWidget {
  /// The requested size of the banner. Defaults to [AdSize.banner].
  final AdSize adSize;
final String adUnitId;
  /// The AdMob ad unit to show.
  ///
  /// TODO: replace this test ad unit with your own ad unit

  AdsView({
    super.key,
    this.adSize = AdSize.banner,
    required this.adUnitId
  });

  @override
  State<AdsView> createState() => _AdsViewState();
}

class _AdsViewState extends State<AdsView> {
  /// The banner ad to show. This is `null` until the ad is actually loaded.
  BannerAd? _bannerAd;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        child: _bannerAd == null
        // Nothing to render yet.
            ? SizedBox.shrink()
        // The actual ad.
            :
        // MediaQuery.of(context).size.width>650?
        //     Row(
        //       children: [AdWidget(ad: _bannerAd!),AdWidget(ad: _bannerAd!)],
        //     ):
            AdWidget(


                ad: _bannerAd!),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  /// Loads a banner ad.
  void _loadAd() {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }
}


String adUnitCode = """  
<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-5507566531768621"
     crossorigin="anonymous"></script>
<!-- Grimoire web -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-5507566531768621"
     data-ad-slot="9545651321"
     data-ad-format="auto"
     data-full-width-responsive="true"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>
""";