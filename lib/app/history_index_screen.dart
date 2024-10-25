import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryIndexScreen extends StatefulWidget {
  const HistoryIndexScreen({super.key});

  @override
  State<HistoryIndexScreen> createState() => _HistoryIndexScreenState();
}

class _HistoryIndexScreenState extends State<HistoryIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("history",style: GoogleFonts.montserrat(fontSize: 15),),
      ),
    );
  }
}
