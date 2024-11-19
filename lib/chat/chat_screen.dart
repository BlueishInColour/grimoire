import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/chat/user_info_tile.dart';
import 'package:provider/provider.dart';
import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../commons/views/bottom.dart';
import '../commons/views/paginated_view.dart';
import '../constant/CONSTANT.dart';
import '../models/message.dart';
import '../repository/chat_repository.dart';
import 'message_bubble.dart';
import 'chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key,this.messageText = "", required this.email,this.showMessageBar  =false});
  final String email;
  final String messageText;
 final  bool showMessageBar;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  final chatController = TextEditingController();
  sendInitialMessage()async{
    if(widget.messageText.isNotEmpty){

     await ChatRepository().sendMessage(message: Message(chatKey:  chatKey(MY_UID),text: widget.messageText));
    }

  }
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendInitialMessage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer<ChatController>(
      builder: (context, c, child) => Scaffold(
        appBar: AppBar(
          title:userInfoTile(context, "blueishincolour@gmail.com"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                  paginatedView(query: c.repo.ref
                      .where("chatKey", isEqualTo: chatKey(MY_UID))
                      .orderBy("created_at", descending: true),
                      child: (datas,index){
                    Map<String,dynamic> json = datas[index].data() as Map<String,dynamic>;
                    Message message = Message.fromJson(json);
                    return MessageBubble(message);
                      },
                  reverse: true,

                  )
              ),
            ),
            BottomBar(
              child:(fontSize,iconSize)=> TextField(
                  controller: chatController,


                  style: GoogleFonts.merriweather(
                      fontSize: fontSize,
                      color: Colors.white70
                  ),
                  minLines: 1,
                  maxLines: 5,


                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,

                  cursorHeight: 17,
                  cursorColor: Colors.white,

                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 15,left: 15),
                      hintText: "message librarian ...",
                      hintStyle: GoogleFonts.merriweather(
                          fontSize: fontSize,
                          color: Colors.white70
                      ),

                      filled: true,
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,



                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () async {
                            await ChatRepository().sendMessage(message: Message(chatKey:  chatKey(MY_UID),text: chatController.text));
                            chatController.clear();

                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.white70,
                            size: iconSize,
                          ),
                        ),
                      )
                  )

              ),

            ),




          ],
        ),

        bottomNavigationBar: adaptiveAdsView(
            AdHelper.getAdmobAdId(adsName:Ads.addUnitId2)
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    context.dependOnInheritedWidgetOfExactType();
  }

  @override
  void dispose() {
    // Provider.of<ChatController>(context,listen:  false).removeListener((){});
    // TODO: implement dispose
    super.dispose();
  }
}

String chatKey(String otherChatterEmail) {
  List<String> listKey = [
    FirebaseAuth.instance.currentUser?.uid ?? "",
    otherChatterEmail
  ];
  listKey.sort();
  String key = listKey.join();
  return key;
}
