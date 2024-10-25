import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBooksIndexScreen extends StatefulWidget {
  const MyBooksIndexScreen({super.key});

  @override
  State<MyBooksIndexScreen> createState() => _MyBooksIndexScreenState();
}

class _MyBooksIndexScreenState extends State<MyBooksIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my books",style: GoogleFonts.montserrat(fontSize: 15),),
      ),
    );
  }
}
