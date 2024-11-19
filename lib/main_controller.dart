import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';
import 'package:grimoire/commons/adapters/screen_adapter.dart';
import 'package:grimoire/commons/views/load_widget.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/read/pdf_viewer_screen.dart';
import 'package:grimoire/read/story_viewer.dart';
import 'package:grimoire/publish/write_edit_screen.dart';
import 'package:grimoire/models/story_model.dart';
import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:playx_version_update/playx_version_update.dart';
// import 'package:playx_version_update/playx_version_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'models/history_model.dart';

class MainController extends ChangeNotifier {
  MainController(){
    // fetchInitialTheme();
// baseDirectory();
  }

  int _openHomeCount = 0;
  int get openHomeCount => _openHomeCount;
  set openHomeCount(v){_openHomeCount = v;notifyListeners();}

bool _isLoading = false;
bool get  isLoading => _isLoading;
 changeLoading(context,v){_isLoading = v;isLoading ==true?showLoadingDialog(context):Navigator.pop(context);notifyListeners();}


  showLoadingDialog(context){
  if(isLoading==true){
    showAdaptiveDialog(context: context,
        barrierDismissible: false,

        builder: (context){
      return Center(child:Container(
        height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)

          ),

          child: loadWidget(color: Colors.white),
      ),);
    });
  }
  }
//
//  int _fetchAppCount = 0;
//  int get fetchAppCount => _fetchAppCount;
//  set fetchAppCount(v){_fetchAppCount = v;notifyListeners();}
//
// ThemeMode? _themeMode = ThemeMode.light;
// get getTheme => _themeMode;
// void toggleThemeMode(BuildContext context) async {
//   _themeMode =
//   _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
//
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setBool("isDarkMode", _themeMode == ThemeMode.dark);
//   showSnackBar(context, "restart app to see difference");
//   notifyListeners();
// }
// void fetchInitialTheme() async {
//   final prefs = await SharedPreferences.getInstance();
//   bool? isDarkMode = prefs.getBool("isDarkMode");
//   if (isDarkMode != null) {
//     _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//   }
// }
//
//  bool _isFirstTimeOpeningApp = true;
//

  showSnackBar(BuildContext context, String text, {Widget? icon}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          icon ?? SizedBox(),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(color: Colors.white60),
          ),
        ],
      ),
    ));
  }

//   pay(
//     BuildContext context, {
//     required String amount,
//     required Function onCompleted,
//     required Function onFailed,
//   }) async {
//     debugPrint("pay clicked");
//     // await FlutterPaystackPlus.openPaystackPopup(
//     //   publicKey: 'pk_test_2a7a88331084877496188297b88308c87bbac72f',
//     //   customerEmail: 'blueishincolour@gmail.com',
//     //   context: context,
//     //   secretKey: 'sk_test_7a8a2d163130f13b6f7fef55fd18a88849a0c79f',
//     //   amount: amount,
//     //   reference: DateTime.now().millisecondsSinceEpoch.toString(),
//     //   callBackUrl: "https://dressr.web.app",
//     //   onClosed: () {
//     //     debugPrint('Could\'nt finish payment');
//     //     showSnackBar(context, "payment failed");
//     //     onFailed();
//     //   },
//     //   onSuccess: () async {
//     //     onCompleted();
//     //
//     //   },
//     //   currency: "NGN",
//     // );
//   }
//
//   withdrawl(
//     BuildContext context, {
//     required String amount,
//     required Function onCompleted,
//     required Function onFailed,
//   }) async {
//     var url = "https://api.paystack.co/transfer";
//
//     String key = "sk_test_7a8a2d163130f13b6f7fef55fd18a88849a0c79f";
//
//     var data = {
//       "source": "balance",
//     "amount": "37800",
//     "reference": Uuid().v1(),
//     "recipient": "CUS_jibqp990v79ezb1",
//     "reason": "withdraw from return from investment"
//     };
//     Map<String, String>? headers = {
//       "content_type": "application/json",
//       "authorization":"Bearer $key"
//     };
//
//
//     var res = await http.post(Uri.parse(url), headers: headers, body: data);
//     if (res.statusCode == 200) {
//       onCompleted();
//     } else {
//       onFailed();
//
//       throw Exception('http.post error: statusCode= ${res.statusCode}, ${res.body}');
//     }
//     print(res.body);
//   }
//
//   uploadListOfImage({
//     required List<File> medias ,
//     required Function(String) afterOneUpload,
//     required Function afterTotalUpload,
//     required Function isFailed
// })async{
//   isLoading =true;
//     final storageRef = FirebaseStorage.instance.ref();
//     for (var media in medias) {
//       try {
//
//         var mediaName = Uuid().v1();
//         final mediaRef = storageRef.child("medias/$mediaName");
//         await mediaRef.putFile(media);
//         String downloadUrl = await mediaRef.getDownloadURL();
//         afterOneUpload(downloadUrl);
//         debugPrint("not done with all");
//
//     } catch ( e) {
//     isFailed();
//
//     }
//       debugPrint("done with all");
//
//     }
// debugPrint("done with all");
//   isLoading =false;
//
//   afterTotalUpload();
//
//
//
//   }
//
// //   curl -X POST \
// //   https://fcm.googleapis.com/v1/projects/<PROJECT_ID>/messages:send \
// //   -H 'Authorization: Bearer <SERVER_API_KEY>' \
// //   -H 'Content-Type: application/json' \
// //   -d '{
// //   "to": "/topics/all",
// //   "data": {
// //   "title": "Hello, World!",
// //   "message": "This is a test message"
// //   }
// // }'

// requestPermissions(Function() getBooks)async{
// //
//
//   PermissionStatus permissionStatus = await Permission.storage.request();
//   if (permissionStatus.isGranted) {
// }
//   }
  Future<void> baseDirectory(Function(String) getBooks) async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    if (androidDeviceInfo.version.sdkInt <= 32) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      if (permissionStatus.isGranted) {
        var rootDirectory = await ExternalPath.getExternalStorageDirectories();
        var appDirectory = await getApplicationDocumentsDirectory();
        await getBooks(rootDirectory.first);
        await getBooks(appDirectory.path);
      }
    } else {
      PermissionStatus permissionStatus =
      await Permission.manageExternalStorage.request();
      if (permissionStatus.isGranted) {
        var rootDirectory = await ExternalPath.getExternalStorageDirectories();
        await getBooks(rootDirectory.first);
      }
    }
//       // share offline permission
//       FlutterP2pConnection().checkStoragePermission();
//
// // request storage permission
//       FlutterP2pConnection().askStoragePermission();
//
// // check if location permission is granted
//       FlutterP2pConnection().checkLocationPermission();
//
// // request location permission
//       FlutterP2pConnection().askLocationPermission();
//
// // check if location is enabled
//       FlutterP2pConnection().checkLocationEnabled();
//
// // enable location
//       FlutterP2pConnection().enableLocationServices();
//
// // check if wifi is enabled
//       FlutterP2pConnection().checkWifiEnabled();
//
// // enable wifi
//       FlutterP2pConnection().enableWifiServices();
//     }}
  }
      Future<void> getFiles(String directoryPath, String extension,
          Function(String) onGet) async {
        try {
          Directory appDocDir = await getApplicationDocumentsDirectory();

          var rootDirectory = Directory(directoryPath);
          var directories = rootDirectory.list(recursive: false);
          directories.forEach((element) {
            if (element is File) {
              if (element.path
                  .split(".")
                  .last == extension) {
                // debugPrint("PDF File Name : ${element.path.split("/").last}");
                onGet(element.path);
              }
            } else {
              getFiles(element.path, extension, (v) => onGet(v));
            }
          });
        } catch (e) {
          debugPrint(e.toString());
        }
      }


  ///change light or dark mode


 ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isLightMode => themeMode != ThemeMode.dark;
  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }



  uploadListOfImage(context,
      {
        required List<File> medias ,
        required Function(String) afterOneUpload,
        required Function afterTotalUpload,
        required Function isFailed
      })async{
    changeLoading(context, true);
    final storageRef = FirebaseStorage.instance.ref();
    for (var media in medias) {
      try {

        var mediaName = Uuid().v1();
        final mediaRef = storageRef.child("medias/$mediaName");
        await mediaRef.putFile(media);
        String downloadUrl = await mediaRef.getDownloadURL();
        afterOneUpload(downloadUrl);
        debugPrint("not done with all");

      } catch ( e) {
        isFailed();

      }
      debugPrint("done with all");

    }
    debugPrint("done with all");
    changeLoading(context, false);

    afterTotalUpload();



  }

  uploadListOfMemoryImage(context,
      {
        required List<MemoryImage> medias ,
        required Function(String) afterOneUpload,
        required Function afterTotalUpload,
        required Function isFailed
      })async{
    changeLoading(context, true);
    final storageRef = FirebaseStorage.instance.ref();
    for (var media in medias) {
      try {

        var mediaName = Uuid().v1();
        final mediaRef = storageRef.child("medias/$mediaName");
        await mediaRef.putData(media.bytes);
        String downloadUrl = await mediaRef.getDownloadURL();
        afterOneUpload(downloadUrl);
        debugPrint("not done with all");

      } catch ( e) {
        isFailed();

      }
      debugPrint("done with all");

    }
    debugPrint("done with all");
    changeLoading(context, false);

    afterTotalUpload();



  }

  updateApp(context)async{
    if(kIsWeb){return ;}
    else{
      final result = await PlayxVersionUpdate.showInAppUpdateDialog(
        context: context,
        //Type for google play in app update either flexible or immediate update.
        type: PlayxAppUpdateType.flexible,
        //customize app store id in ios
        appStoreId: 'com.blueishincolour.grimoire',
        //show release notes or not in ios
        showReleaseNotes: true,
        //customize dialog layout like release notes title  in ios.
        releaseNotesTitle: (info) => 'Recent Updates of ${info.newVersion}',
        // When the user clicks on update action the app open the app store,
        // If you want to override this behavior you can call [onIosUpdate].
        onIosUpdate: (info, launchMode) async {
          final storeUrl = info.storeUrl;
          final res = await PlayxVersionUpdate.openStore(storeUrl: storeUrl);
          res.when(success: (success) {
            print('playx_open_store: success :$success');
          }, error: (error) {
            print('playx_open_store: error :$error');
          });
        },
      );
      result.when(success: (isShowed) {
        print(' showInAppUpdateDialog success : $isShowed');
      }, error: (error) {
        print(' showInAppUpdateDialog error : $error ${error.message}');
      });
    }
  }
//firstimers
Future<bool?> isFirstTime()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("isFirstTime");

}
updateFirstTime()async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool("isFirstTime", false);

}

Future<List<String>> _listOfLikes()async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getStringList("listOfLikes") ?? [];

}

 Future<List<String>> get listOfLikes=>_listOfLikes();
  addListToListOfLikes(v) async {
    SharedPreferences pref =  await SharedPreferences.getInstance();
    pref.setStringList("listOfLikes",v);
    notifyListeners();
  }

  addToListOfLikes(String v)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var list = await listOfLikes;
     list.add(v);
    pref.setStringList("listOfLikes", list);
    notifyListeners();
  }
  removeFromListOfLikes(String v)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var list = await listOfLikes;
    list.remove(v);
    pref.setStringList("listOfLikes", list);
    notifyListeners();


  }

  late TabController _tabController ;
  TabController get tabController =>_tabController;
  set tabController(v){_tabController =v;notifyListeners();}

  int _tabIndex = 4;
  int get tabIndex => _tabIndex;
  set tabIndex(v){_tabIndex=0;notifyListeners();}

  //currentsubGenre
  String _currentGenre = "Fiction";
  String get currentGenre =>_currentGenre;
  set currentGenre(v){_currentGenre =v;currentsubGenre="All";notifyListeners();}

  String _currentsubGenre = "All";
  String get currentsubGenre =>_currentsubGenre;
  set currentsubGenre(v){_currentsubGenre =v;notifyListeners();}


}


