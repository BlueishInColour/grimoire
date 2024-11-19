import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../main_controller.dart';
import 'auth_gate.dart';
import 'create_user_screen.dart';

Widget authButton(){
  final style = ButtonStyle(
    side: WidgetStatePropertyAll(
        BorderSide(color: Colors.white54,
            width: 2)
    ),
    foregroundColor: WidgetStatePropertyAll(Colors.white54),
    minimumSize: WidgetStatePropertyAll(Size(50,30)),
    textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 9)),
    iconSize: WidgetStatePropertyAll(12)
  );
  Widget outlinedButton({
    required String label,
    Widget? icon,
   required Function() onPressed
  }){
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(horizontal: 7,vertical: 2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white54,width: 2),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [icon!,SizedBox(width: 10,),Expanded(
            child: Text(label,style: TextStyle(
              color: Colors.white54,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis
            ),),
          )],
        ),
      ),
    );
  }
  return Consumer<MainController>(
    builder:(context,c,child) =>
  FirebaseAuth.instance.currentUser!.email!.isNotEmpty?
      Row(
  children: [
  CircleAvatar(
  backgroundImage:FirebaseAuth.instance.currentUser!.photoURL!.isNotEmpty? NetworkImage(
  FirebaseAuth.instance.currentUser!.photoURL ??""
  ):null,
  child: IconButton(onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUserScreen()));

  },
  icon: !FirebaseAuth.instance.currentUser!.photoURL!.isNotEmpty?Icon(Icons.person_3_outlined):SizedBox()))  ,
  SizedBox(width: 15,),
  Text("Yo! " +  "${FirebaseAuth.instance.currentUser!.displayName?.split(" ")[0]}" ??"edit profile",
  style: GoogleFonts.merriweather(
  fontSize: 20,
  fontWeight: FontWeight.w800,
  color: Colors.white70,
  ),)
  ],
  )
  :
  Flexible(
           child: TextButton.icon(
           
               onPressed: (){goToAuthGate(context);},
               icon: CircleAvatar(
                 child: Icon(Icons.person,
                 ),
               ),
           
               label: Text("welcome! login to get started",
                   style: GoogleFonts.merriweather(
                   fontSize: 20,
                   fontWeight: FontWeight.w800,
                   color: Colors.white70
               ),)),

    ),
  );
}

goToAuthGate(context){
  // Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthGate()));
}