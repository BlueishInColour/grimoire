import 'package:flutter/material.dart';
import 'package:path/path.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DownloadButton extends StatefulWidget {
  const DownloadButton({super.key,required this.bookUrl,required this.title});

  final String bookUrl;
  final String title;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  downloadFile()async{
//
//     String fileName =widget.title+".pdf";
//
//     Future<String> getFilePath(String filename) async {
//
//       Directory appDocDir = await getApplicationDocumentsDirectory();
//       String appDocPath = appDocDir.path;
//       return  appDocPath;//join(appDocPath, filename);
//
//     }
// String path  = await getFilePath(fileName);
//     debugPrint(path);
//
//     final taskId = await FlutterDownloader.enqueue(
//       url: widget.bookUrl,
//       savedDir: await getFilePath(widget.title),
//       fileName: fileName, // Optional: define a filename
//       showNotification: true, // Optional: show a notification with progress
//       openFileFromNotification: true, // Optional: open the file when tapped
//     );
  }

  @override
  Widget build(BuildContext context) {
    return
      widget.bookUrl.isEmpty?SizedBox.shrink():
      IconButton(
      onPressed:(){downloadFile();},
    icon:Icon(Icons.file_download_outlined,color:Colors.white)
    );
  }
}
