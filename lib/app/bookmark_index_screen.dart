import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/commons/adapters/book_list_adapter_item.dart';
import '../commons/views/paginated_view.dart';
import '../models/history_model.dart';

class BookmarkIndexScreen extends StatefulWidget {
  const BookmarkIndexScreen({super.key});

  @override
  State<BookmarkIndexScreen> createState() => _BookmarkIndexScreenState();
}

class _BookmarkIndexScreenState extends State<BookmarkIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,

          title: Text("bookmark"),
        ),
        body:
        paginatedView(query: FirebaseFirestore.instance.collection("bookmark").where("createdBy",isEqualTo: FirebaseAuth.instance.currentUser?.email ??"").orderBy("createdAt",descending: true),
            child: (datas,index) {
              Map<String, dynamic> json = datas[index].data() as Map<
                  String,
                  dynamic>;
             HistoryModel historyModel = HistoryModel.fromJson(json);



              return BookListAdapterItem(bookId: json["bookId"], size: 11,createdAt:historyModel.createdAt);
            }
        )
    );
  }
}
