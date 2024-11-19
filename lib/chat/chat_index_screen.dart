import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/chat/user_index_screen.dart';
import 'package:grimoire/chat/user_info_tile.dart';
import 'package:provider/provider.dart';
import '../commons/views/paginated_view.dart';
import '../repository/chat_repository.dart';
import 'chat_controller.dart';
import 'chat_screen.dart';
import '../models/message.dart';

class ChatIndexScreen extends StatefulWidget {
  const ChatIndexScreen({super.key});

  @override
  State<ChatIndexScreen> createState() => _ChatIndexScreenState();
}

class _ChatIndexScreenState extends State<ChatIndexScreen>with AutomaticKeepAliveClientMixin {
  List<List<String>> fetchedChatKey = [];
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ChatController>(
      builder: (context,c,child)=> Scaffold(
        backgroundColor: Colors.black,
         extendBodyBehindAppBar: true,
          appBar:AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: Text("chat",style:  GoogleFonts.pacifico(
              fontSize: 25,
            ),),
            // actions: [
            //   IconButton(onPressed: (){
            //
            //
            //     Navigator.push(
            //         context,
            //         PageRouteBuilder(
            //             pageBuilder: (context, _, __) =>
            //                 MentionAndSearchScreen(
            //                   searchText: "",)) );}       , icon: Icon(Icons.search))
            // ],
          ),
          body:

          paginatedView(
              query: listOfTabModel[0].query, child: (datas,index){
                var data = datas[index];
            String email   = data["email"];
       return    GestureDetector(
           onTap:  ()=>Navigator.push(context,PageRouteBuilder(pageBuilder: (context,_,__)=>
               UserIndexScreen( key:UniqueKey(),toSelectindex: 2,email: email,))),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Expanded(child: userInfoTile(context,email,
                     subtitle: lastMessageTile(
                         context,
                         data["last_message_id"],),
                 showUserName: true
               )),
               StreamBuilder<int>(
                 stream: repo.getUnreadChatCount(chatKey(email)),
                 builder: (context, snapshot) {
                   int count = snapshot.data ?? 0;

                   if(snapshot.hasData && count != 0){
                     return CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 8,
                      child:Center(child: Text(count.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 10),))
                     );
                   }
                   else{
                     return SizedBox.shrink();
                   }

                 }
               )
             ],
           ));
          })


          ));

  }
}
Widget lastMessageTile(BuildContext context,String messageId){
return   StreamBuilder<Message>(
  stream: repo.fetchOneMessage(id: messageId, isCompleted: (){debugPrint("mesage fetched");}),
  builder: (context, snapshot) {
    Message message = snapshot.data??Message(chatKey: "");
   if(snapshot.hasData){
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          message.text.isNotEmpty? Expanded(child: Text(message.text,style: TextStyle(color: Colors.white54,fontSize: 12,overflow: TextOverflow.ellipsis,),maxLines: 1,))
       :   SizedBox(width: 10),

          Row(
            children: [
              message.is_read?Icon(Icons.done_all,color:Colors.green,size: 12,):Icon(Icons.done,color: Colors.white54,size: 12,),
    SizedBox(width: 5),
              Text(DateTimeFormat.relative(message.created_at,abbr: true,appendIfAfter: 'ago'),style: TextStyle(color: Colors.white30,fontSize: 10,),),
            ],
          ),
    
    
        ],
      ),
    );
   }
   else{
        return  Container(width: 80,height: 15,decoration: BoxDecoration(color: Colors.white24,borderRadius: BorderRadius.circular(10)),);

   }
  }
);

}

final repo = ChatRepository();
List<TabModel> listOfTabModel = [
  TabModel(text:  "all",query: FirebaseFirestore.instance.collection("chat")),
  TabModel(text:  "unread",query: repo.ref),
  TabModel(text:  "unreplied",query: repo.ref),
  TabModel(text:  "blocked", query: repo.ref),
];




class TabModel {
  TabModel({this.text ="",required this.query});
  String text;
  Query query ;
}
