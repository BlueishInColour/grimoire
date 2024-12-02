import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/app/app_index_screen.dart';
import 'package:grimoire/commons/views/paginated_view.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/home_books/read_list_pod.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:grimoire/models/list_model.dart';
import 'package:grimoire/publish/my_books_index_screen.dart';

class CreatorIndexScreen extends StatefulWidget {
  const CreatorIndexScreen({super.key});

  @override
  State<CreatorIndexScreen> createState() => _CreatorIndexScreenState();
}

class _CreatorIndexScreenState extends State<CreatorIndexScreen> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          isScrollable: true,
            controller: tabController,
            tabs: [
          Tab(text: "Curation",),
          Tab(text: "Books",),
        ]),
      ),
      body: TabBarView(
          controller: tabController,
          children: [
      paginatedView(query: FirebaseFirestore.instance.collection("list").where("createdBy",isEqualTo: FirebaseAuth.instance.currentUser?.email??""),
          child: (datas,index){
        ListModel list   = ListModel.fromJson(datas[index].data() as Map<String,dynamic>);
        return Column(
          children: [
            ReadListPod(list: list),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text("Publish"),
                Switch(value: list.status == Status.Publish,
                    onChanged: (v)async{
                  if(v ==true){
                 await   FirebaseFirestore.instance.collection("list").doc(list.listId).update(
                        {"status":Status.Review}).whenComplete(
                     (){showToast("in review");}
                 );
                  }
                  else{
                    await   FirebaseFirestore.instance.collection("list").doc(list.listId).update(
                        {"status":Status.Drafted}).whenComplete(
                            (){showToast("un - published!");
                  }
                    );}})
              ],
            ),
            Divider()
          ],
        );
          }),
        MyBooksIndexScreen()
      ]),
    );
  }
}
