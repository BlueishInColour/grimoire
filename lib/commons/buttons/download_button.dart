import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path/path.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../views/not_for_web.dart';


class DownloadButton extends StatefulWidget {
  const DownloadButton({super.key,required this.bookUrl,this. color = Colors.white,required this.title});

  final String bookUrl;
  final String title;
  final Color color;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  Stream<bool>isFileDownloaded()async*{
    String fileName =widget.title+".pdf";

    String path =await getFilePath(fileName);
    debugPrint(path+"/"+fileName);
    bool result =await File(path+fileName).exists();

    print("file existance status is $result");
    yield result;

  }
  Future<String> getFilePath(String filename) async {

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    return  appDocPath;//join(appDocPath, filename);

  }
  downloadFile()async{

    String fileName =widget.title+".pdf";


String path  = await getFilePath(fileName);
    debugPrint(path);

    final taskId = await FlutterDownloader.enqueue(
      url: widget.bookUrl,
      savedDir: await getFilePath(widget.title),
      timeout: 30000,
      fileName: fileName, // Optional: define a filename
      showNotification: true, // Optional: show a notification with progress
      openFileFromNotification: true, // Optional: open the file when tapped

      saveInPublicStorage: true
    );

await    FlutterDownloader.retry(taskId: taskId ??"");
  }

  @override
  Widget build(BuildContext context) {
    return
      widget.bookUrl.isEmpty?SizedBox.shrink():
      notForWeb(
        child: StreamBuilder<bool>(
          stream: isFileDownloaded(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircleAvatar(
                backgroundColor: Colors.black,
                child: CircularProgressIndicator(color: Colors.white70,),
              );
            }
            else if(snapshot.data == true) {
                  return IconButton.filled(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.black)),
                      onPressed: () {
                      },
                      icon: Icon(Icons.download_done_outlined,
                          color: widget.color));
                }
        
            else if(snapshot.data == false){
              return IconButton.filled(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black)),
                  onPressed: () {
                    downloadFile();
                  },
                  icon: Icon(Icons.file_download_outlined,
                      color: widget.color));
            }
            else return Icon(Icons.error,color: Colors.black54,);
              }
        ),
      );
  }
}
