import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/chat/user_info_tile.dart';

import 'chat_screen.dart';

class UserIndexScreen extends StatefulWidget {
  const UserIndexScreen({super.key,required this.email,this.url = "",this.toSelectindex = 1});
final String email;
final String url;
final int toSelectindex;
  @override
  State<UserIndexScreen> createState() => _UserIndexScreenState();
}

class _UserIndexScreenState extends State<UserIndexScreen> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin {
 @override
 bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<String> chatkey(){
      var key =[
        FirebaseAuth.instance.currentUser?.email??"",
        widget.email
      ];
      key.sort();
      return key;
    }


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);},
        icon: Icon(Icons.arrow_back),
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
        ),
            backgroundColor: Colors.black,

        foregroundColor: Colors.white,
        title: userInfoTile(context,widget.email),

actions:[

],


      ),
      body:        ChatScreen(key: UniqueKey(),email: widget.email,)

    );
  }
}

