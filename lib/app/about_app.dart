import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ("about us"),
      ),
      body: ListView(
        children: [
          //about
          //about

          //users statement

          //bottom bar with privacy policies, terms and conditions
        ],
      ),
    );
  }
}
