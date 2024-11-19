import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/app_index_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/models/message.dart';
import 'package:grimoire/repository/chat_repository.dart';

import '../chat/chat_index_screen.dart';
import '../chat/chat_screen.dart';
import '../chat/user_index_screen.dart';
import '../chat/user_info_tile.dart';
import '../commons/views/paginated_view.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: listOfTabModel.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
              isScrollable: true,
            controller: tabController,
              tabs:
          listOfTabModel.map((v){
            return Tab(text: v.text,);
          }).toList()
          )),


        body:
TabBarView(
    controller: tabController,
    children: listOfTabModel.map( (v){
  return
    paginatedView(
      key: Key(v.text),
        query: v.query, child: (datas,index){
      Map<String,dynamic> json = datas[index].data() as Map<String,dynamic> ;
      Message message  = Message.fromJson(json);

      String email   = message.senderEmail;
      return
        ListTile(
          onTap:  (){
            goto(context, ChatScreen(email: email));
          },
          title: userInfoTile(context, email),

        subtitle: Text(
          message.text
        ),
        trailing: SizedBox(width: 40,
          child: StreamBuilder<int>(
              stream: ChatRepository().getUnreadChatCount(chatKey(email)),
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
          ),
        ),
        );
    });
} ).toList())

    );
  }
}
