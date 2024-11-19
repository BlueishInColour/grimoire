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
      Color loadWidgetColor = Colors.black,
      ViewType viewType = ViewType. list,
      bool reverse = false,
      bool shrinkWrap = false,
      Axis scrollDirection = Axis. vertical,
      SliverGridDelegate gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2) ,
      required Function( List<DocumentSnapshot<Object?>>, int)
        child}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FirestorePagination(
      key: key,
      query: query,
      shrinkWrap: shrinkWrap,
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

      onEmpty:emptyWidget(),
      initialLoader:   loadWidget(color: loadWidgetColor),
      bottomLoader: Center(child: loadWidget(color: Colors.black)),
      limit: 5,

    ),
  );
}
