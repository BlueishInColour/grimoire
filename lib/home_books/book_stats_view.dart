import 'package:flutter/material.dart';

class BookStatsView extends StatefulWidget {
  const BookStatsView({super.key,required this.bookId});
final String bookId;
  @override
  State<BookStatsView> createState() => _BookStatsViewState();
}

class _BookStatsViewState extends State<BookStatsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   body:  ListView(
     children: [

       // daily reads
       //monthly reads

       // total read hours

       //money earned monthly
     ],

   )
    );
  }
}
