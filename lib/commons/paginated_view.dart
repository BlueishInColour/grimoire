import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../load_widget.dart';

Widget paginatedView(
    {required Query<Object?> query,
      String emptyText = "",
      bool reverse = false,
    required Function(Map<String, dynamic> data)
        child}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FirestorePagination(
      query: query,
      isLive: true,
      reverse: reverse,
      // physics: const NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      itemBuilder: (context, documentSnapshot, index) {

        DocumentSnapshot data =
            documentSnapshot[index];
        Map<String,dynamic> json = data.data() as Map<String,dynamic>;
        // if (index == 0 && showFirstItem) {
        //   return
        //   firstItem ?? SizedBox();
        // } else
          return child(json);
      },

      onEmpty:Center(
        child: Image.asset("assets/empty.png",height: 200,)
      ),
      initialLoader: Center(child: loadWidget()),
      bottomLoader: Center(child: loadWidget()),
      limit: 5,

    ),
  );
}
