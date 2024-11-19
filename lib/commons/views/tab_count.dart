import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numhelpers/numhelpers.dart';

Widget tabCount(context,{
  Color backgroundColor = Colors.black45,
  required Future<AggregateQuerySnapshot> future}){
  return StreamBuilder(stream: future.asStream(), builder: (context,snapshot){
    if(snapshot.connectionState == ConnectionState.waiting) return SizedBox();
    else if(snapshot.hasData){
      int count = snapshot.data?.count??0;
      return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(count.abbreviate().toString().toLowerCase(),
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 7
        ),),
      );

    }
    else return SizedBox();
  });
}