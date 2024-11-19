import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/commons/views/paginated_view.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/models/book_model.dart';

class ReviewBooksScreen extends StatefulWidget {
  const ReviewBooksScreen({super.key});

  @override
  State<ReviewBooksScreen> createState() => _ReviewBooksScreenState();
}

class _ReviewBooksScreenState extends State<ReviewBooksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginatedView(query: FirebaseFirestore.instance.collection("library").where("status",isEqualTo: Status.Review.name),
          child: (datas,index){
        BookModel book = BookModel.fromJson(datas[index].data() as Map<String,dynamic> ??{});
        return Column(
          children: [
            BookListItem(onTap: (){goto(context, BookDetailScreen(bookId: book.bookId, book: book));},
              book: book, size: 20,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: ()async{ await FirebaseFirestore.instance.collection("library").doc(book.bookId).update(
                    {"status":Status.Publish}).whenComplete((){
                  Fluttertoast.showToast(msg: "Done",);
                });}, child: Text("Publish")),

                ElevatedButton(onPressed: ()async{ await FirebaseFirestore.instance.collection("library").doc(book.bookId).update(
                    {"status":Status.Rejected}).whenComplete((){
                  Fluttertoast.showToast(msg: "Done",);
                });}, child: Text("Reject")),


              ],
            )
          ],
        );
          }),
    );
  }
}
