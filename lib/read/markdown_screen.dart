import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class MarkdownScreen extends StatefulWidget {
  const MarkdownScreen({super.key,required this.data});
  final String data;

  @override
  State<MarkdownScreen> createState() => _MarkdownScreenState();
}

class _MarkdownScreenState extends State<MarkdownScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Markdown(data: widget.data,
        softLineBreak: true,
        styleSheetTheme: MarkdownStyleSheetBaseTheme.platform,
        styleSheet: MarkdownStyleSheet(
            p : GoogleFonts.merriweather(
                // color: textColor,
                // fontSize:  fontSize
            )
        ),)
    );
  }
}
