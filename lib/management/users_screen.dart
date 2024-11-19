import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/paginated_view.dart';

import '../models/user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: paginatedView(
          query:FirebaseFirestore.instance.collection("user") .orderBy("createdAt",descending: true) ,
          child: (datas,index){
            Map<String,dynamic> json = datas[index].data() as Map<String,dynamic>;
            User user = User.fromJson(json);
            return ListTile(
              leading: CircleAvatar(),
              title: Text(user.full_name),
              trailing:timeFormat(user.created_at)
            );
          }),
    );
  }
}

Widget timeFormat(DateTime created_at) {
  return  Text(DateTimeFormat.format(created_at!,
    format: "d/j/y H:i",

  ),
    style: GoogleFonts.merriweather(
        fontWeight: FontWeight.w700,
        fontSize: 10
    ),);
}
