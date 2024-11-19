import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/repository/user_repository.dart';

import '../models/user.dart';


Widget userInfoTile(BuildContext context,String email, {Widget? subtitle,bool showUserName = false,
double fontSize = 12, double radius = 10}){
  return FutureBuilder<User>(
      future:UserRepository().getOneUser(email: email,isCompleted: (){}),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          User user = snapshot.data ?? User(full_name: "anonymous");
          return ListTile(
              leading: CircleAvatar(
                radius: radius,
                backgroundImage: CachedNetworkImageProvider(user.profile_picture_url),),
              title: Text(user.full_name,style:  GoogleFonts.merriweather(
                fontSize:  fontSize
              ),),

          );
        }
        else return ListTile(
            leading: CircleAvatar(),
            title:Text("Librarian",style: GoogleFonts.merriweather(),)

        );
      }
  );
}