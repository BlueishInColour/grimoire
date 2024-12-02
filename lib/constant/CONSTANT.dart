import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const APPCOLOR =Colors.black;
String MY_UID  = FirebaseAuth.instance.currentUser?.uid??"";

List<String> categories = [
  "Novels",
  "Poetry",
  "Religion",
  "Biography",
  "Memoir"
];

List<String> languages = [
  "English",
  "Yoruba",
  "Turkish",
  "Igbo"
];

Color colorRed = Color(0xffff0000);
Color colorPurple = Color(0xFFeb09ff);
Color colorBlue = Color(0xFF3b54ff);


String librarianNumber = '+2348120818487';

double SMALLSIZE = 14;
double MIDDLESIZE = 25;
double LARGESIZE = 40;