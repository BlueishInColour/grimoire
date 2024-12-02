import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/tab_count.dart';
import 'package:grimoire/repository/book_repository.dart';
import 'package:grimoire/repository/like_repository.dart';

final countStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w800, fontSize: 14, color: Colors.black54);
Widget likesCount(context, bookId) {
  return countText(context,
      bookId: bookId,
      abriviate: true,
      future: LikeRepository()
          .ref
          .where("bookId", isEqualTo: bookId)
          .count()
          .get()
          .then((v) {
        return v.count ?? 0;
      }));
}

Widget chaptersCount(context, bookId) {
  return countText(context,
      bookId: bookId,
      future: FirebaseFirestore.instance
          .collection("story")
          .where("bookId", isEqualTo: bookId)
          .count()
          .get()
          .then((v) {
        return v.count ?? 0;
      }));
}

Widget countText(context,
    {required bookId, required Future<int>? future, bool abriviate = true}) {
  return Center(
    child: FutureBuilder<int>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            int count = snapshot.data ?? 0;
            return abriviate
                ? Text(
                    count.toString(),
                    overflow: TextOverflow.fade,
                    style: countStyle,
                  )
                : Text(
                    count.toString(),
                    maxLines: 1,
                    style: countStyle,
                  );
          } else
            return Text(
              "-",
              style: countStyle,
            );
        }),
  );
}
