import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/models/history_model.dart';
import 'package:grimoire/models/scheduled_model.dart';

class ComingSoonRepository{
  ComingSoonRepository();
  CollectionReference<Map<String, dynamic>> get ref  => FirebaseFirestore.instance.collection("schedule");
  Query<Map<String, dynamic>> get bookRef  => FirebaseFirestore.instance.collection("schedule").where("type",isEqualTo: "Book");
  Query<Map<String, dynamic>> get StoryRef  => FirebaseFirestore.instance.collection("schedule").where("type",isEqualTo: "Story");

  scheduleBook(String bookId,DateTime releasedOn)async{
    await ref.doc(bookId).set(
        ScheduledModel(
            id: bookId,
          releasedOn: releasedOn
        ).toJson()
    ).whenComplete((){showToast("Scheduled");});
  }
  unScheduleBook(String bookId)async{
    await ref.doc(bookId).delete().whenComplete((){showToast("Un-scheduled");});
  }
  Future<List<String>> fetchAllScheduledBooks()async{
    var re =await bookRef.get();
    List<String> list = re.docs.map((v){
      ScheduledModel model = ScheduledModel.fromJson(v.data());
      return model.id;
    }).toList();
    return list;

  }

  Future<bool>isScheduled(String bookId)async{
    var re = await ref.doc(bookId).get();
    return re.exists;
  }
  Future<AggregateQuerySnapshot> totalCountsOfSchedules()async{
    return await ref.count().get();

  }
}