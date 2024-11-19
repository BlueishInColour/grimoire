import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/chat/user_info_tile.dart';

import '../commons/views/load_widget.dart';
import '../commons/views/paginated_view.dart';
import '../models/review_model.dart';
import '../models/user.dart';
import '../repository/user_repository.dart';

CollectionReference<Map<String, dynamic>> reviewRef = FirebaseFirestore.instance.collection("user_data")
    .doc(FirebaseAuth.instance.currentUser?.email)
    .collection("reviews and ratings");


class ReviewAndRatingsView extends StatefulWidget {
  const ReviewAndRatingsView({super.key,
    required this.bookId
  });
  final String bookId;

  @override
  State<ReviewAndRatingsView> createState() => _ReviewAndRatingsViewState();
}

class _ReviewAndRatingsViewState extends State<ReviewAndRatingsView> {

bool showTextField = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      !showTextField == true?FloatingActionButton(onPressed: (){setState(() {
        showTextField= true;
      });},
        child: Icon(Icons.edit_outlined,color: Colors.white70,),)
      :SizedBox.shrink(
      ),
      body: Column(
          children: [
          ReviewTextField(bookId: widget.bookId,showTextField: showTextField,),
            Expanded(
              child: paginatedView(
                    query: reviewRef,

                    child: (datas,index){
                      Map<String,dynamic> data = datas[index].data() as Map<String,dynamic>;
                      ReviewModel review = ReviewModel.fromJson(data);
                      return
                        ListTile(
                          tileColor: Colors.grey.shade50,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        title:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,


                          children: [

                        FutureBuilder<User>(
                        future:UserRepository().getOneUser(email: review.createdBy ??"",isCompleted: (){}),
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                User user = snapshot.data ?? User(full_name: "anonymous");
                                return
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundImage: CachedNetworkImageProvider(user.profile_picture_url),),
                                      SizedBox(width: 5,),
                                      Text(user.full_name,style:  GoogleFonts.merriweather(
                                          fontSize:  12
                                      ),),
                                    ],
                                  );
                              }
                              else return Row(
                                children: [
                                  CircleAvatar()

                                ],
                              );
                            }
                        ),
                            Row(children: List.generate(5, (v){return
                              Icon(Icons.star,color: v<=review.ratingsCount?Colors.amber:Colors.grey,);
                            }),),
                          ],
                        ),

                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),

                            Text(DateTimeFormat.format(review.updatedAt!,
                              format: "d/j/y H:i",

                            ),
                              style: GoogleFonts.merriweather(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 8
                              ),),


                            Text(review.reviewContent,
                                style: GoogleFonts.merriweather(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14
                                )),
                          ],
                        ),
                      );

                    }),
            ),
          ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

class ReviewTextField extends StatefulWidget {
  const ReviewTextField({super.key,required this.bookId,required this.showTextField});
  final String bookId;
final bool showTextField;
  @override
  State<ReviewTextField> createState() => _ReviewTextFieldState();
}

class _ReviewTextFieldState extends State<ReviewTextField> {
  final textController  = TextEditingController();
  int ratingsCount = 0;

  bool showTextField = false;
  fetchFormerReview()async{
    final ref = await reviewRef.doc(widget.bookId).get();
    ReviewModel reviewModel = ReviewModel.fromJson(ref.data()??{});
    setState(() {
      textController.text = reviewModel.reviewContent;
      ratingsCount = reviewModel.ratingsCount;
    });
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFormerReview();
  }
  
  @override
  Widget build(BuildContext context) {
    return
      !widget.showTextField?
         SizedBox.shrink()
          :
      StreamBuilder(

        stream: FirebaseFirestore.instance.collection("user_data")
            .doc(FirebaseAuth.instance.currentUser?.email)
            .collection("history")
            .doc(widget.bookId).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting) return Row(
            children: [
              loadWidget(),
            ],
          );
          if(snapshot.hasData || snapshot.data?.data() != null) {
            return Column(
              children: [
                Row(children: List.generate(5, (v){return
                  IconButton(onPressed: (){
                    setState(() {
                      ratingsCount = v;
                    });
                  },
                      icon: Icon(Icons.star,color: v<=ratingsCount?Colors.amber:Colors.grey,));
                }),),
                TextField(
                  style: GoogleFonts.merriweather(
                      // fontSize: 15,
                      // color: Colors.white70
                  ),
                  autofocus: true,


                  // cursorHeight: 17,
                  // cursorColor: Colors.white,
                  controller: textController,
                  decoration: InputDecoration(
                      hintText: "write review",
                      hintStyle: GoogleFonts.merriweather(
                      ),
                      filled: true,


                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                      focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),

                      suffixIcon: IconButton(
                          onPressed: ()async{
                            await reviewRef
                                .doc(widget.bookId)
                                .set(
                                ReviewModel(
                                    bookId: widget.bookId,
                                    ratingsCount: ratingsCount,
                                    reviewContent: textController.text,
                                    updatedAt: DateTime.now()
                                ).toJson()).whenComplete((){
                                  textController.clear();

                            });

                          }, icon: Icon(Icons.upload))
                  ),
                )
              ],
            );
          }
          else return SizedBox();
        }
          );
  }
}

