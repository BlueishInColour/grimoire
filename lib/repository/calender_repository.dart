import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/models/calender_event.dart';
import 'package:grimoire/models/follow_model.dart';
import 'package:uuid/uuid.dart';

class CalenderBookRepository{
  CalenderBookRepository();

  CollectionReference<Map<String, dynamic>> get ref  => FirebaseFirestore.instance.collection("user_data").doc(FirebaseAuth.instance.currentUser?.email ??"").collection("calenderbooks")
  ;
  addToCalender(String bookId,DateTime eventDate,DateTime endDate)async{
    String id  = Uuid().v1();
    await ref.doc(bookId).set(
        CalenderEvent(id: bookId,eventDate: eventDate).toJson()
    ). whenComplete((){
      showToast("Event added to your device calender");
    });

  }

  removeFromCalender(String bookId)async{
    await ref.doc(bookId).delete(
    ).whenComplete((){
      showToast("Event REMOVED to your device calender");


    });}

  Future<List<String>> getAllCalenderEvents()async{
    var re =await ref.get();
    List<String> list = re.docs.map((v){
      CalenderEvent model = CalenderEvent.fromJson(v.data());
      return model.id;
    }).toList();
    return list;

  }

  Stream<bool>isCalenderMarked(String bookId)async*{
    var re = await ref.doc(bookId).get();
    yield re.exists;
  }
}

class CalenderStoryRepository{
  CalenderStoryRepository();

  CollectionReference<Map<String, dynamic>> get ref  => FirebaseFirestore.instance.collection("user_data").doc(FirebaseAuth.instance.currentUser?.email ??"").collection("calenderStory")
  ;
  addToCalender(String storyId,DateTime eventDate,DateTime endDate)async{
    String id  = Uuid().v1();
    await ref.doc(storyId).set(
        CalenderEvent(id: storyId,eventDate: eventDate).toJson()
    ). whenComplete((){
      showToast("Event added to your device calender");
    });

  }

  removeFromCalender(String bookId)async{
    await ref.doc(bookId).delete(
    ).whenComplete((){
      showToast("Event REMOVED to your device calender");


    });}

  Future<List<String>> getAllCalenderEvents()async{
    var re =await ref.get();
    List<String> list = re.docs.map((v){
      CalenderEvent model = CalenderEvent.fromJson(v.data());
      return model.id;
    }).toList();
    return list;

  }

  Stream<bool>isCalenderMarked(String bookId)async*{
    var re = await ref.doc(bookId).get();
    yield re.exists;
  }
}