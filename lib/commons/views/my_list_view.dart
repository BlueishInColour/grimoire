import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/paginated_view.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:grimoire/models/list_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MyListView extends StatefulWidget {
  const MyListView({super.key,required this.bookId});
  final String bookId;

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(onPressed: (){
            showModalBottomSheet(context: context, builder: (context){
              return AddListView(bookId:widget.bookId);
            });
          },
              icon: Icon(Icons.add),
              label: Text("New Picks"))
        ],
      ),
      body: paginatedView(query: FirebaseFirestore.instance.collection("list").where("createdBy",isEqualTo: FirebaseAuth.instance.currentUser?.email??""),
          child: (datas,index){
        ListModel list = ListModel.fromJson(datas[index].data() as Map<String,dynamic>);
            String bookId = widget.bookId;
            bool bookExistsInList = list.listItems.contains(bookId);
            return ListTile(
              onTap: ()async{
                if(bookExistsInList){
                  showToast("This book exists in list");
                }
                else if(list.status != Status.Publish){
                  showToast("This  book isn't published yet ");
                }
             else{
                  await FirebaseFirestore.instance.collection("list").doc(list.listId).update({
                    "listItems":FieldValue.arrayUnion([bookId])
                  }).whenComplete((){
                    showToast("done");
                    Navigator.pop(context);});
                }
              },
              title: Text(list.title,style: GoogleFonts.merriweather(

              ),),
              trailing: Icon(Icons.add),

            );
          }),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:grimoire/commons/paginated_view.dart';
//
class AddListView extends StatefulWidget {
  const AddListView({super.key,this.bookId = ""});
final String bookId;
  @override
  State<AddListView> createState() => _AddListViewState();
}

class _AddListViewState extends State<AddListView> {
  final textController=  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200,
          child: Column(
            children: [
              SizedBox(width: 20),
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: "New List"
                ),
              ),
              SizedBox(width: 30,),
              Row(
                children: [
                  ElevatedButton(
                      style:ButtonStyle(
              ),
                      onPressed: ()async{
                    String id = Uuid().v1();
                    ListModel item = ListModel(
                      listId:id,
                      title: textController.text,
        
                      listItems:[widget.bookId],
        
        
                    );
                          await    FirebaseFirestore.instance.collection("list").doc(id).set(
                      item.toJson()
        
                    ).whenComplete((){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New list with book has been created")));
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  }, child: Text("Create")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

