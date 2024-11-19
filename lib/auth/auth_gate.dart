
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/commons/views/load_widget.dart';
import 'package:provider/provider.dart';

import '../commons/views/first_timer_screen.dart';
import '../main_controller.dart';
import 'create_user_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key,
    required this.isSignedInChild,
    required this.isNotSignedInChild,
  });
  final Widget isSignedInChild;
  final Widget isNotSignedInChild;


  @override
  State<AuthGate> createState() => AuthGateState();
}

class AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {

    return Consumer<MainController>(
      builder:(context,c,child)=> Scaffold(

        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){return loadWidget();}
              if (snapshot.hasData) {
                return
                  // MainApp();
                  StreamBuilder(stream: c.isFirstTime().asStream(),
                      builder: (context,snapshot){

                          return widget.isSignedInChild;
                        // }
                      });
              } else {
                return widget.isNotSignedInChild;

              }
            }),
      ),
    );
  }
}

