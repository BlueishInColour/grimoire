import 'package:flutter/material.dart';

import '../../constant/CONSTANT.dart';
import '../../repository/like_repository.dart';
import '../views/load_widget.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key,required this.bookId});
  final String bookId;


  @override
  State<LikeButton> createState() => _FoolishWithoutStateState();
}

class _FoolishWithoutStateState extends State<LikeButton> {
bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    final bookId = widget.bookId;

    return StreamBuilder(
        stream: LikeRepository().ref.doc(bookId).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting)return loadWidget(size: 12);
          else if(snapshot.hasData && snapshot.data !=null && snapshot.data?.exists   == true){
            return IconButton(
              onPressed: ()async{
                await LikeRepository().unLikeBook(bookId);
                setState(() {
                  isLiked =false;
                });

              },
              icon: Icon(
                  size: 35,
                  Icons.favorite,color: colorRed),
            );
          }
          else if(isLiked == true){
            return  Icon(
                size: 35,
                Icons.favorite_border,color: colorRed);
          }
          else {
            return IconButton(
                onPressed: ()async{
                  setState(() {
                    isLiked = true;
                  });
                  await LikeRepository().likeBook(bookId).hashCode;

                }, icon: Icon(
              size: 35,
              Icons.favorite_border,color: Colors.black87,));
          }
        }
    );
  }
}
