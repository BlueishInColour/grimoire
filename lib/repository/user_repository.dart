import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:grimoire/models/user.dart';
import 'package:uuid/uuid.dart';


class UserRepository {
  final email = FirebaseAuth.instance.currentUser?.email;
  UserRepository();

  CollectionReference<Map<String, dynamic>> get ref  => FirebaseFirestore.instance.collection("user")
  ;

  setUser(
      {
        required User user ,
        required Function isCompleted,
      }
      )async{

    await ref.doc(email).set(user.toJson()).whenComplete((){
      isCompleted();
    });
  }

  updateUser(String key,dynamic value,{required Function isComplete})async{
    await ref.doc(FirebaseAuth.instance.currentUser?.email??"").update({key:value}).whenComplete((){isComplete();});
  }


  Future<User>  getOneUser({required String email,required Function isCompleted})async{

    DocumentSnapshot<Map<String, dynamic>> dat =  await ref.doc(email).get().whenComplete((){
      // CreateUserController().fetchUser();
      isCompleted();

    });
    Map<String,dynamic> data =   dat.data()??{};
    User user = User.fromJson(data);
    return user;

  }
  Stream<User>  streamOneUser(BuildContext context,{required String email,required Function isCompleted})async*{

    DocumentSnapshot<Map<String, dynamic>> dat =  await ref.doc(email).get().whenComplete((){
      // CreateUserController().fetchUser(context);
      isCompleted();

    });
    Map<String,dynamic> data =   dat.data()??{};
    User user = User.fromJson(data);
    yield user;
  }






}
