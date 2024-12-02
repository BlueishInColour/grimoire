import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:line_icons/line_icons.dart';

class NewsLetterWidget extends StatefulWidget {
  const NewsLetterWidget({super.key});

  @override
  State<NewsLetterWidget> createState() => _NewsLetterWidgetState();
}

class _NewsLetterWidgetState extends State<NewsLetterWidget> {
  @override
  Widget build(BuildContext context) {
    return
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(30)
          ),
          child:
          Row(
            children: [
              Icon(Icons.wifi,
              color: colorBlue,
              size: 10,
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Text("Go and be your best",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.montserrat(
                  color: colorBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: 8,
                ),),
              ),
              TextButton.icon(
                  onPressed: ()async{
                    await EasyLauncher.url(url: "fb.com",
                    mode: Mode.externalApp);
                  },
                  label: Icon(Icons.arrow_outward_sharp,
                  size: 10,
                      color: colorPurple,),
                  icon: Text("view",
                    style: GoogleFonts.montserrat(
                      color: colorPurple,
                      fontWeight: FontWeight.w900,
                      fontSize: 8,
                    ),))
            ],
          ),
        );
  }
}
