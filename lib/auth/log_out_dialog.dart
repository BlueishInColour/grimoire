
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grimoire/auth/auth_service.dart';

Widget exitDialog(context){
  return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text("Exit"),
      alignment: Alignment.center,

      content: Text("yo! ,do you really want to leave?"),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Cancel",style:TextStyle(
        ))),

        TextButton(onPressed: (){
          if (Platform.isIOS) {
            exit(0);
          } else {
            SystemNavigator.pop();
          }
        }, child: Text("Exit",style:TextStyle(
            color: Colors.red
        )))
      ]
  );
}


Widget logoutDialog(context){
  return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text("Logout"),
      alignment: Alignment.center,

      content: Text("yo! ,do you really want to leave?"),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("No",style:TextStyle(
        ))),

        TextButton(onPressed: (){
        AuthService().logout();
        Navigator.pop(context);

        }, child: Text("Yes",style:TextStyle(
            color: Colors.red
        )))
      ]
  );
}