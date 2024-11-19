import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/auth/tf.dart';
import 'package:grimoire/models/feedback_model.dart';
import 'package:uuid/uuid.dart';

import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';

 final feedbackRef = FirebaseFirestore.instance.collection("feedback");
class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final emailController = TextEditingController();
  final feedbackController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = FirebaseAuth.instance.currentUser?.email??"";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8,),
        child: ListView(
          children: [
           authTextField("Email", emailController,validateEmai: true,),

Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextField(
    style: GoogleFonts.merriweather(
        color: Colors.black
    ),
    controller: feedbackController,
    maxLines: 20,
      minLines: 10,
    decoration: InputDecoration(
      hintText: "feedback ......"
    ),

  ),
),
            Text("Grimoire sincerely appreciate your critical views and will do all to improve the platform.",
            style: GoogleFonts.merriweather(),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: ()async{
                String id  = Uuid().v1();
                await feedbackRef.doc(id).set(
                FeedbackModel(
                  text: feedbackController.text,
                 replyEmail: emailController.text,
                  feedbackId:  id

                ).toJson()
                ).whenComplete((){
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your feedback has been sent and is appreciated")));
                });
              }, child: Text("Send Feedback")),
            ),
          ],
        ),
      ),
      bottomNavigationBar: adaptiveAdsView(


          AdHelper.getAdmobAdId(adsName:Ads.addUnitId6)

      )
    );
  }
}
