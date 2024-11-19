import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:clipboard/clipboard.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/repository/user_repository.dart';
import '../commons/adapters/book_list_adapter_item.dart';
import '../models/user.dart';
import '../models/message.dart';
import '../repository/chat_repository.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble(this.message,{super.key,});
  final Message message;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final repo =ChatRepository();
    repo.readChat( widget.message);
  }
  @override
  Widget build(BuildContext context) {
    Message message = widget.message;
      final isSender = message.sendetUid==FirebaseAuth.instance.currentUser?.email;
    Color    color = isSender ? Color(0xFFE8E8EE) : Colors.purple;


      return   Padding(
        padding: const EdgeInsets.symmetric(vertical:  4.0),
        child:Align(
          alignment: isSender? Alignment.centerRight:Alignment.centerLeft,
          child: Column(
            children: [
              textMessageView(leading: avatar(context,message.sendetUid),message,isAtRight: isSender,child: bubbleChild(message)),
            ],

          ),
        ),
      );


  }
  Widget bubbleChild(Message message,{bool showCheck = true}){
    return Row(
            children: [
            // showCheck?  message.is_read?Icon(Icons.done_all,color:Colors.green,size: 12,):Icon(Icons.done,color: Colors.white54,size: 12,):SizedBox.shrink(),
            //   SizedBox(height: 10,),
              message.is_read?Icon(Icons.done_all,color:Colors.green,size: 12,):Icon(Icons.done,color: Colors.white54,size: 12,),


              Text(DateTimeFormat.relative(message.created_at,abbr: true),style: TextStyle(color: Colors.black54,fontSize: 10,),),
            ],
          );
  }

Widget   textMessageView(Message message,{ bool isAtRight = true,
  Widget leading = const SizedBox.shrink(),
  Widget child =const SizedBox.shrink()}) {
    bool isMine = FirebaseAuth.instance.currentUser?.uid  == message.sendetUid;
    return message.text.isNotEmpty?
        Row(
          textDirection: !isMine?TextDirection.ltr:TextDirection.rtl,
          children: [
            leading,
          Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message.question,
                  style: GoogleFonts.montserrat(
                    color: Colors.black54,
                    fontWeight: FontWeight.w800,
                    fontSize: 10
                  ),),
                 message.type ==0? BubbleSpecialOne(

                   text: message.text,
                  isSender:isMine,

                  textStyle: GoogleFonts.merriweather(
                    color: Colors.white70
                  ),
                  tail: true,
                  color: isMine?Colors.green.shade900:Colors.blue.shade900,)
                  : BookListAdapterItem(
                   size: 10,
                     showDate: false,
                     createdAt: DateTime.now(),
                     bookId: message.text,

                  ),

    bubbleChild(message)


                ],
              ),

            ],
        )
    :SizedBox.shrink();

}

}
Widget avatar(BuildContext context,String email){
  return Row(
    children: [
      FutureBuilder<User>(
          future:UserRepository().getOneUser(email: email,isCompleted: (){}),
          builder: (context, snapshot) {
            User user = snapshot.data ?? User(full_name: "anonymous");

            if(snapshot.hasData){
             return  CircleAvatar(backgroundImage: NetworkImage(user.profile_picture_url));
            }
            else return CircleAvatar();
          }
      ),
      SizedBox(width: 5,),

    ],
  );
}