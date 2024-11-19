import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart'hide User;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../repository/user_repository.dart';
import '../../main.dart';
import '../../main_controller.dart';
import '../create_user_screen.dart';

class CreateUserController extends MainController{
  CreateUserController(){
    fetchUser();
    full_name.text = FirebaseAuth.instance.currentUser?.displayName ?? "";
  }
  UserRepository userRepo = UserRepository();


  final full_name = TextEditingController();
  final pen_name = TextEditingController();
  final refered_by = TextEditingController();
  final description = TextEditingController();


  final phone_number = TextEditingController();
  final email = TextEditingController();

  final home_address = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();


  final account_number = TextEditingController();

  final password = TextEditingController();
  final confirm_password = TextEditingController();


  String _account_name = "";
  String get  account_name => _account_name;
  set account_name(v){_account_name = v;notifyListeners();}

  String _bank_name = "bank name";
  String get  bank_name => _bank_name;
  set bank_name(v){_bank_name = v;notifyListeners();}

  String _bank_code = "";
  String get  bank_code => _bank_code;
  set bank_code(v){_bank_code = v;notifyListeners();}

  bool _isLoading = false;
  bool get  isLoading => _isLoading;
  set isLoading(v){_isLoading = v;notifyListeners();}


  int _fetchCount = 0;
  int get fetchCount => _fetchCount;
  set fetchCount(v){_fetchCount = v;notifyListeners();}

  String _profilePicture = "";
  String get profilePicture  => _profilePicture;
  set profilePicture (v){_profilePicture = v;notifyListeners();}
  getPhoto(BuildContext context)async{
  }

  createUser(context)async{
    isLoading = true;
    User user = User(
      country: country.text,
      state: state.text,
      city: city.text,
      full_name: full_name.text,
      pen_name:pen_name.text,
      phone_number: phone_number.text,
      email: email.text,

      home_address: home_address.text,
      profile_picture_url: profilePicture,
      refered_by:refered_by.text,
    );
    await FirebaseAuth.instance.currentUser!.updateDisplayName(full_name.text);
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(profilePicture);

   await userRepo.setUser(user: user, isCompleted: (){
     Navigator.push(context, PageRouteBuilder(pageBuilder: (context,_,__)=>MainApp()));
     ;isLoading = false;});
  }

  fetchUser()async{
      //
      User user = await userRepo.getOneUser(
        email:FirebaseAuth.instance.currentUser?.email??"",
          isCompleted: (){},
         );
      full_name.text = user.full_name;
      country.text = user.country;
      state.text = user.state;
      city.text = user.city;

      phone_number.text = user.phone_number;
      email.text = user.email;

      home_address.text = user.home_address;
      profilePicture = user.profile_picture_url;
      // defaultColorIndex = user.default_color_key;

      notifyListeners();
  }


   pickProfilePicture(BuildContext context,{required ImageSource source}) async{
   //  isLoading =true;
   //  notifyListeners();
   //  XFile?  xFile = await ImagePicker.platform.getImageFromSource(source: source);
   // if(xFile!.path.isNotEmpty){
   //   // File file = File(xFile.path);
   //   Uint8List uint8list =await xFile.readAsBytes();
   //   uploadListOfImage(medias: [uint8list]
   //       ,
   //       afterOneUpload: (v){
   //     _profilePicture = v;
   //     notifyListeners();
   //       },
   //       afterTotalUpload: (){
   //
   //         // isLoading =false;
   //       notifyListeners();
   //
   //       },
   //       isFailed: (){showSnackBar(context, "failed to upload profile pix");
   //
   //       isLoading =false;
   //       notifyListeners();
   //
   //       });
   //   notifyListeners();
   //   isLoading =false;
   //

   // }


  }

  captureProfilePicture(BuildContext context, {required ImageSource source})async {

    // Obtain a list of the available cameras on the device.
    // final cameras = await availableCameras();
XFile? xFile = await ImagePicker.platform.getImageFromSource(source: source);
    // Get a specific camera from the list of available cameras.
    if(xFile == null){return; }

    uploadListOfImage(
    context
    ,medias: [File(xFile.path)]
        ,
        afterOneUpload: (v)async{
          _profilePicture = v;
          await FirebaseAuth.instance.currentUser!.updatePhotoURL(v);

          notifyListeners();
        },
        afterTotalUpload: (){

          // isLoading =false;
          notifyListeners();

        },
        isFailed: (){showSnackBar(context, "failed to upload profile pix");

        isLoading =false;
        notifyListeners();

        });
    notifyListeners();
    isLoading =false;



  }

  void selectBank(context)async {
   //  var data =await  showModalBottomSheet(context: context, builder: (contex){
   //  return SelectBankView();
   //
   //  });
   // bank_code = data["bank code"];
   // bank_name = data["bank name"];
   // notifyListeners();
  }

}