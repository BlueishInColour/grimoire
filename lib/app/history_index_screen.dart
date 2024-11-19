import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/adapters/book_list_adapter_item.dart';

import '../commons/views/paginated_view.dart';
import '../models/history_model.dart';

class HistoryIndexScreen extends StatefulWidget {
  const HistoryIndexScreen({super.key});

  @override
  State<HistoryIndexScreen> createState() => _HistoryIndexScreenState();
}

class _HistoryIndexScreenState extends State<HistoryIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("history",style: GoogleFonts.merriweather(fontSize: 15),),
      ),
       body:
       paginatedView(query:FirebaseFirestore.instance.collection("user_data")
           .doc(FirebaseAuth.instance.currentUser?.email)
           .collection("history"),

           child: (datas,index) {
             Map<String, dynamic> json = datas[index].data() as Map<
                 String,
                 dynamic>;
             HistoryModel historyModel = HistoryModel.fromJson(json);
             DateTime dateTime = DateTime.parse(json["createdAt"]);


             return BookListAdapterItem(bookId: json["bookId"], size: 11,createdAt:historyModel.createdAt);
           }
           )
    );
  }
}
