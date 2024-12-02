import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/models/history_model.dart';
import 'package:grimoire/news/news_model.dart';

class NewsRepository{
  NewsRepository();
  CollectionReference<Map<String, dynamic>> get ref  => FirebaseFirestore.instance.collection("news");

  addNews(NewsModel news)async{
    await ref.doc(news.id).set(
        news.toJson()
    ).whenComplete((){
      showToast("news created");
    });
  }
  removeNews(String id)async{
    await ref.doc(id).delete().whenComplete((){showToast("news deleted");});
  }

}