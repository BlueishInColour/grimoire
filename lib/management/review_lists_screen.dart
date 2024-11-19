import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/commons/views/paginated_view.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/home_books/read_list_pod.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:grimoire/models/list_model.dart';

class ReviewListsScreen extends StatefulWidget {
  const ReviewListsScreen({super.key});

  @override
  State<ReviewListsScreen> createState() => _ReviewListsScreenState();
}

class _ReviewListsScreenState extends State<ReviewListsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginatedView(query: FirebaseFirestore.instance.collection("list").where("status",isEqualTo: Status.Review.name),
          child: (datas,index){
        ListModel list = ListModel.fromJson(datas[index].data() as Map<String,dynamic> ??{});
        return Column(
          children: [
            ReadListPod(list: list),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: ()async{

                  debugPrint("presssed");

                  await FirebaseFirestore.instance.collection("list").doc(list.listId).update(
                    {"status":Status.Publish.name}).whenComplete((){
                  Fluttertoast.showToast(msg: "Done",);
                });}, child: Text("Publish")),

                ElevatedButton(onPressed: ()async{ await FirebaseFirestore.instance.collection("list").doc(list.listId).update(
                    {"status":Status.Rejected.name}).whenComplete((){
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
