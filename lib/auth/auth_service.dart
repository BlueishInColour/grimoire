import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //signin method
  Future<UserCredential> login(String email, String password,BuildContext context) async {
    var details = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if(details.user!.email!.isNotEmpty){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainApp()));
    }

    return details;
  } //signin method
  Future<UserCredential> guest(BuildContext context) async {
    var details = await _auth.signInAnonymously();
    if(details.user?.email?.isNotEmpty ?? false){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainApp()));

    }

    return details;
  }

  //signup method
  Future<UserCredential> signup(String email, String password,BuildContext context) async {
    var details = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    // if(details.user!.email!.isNotEmpty){
    //   await WalletFlutterwaveRepository().createWalletAccount(context);
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Index()));
    //
    //
    //
    // }
    return details;
  }
  //signout method
sendForgottenPasswordEmail(BuildContext context,String email)async{
    await _auth.sendPasswordResetEmail(email: email).then((v){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
              Text("check your email inbox for reset link")));
    });
}
  logout() async {
    await _auth.signOut();
  }

     String clientId =     "1035770891435-ee626ka6ql6lco77jk5akgv8ggv02atb.apps.googleusercontent.com";
  Future<dynamic> signInWithGoogle(
      {required Function(GoogleSignInAccount) isSignedIn}) async {
    try {
      final GoogleSignIn googleUser =  GoogleSignIn(
        clientId: clientId
      );
      GoogleSignInAccount? googleAccount  = await googleUser.signIn();

    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  signInWithGoogleWeb()async{
     GoogleSignIn googleSignIn = GoogleSignIn(
clientId:clientId,
);

await googleSignIn.signIn();

  }

}
