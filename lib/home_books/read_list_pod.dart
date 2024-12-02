import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/adapters/book_grid_adapter_item.dart';
import 'package:grimoire/commons/buttons/follow_button.dart';
import 'package:grimoire/commons/views/load_widget.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:grimoire/repository/follow_repository.dart';
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
double size = 25;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(future: UserRepository().getOneUser(email: list.createdBy, isCompleted: (){}),

                builder: (context, snapshot) {
                  final style =  GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 10
                  );
                  final textButtonStyle =  GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    color: colorBlue
                  );
                  if(snapshot.connectionState == ConnectionState.waiting) return Text(
                      "@",
                      style:style);
                  else if(snapshot.hasData){
                    User user  = snapshot.data?? User();
                    return Row(
                      children: [
                        Text(
                            "@" + user.pen_name,
                            style:style),
                        SizedBox(width: 5,),
                        FollowButton(emailAddress: user.email_address,)
                       
                      ],
                    );
                  }
                  else   return Text(
                        "@curator",
                        style:style);
                }
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(list.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 13
                  ),),

              ],
            ),

            SizedBox(height: 10,),
            Container(
              height:(size*8)+80,

              child: ListView.builder(

                scrollDirection: Axis.horizontal,
                  itemCount: list.listItems.length,
                  itemBuilder: (context,index){
                return
                  // Text(list.listItems[index],style: TextStyle(color: Colors.red,fontWeight: FontWeight.w800),);
                  BookGridAdapterItem(
                      onTap: (v){
                      goto(context, BookDetailScreen(bookId: v.bookId, book: v));
                      },
                      bookId: list.listItems[index], size: size);

                   }),
            ),

          ],
        ),
      ),
    );
  }
}

Widget recommendButton(bool showRecommendButton, ListModel list){
  return showRecommendButton? StreamBuilder(
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
  ):SizedBox.shrink();
}