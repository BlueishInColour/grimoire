import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../ads/ads_helper.dart';
import '../ads/ads_view.dart';
import 'load_widget.dart';

Widget paginatedView(
    {required Query<Object?> query,
      Key? key,
      String emptyText = "",
      ViewType viewType = ViewType. list,
      bool reverse = false,
      Axis scrollDirection = Axis. vertical,
      SliverGridDelegate gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2) ,
      required Function( List<DocumentSnapshot<Object?>>, int)
        child}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FirestorePagination(
      key: key,
      query: query,
      isLive: true,
      reverse: reverse,
      scrollDirection: scrollDirection,
      // physics: const NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      viewType: viewType,
      gridDelegate: gridDelegate,
      itemBuilder: (context, documentSnapshot, index) {

        DocumentSnapshot data =
            documentSnapshot[index];
        Map<String,dynamic> json = data.data() as Map<String,dynamic>;
        // if (index == 0 && showFirstItem) {
        //   return
        //   firstItem ?? SizedBox();
        // } else
          return child(documentSnapshot,index);
      },

      onEmpty:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/empty.png",height: 200,),
          SizedBox(width: 5,),
          emptyText.isNotEmpty?Text(emptyText):SizedBox.shrink(),
          SizedBox(width: 5,),

          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId3),
              adSize: AdSize.banner
          ),
        ],
      ),
      initialLoader:   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId3),
            adSize: AdSize.banner
          ),
          SizedBox(height: 10,),
          loadWidget(color: Colors.black),
        ],
      ),
      bottomLoader: Center(child: loadWidget(color: Colors.black)),
      limit: 5,

    ),
  );
}
