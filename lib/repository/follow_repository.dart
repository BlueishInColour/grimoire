import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/models/follow_model.dart';
import 'package:uuid/uuid.dart';

class FollowRepository{
  FollowRepository();

  CollectionReference<Map<String, dynamic>> get ref  => FirebaseFirestore.instance.collection("user_data").doc(FirebaseAuth.instance.currentUser?.email ??"").collection("follow")
  ;
  followWriter(String followedAt)async{
    String id  = Uuid().v1();
    await ref.doc(followedAt).set(
      FollowModel(followedAt: followedAt).toJson()
    ).whenComplete((){
      showToast("Followed");
    });

  }
  unFollowWriter(String followedAt)async{
    await ref.doc(followedAt).delete(
    ).whenComplete((){
      showToast("unfollowed");
    });}

    Future<List<String>> getAllFollowings()async{
      var re =await ref.get();
      List<String> list = re.docs.map((v){
        FollowModel model = FollowModel.fromJson(v.data());
        return model.followedAt;
      }).toList();
      return list;

  }

  Stream<bool>isFollowing(String writerEmail)async*{
   var re = await ref.doc(writerEmail).get();
   yield re.exists;
  }
}