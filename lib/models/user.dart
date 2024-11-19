
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
part "user.g.dart";

@JsonSerializable()
class User{
   User({
  this.country = "",
  this.state = "",
  this.city = ""
     ,
     this.full_name = "",
     this.pen_name = "",
     this.refered_by ="",
     this.home_address = "",
     this.profile_picture_url = "",

     this.phone_number="",
     this.email = "",

     this.account_number="",
     this.account_name = "",
     this.bank_name=""
   });

  String full_name ;
  String pen_name;
  String refered_by;
  // String user_name  =FirebaseAuth.instance.currentUser?.email?.replaceAll("@gmail.com", "") ??"";
  String email_address = FirebaseAuth.instance.currentUser?.email ??"";
  String profile_picture_url;

  String phone_number;
  String email;

  String home_address ;
  String city;
  String state;
  String country;

  String bank_name;
  String account_name;
  String account_number;

  DateTime created_at = DateTime.now();


   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

   Map<String, dynamic> toJson() => _$UserToJson(this);
}