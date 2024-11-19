import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/models/history_model.dart';

class BookmarkButton extends StatefulWidget {
  const BookmarkButton({super.key,required this.bookId});

  final String bookId;
  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  @override
  Widget build(BuildContext context) {
    bookmark()async{
      FirebaseFirestore.instance
          .collection("bookmark")
          .add(HistoryModel(
        bookId: widget.bookId,
      ).toJson()).whenComplete((){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(
          children: [
            Icon(Icons.done,color: Colors.green,),
            Text("bookmarked"),
          ],
        )));
      });
    }
    return
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection("bookmark").where("createdBy",isEqualTo: FirebaseAuth.instance.currentUser?.email ??"").where("bookId",isEqualTo: widget.bookId).get().asStream(),
        builder: (context, snapshot) {
          if(snapshot.connectionState ==ConnectionState.waiting){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                  child: CircularProgressIndicator(color: Colors.white70,),
              ),
            );
          }
          else if(snapshot.data?.docs.isNotEmpty??false) {
            HistoryModel historyModel = HistoryModel.fromJson(snapshot.data?.docs.first.data() ??{});
            bool historyExists = historyModel.bookId == widget.bookId;
            return IconButton.filled(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black)),
                onPressed: () {
                 if(!historyExists) {
                    bookmark();
                  }
                },
                icon: Icon(
                 historyExists?Icons.bookmark_added_outlined: Icons.bookmark_add_outlined,
                  color: Colors.white70,
                ));
          }
          else return IconButton.filled(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black)),
                onPressed: () {
                    bookmark();
                },
                icon: Icon(
                 Icons.bookmark_add_outlined,
                  color: Colors.white70,
                ));;
        }
      );
  }
}
