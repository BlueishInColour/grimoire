import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const APPCOLOR =Colors.black;
String MY_UID  = FirebaseAuth.instance.currentUser?.uid??"";

List<String> categories = [
  "Novels",
  "Shorts",
  "Educational",
  "Poetry",
  "Sport & Leisure",
  "Religious",
  "Art & Architecture",
  "Autobiography/Memoir",
  "Humor/Jokes",
  "Craft & Hobbies",
  "Philosophy",
  "Cookbooks",
  "Diaries and Journal",
  "Dictionary/Encyclopedia",
  "Historical",
  "Biography",
  "Business/Economics",
  "Politics",
  "Travel",
  "True Crime"
];

List<String> languages = [
  "English",
  "Yoruba",
  "Turkish",
  "Igbo"
];