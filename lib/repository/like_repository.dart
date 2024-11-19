import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/models/history_model.dart';

class LikeRepository{
  LikeRepository();
  CollectionReference<Map<String, dynamic>> get ref  => FirebaseFirestore.instance.collection("user_data").doc(FirebaseAuth.instance.currentUser?.email ??"").collection("like");

  likeBook(String bookId)async{
    await ref.doc(bookId).set(
      HistoryModel(
         bookId: bookId
      ).toJson()
    ).whenComplete((){showToast("Liked");});
  }
  unLikeBook(String bookId)async{
    await ref.doc(bookId).delete().whenComplete((){showToast("un-liked");});
  }
  Future<List<String>> fetchAllLikedBooks()async{
    var re =await ref.get();
    List<String> list = re.docs.map((v){
      HistoryModel model = HistoryModel.fromJson(v.data());
      return model.bookId;
    }).toList();
    return list;

  }

  Future<bool>isLiked(String bookId)async{
    var re = await ref.doc(bookId).get();
    return re.exists;
  }
  Future<AggregateQuerySnapshot> totalCountsOfLikes()async{
    return await ref.count().get();

  }
}