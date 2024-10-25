import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivateBooksIndexScreen extends StatefulWidget {
  const PrivateBooksIndexScreen({super.key});

  @override
  State<PrivateBooksIndexScreen> createState() => _PrivateBooksIndexScreenState();
}

class _PrivateBooksIndexScreenState extends State<PrivateBooksIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("private books",style: GoogleFonts.montserrat(fontSize: 15),),
      ),
    );
  }
}
