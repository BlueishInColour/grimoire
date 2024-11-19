import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../commons/views/book_list_item.dart';
import '../commons/views/paginated_view.dart';
import '../models/book_model.dart';

class PrivateBooksIndexScreen extends StatefulWidget {
  const PrivateBooksIndexScreen({super.key});

  @override
  State<PrivateBooksIndexScreen> createState() => _PrivateBooksIndexScreenState();
}

class _PrivateBooksIndexScreenState extends State<PrivateBooksIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        title: Text("private books",style: GoogleFonts.merriweather(fontSize: 15),),
      ),
    body:  paginatedView(query: FirebaseFirestore.instance.collection("library").where("createdBy",isEqualTo: FirebaseAuth.instance.currentUser?.email ??"").where("private",isEqualTo: true).orderBy("createdAt"),
          child: (datas,index){

            Map<String,dynamic> json = datas[index].data() as Map<String,dynamic>;
            BookModel book = BookModel.fromJson(json);

            return BookListItem(
              book: book,
              onTap: (){}, id: book.bookId,
              imageUrl: book.bookCoverImageUrl,
              size: 13,
              bookUrl: book.bookUrl,
              aboutBook: book.aboutBook,
              title: book.title,
              tags: book.tags,
              genre:  book.category,
            );
          }),
    );
  }
}
