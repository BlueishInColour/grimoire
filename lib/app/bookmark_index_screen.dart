import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkIndexScreen extends StatefulWidget {
  const BookmarkIndexScreen({super.key});

  @override
  State<BookmarkIndexScreen> createState() => _BookmarkIndexScreenState();
}

class _BookmarkIndexScreenState extends State<BookmarkIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("bookmarked",style: GoogleFonts.montserrat(fontSize: 15),),
      ),
    );
  }
}
