import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grimoire/main_controller.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';
import '../models/book_model.dart';
import '../models/history_model.dart';
import '../read/pdf_viewer_screen.dart';

class BookRepository{
  const BookRepository();

  createBook(
      context,
      {
       required BookModel book,required String bookId , required Function() whenCompleted
      }

      )async{
    book.bookId = bookId;
      await FirebaseFirestore.instance.collection("library").doc(bookId).set(
          book.toJson()).whenComplete(() {
            whenCompleted();

      });

  }

  updateBook(BuildContext context,{required String bookId,required Map<String,dynamic> data})async{
    await FirebaseFirestore.instance.collection("library").doc(bookId).update(data).whenComplete((){
      MainController().showSnackBar(context,"updated");
    });
  }

  readBook(context, {required String  bookId,required String bookPath, bool isFile=false})async{
setHistory(bookId);
    goto(context, PDFViewScreen(pdfPath: bookPath, pdfName: "",isFile: isFile,));
  }


  setHistory(bookId)async{
    await FirebaseFirestore.instance.collection("user_data")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection("history")
        .doc(bookId)
        .set(
        HistoryModel(
            bookId: bookId,
            updatedAt: DateTime.now()
        ).toJson()
    );
  }


}