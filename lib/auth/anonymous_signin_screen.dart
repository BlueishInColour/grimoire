import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../commons/views/load_widget.dart';
import 'auth_service.dart';


class AnonymousSigninScreen extends StatefulWidget {
  const AnonymousSigninScreen({super.key});

  @override
  State<AnonymousSigninScreen> createState() => _AnonymousSigninScreenState();
}

class _AnonymousSigninScreenState extends State<AnonymousSigninScreen> {
  signInGuest()async
  {
    await
    AuthService().guest(context);

  }  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signInGuest();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(
                  "assets/icon.jpeg"
              ),
            ),
            SizedBox(height: 15,),
            Text("signing in anonymously",
            style: GoogleFonts.merriweather(
              fontWeight: FontWeight.w900,
              fontSize: 12
            ),),
            SizedBox(height: 5,),

            SizedBox.square(dimension: 15,
                child: loadWidget()
            )
          ],
        ),
      ),
    );
  }
}
