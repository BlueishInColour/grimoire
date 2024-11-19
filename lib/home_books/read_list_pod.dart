import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/adapters/book_grid_adapter_item.dart';
import 'package:grimoire/commons/views/load_widget.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:grimoire/repository/user_repository.dart';
import '../models/list_model.dart';
import '../models/user.dart';

class ReadListPod extends StatefulWidget {
  const ReadListPod({super.key,
    this.showRecommendButton= false,
   required this.list});
final ListModel list ;
final bool showRecommendButton;
  @override
  State<ReadListPod> createState() => _ReadListPodState();
}

class _ReadListPodState extends State<ReadListPod> {
  int selectedIndex = 0;
  double size = 8;

  @override
  initState(){
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    ListModel list = widget.list;
    bool isMine = list.createdBy == FirebaseAuth.instance.currentUser?.email;
double size = 8;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(5)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(list.title,
                  maxLines: 1,
                  style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.w900,
                      fontSize: 15
                  ),),
                widget.showRecommendButton? StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("list").doc(list.listId).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return loadWidget();
                      }
                      else if(snapshot.hasData){
                        ListModel list = ListModel.fromJson(snapshot.data?.data()??{});
                        // bool? isRecommended = list.status == Status.??false;
                        bool isDrafted = list.status == Status.Drafted;
                        bool isReview = list.status == Status.Review;
                        bool isPublished = list.status == Status.Publish;
                        bool isRejected = list.status == Status.Rejected;
                        return SizedBox(
                          height: 30,
                          child: Row(

                            children: [
                              Text(isReview?"In Review":isPublished ?"Published":isRejected?"Rejected":"Recommend",style: GoogleFonts.merriweather(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800
                              ),),
                              SizedBox(width: 5,),
                              Switch(

                                  activeColor: Colors.green,
                                  inactiveTrackColor:isReview?Colors.orange:isRejected?Colors.red.shade800:Colors.grey.shade200,
                                  value: isPublished,
                                  onChanged: (v)async{
                                    await FirebaseFirestore.instance.collection("list").doc(list.listId).update({"status":Status.Review.name});
                                  }),
                            ],
                          ),
                        );
                      }
                      else {
                        return Icon(Icons.error,color: Colors.grey.shade600,);
                      }
                    }
                ):SizedBox.shrink()
              ],
            ),
            FutureBuilder(future: UserRepository().getOneUser(email: list.createdBy, isCompleted: (){}),

              builder: (context, snapshot) {
              final style =  GoogleFonts.merriweather(
                  fontWeight: FontWeight.w500,
                  fontSize: 10
              );
              if(snapshot.connectionState == ConnectionState.waiting) return Text(
                  "@",
                  style:style);
              else if(snapshot.hasData){
                User user  = snapshot.data?? User();
                return Text(
                    "@" + user.full_name,
                    style:style);
              }
             else   return Text(
                    "@curator",
                    style:style);
              }
            ),

            // SizedBox(width: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height:(size*16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: list.listItems.length,
                    itemBuilder: (context,index){
                  return
                    // Text(list.listItems[index],style: TextStyle(color: Colors.red,fontWeight: FontWeight.w800),);
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Stack(
                        children: [
                          BookGridAdapterItem(
                              onTap: (){
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              bookId: list.listItems[index], size: size),
                       widget.showRecommendButton&& isMine?Positioned(
                          top:0,
                          right:0,
                          child: IconButton(onPressed: ()async{
                            await FirebaseFirestore.instance.collection("list").doc(list.listId).update({
                              "listItems":FieldValue.arrayRemove([list.listItems[index]])
                            }).whenComplete((){
                              showToast("Removed");});
                          }, icon: Icon(Icons.clear,color: Colors.red.shade900,size:14 ,)),
                        ):SizedBox()
                        ],
                      ),
                    );

                     }),
              ),
            ),
           FutureBuilder(
             future: FirebaseFirestore.instance.collection("library").doc(list.listItems[selectedIndex]).get(),
             builder: (context, snapshot) {
               if(snapshot.connectionState == ConnectionState.waiting)return SizedBox.square(dimension: 10,child: CircularProgressIndicator(color: Colors.black,));
               else if(snapshot.hasData&& snapshot.data?.data() != null){
                 BookModel book = BookModel.fromJson(snapshot.data?.data()??{});
               return Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Text(book.title,
                     overflow: TextOverflow.ellipsis,
                     style: GoogleFonts.merriweather(
                       fontSize: 15,
                       fontWeight: FontWeight.w900

                     ),),  Text(book.aboutBook,
                     maxLines: 4,
                     overflow: TextOverflow.ellipsis,
                     style: GoogleFonts.merriweather(
                       fontSize: 12,

                     ),),
                   SizedBox(height: 5,),
                   SizedBox(
                     height:30,
                     width:70,
                     child: ElevatedButton(
                         style:ButtonStyle(
                           backgroundColor: WidgetStatePropertyAll(Colors.black87),
                           foregroundColor: WidgetStatePropertyAll(Colors.white70),
                           shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))

                         ),
                         onPressed: (){
                       goto(context, BookDetailScreen(bookId: book.bookId,
                           book: book));
                     },
                         child: Text("Open",
                         style: GoogleFonts.merriweather(
                           fontSize: 8,
                           fontWeight: FontWeight.w800
                         ),)),
                   )
                 ],
               );}
               else return Text("");
             }
           ),

          ],
        ),
      ),
    );
  }
}
