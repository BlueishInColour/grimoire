
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/auth/tf.dart';
import 'package:grimoire/main.dart';
import 'package:provider/provider.dart';

import '../CONSTANT.dart';
import '../commons/loadable.dart';
import 'auth_service.dart';
import 'controller/create_user_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with TickerProviderStateMixin{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool seePassword = false;
  bool isLoading = false;
  int selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Widget loginView() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          authTextField("email",
              validateEmai: true,
              emailController,keyboardType:
              TextInputType.emailAddress),

          SizedBox(height: 15),
          authTextField(
            "password",
            passwordController,
            obscureText: !seePassword,
            keyboardType: TextInputType.visiblePassword,
            suffix:
            IconButton(
              onPressed: () {
                setState(() {
                  seePassword = !seePassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: seePassword ? Colors.black : Colors.grey,
              ),
            ),),
          TextButton(onPressed: (){
            setState(() {
              selectedIndex =2;
            });
          }, child: Text("forgotten password?",
          style: GoogleFonts.montserrat(),
          )),
          TextButton(onPressed: (){
            setState(() {
              selectedIndex =1;
            });
          }, child: Text("sign up",
            style: GoogleFonts.montserrat(),
          ))

        ],
      );
    }

    Widget signupView() {
      return    Consumer<CreateUserController>(
        builder:(context,c,child)=> ListView(
          children: [
            Row(
              children: [
                CircleAvatar(radius: 45,
                  backgroundImage: NetworkImage(c.profilePicture),
                  child:IconButton.outlined(onPressed: ()async{await c.captureProfilePicture(context);}, icon: Icon(Icons.camera_alt_outlined)),

                ),
              ],
            ),
            authTextField("full name",
                c.full_name

            ),



            authTextField("email",
                validateEmai: true,

                emailController,keyboardType:
                TextInputType.emailAddress),

            authTextField(
              "phone number",
              c.phone_number,

            ),
            authTextField(
              "home address",
              c.home_address,

            ),
            authTextField(
              "city",
              c.city,
            ),
            authTextField(
              "state",
              c.state,
            ),
            authTextField(
              "country",
              c.country,

            ),
            SizedBox(height: 15),




            authTextField(
              "password",
              passwordController,
              obscureText: !seePassword,
              keyboardType: TextInputType.visiblePassword,
              suffix:
              IconButton(
                onPressed: () {
                  setState(() {
                    seePassword = !seePassword;
                  });
                },
                icon: Icon(
                  Icons.remove_red_eye,
                  color: seePassword ? Colors.black : Colors.grey,
                ),
              ),),
            authTextField(
              "confirm password",
              passwordController,
              obscureText: !seePassword,
              keyboardType: TextInputType.visiblePassword,
              suffix:
              IconButton(
                onPressed: () {
                  setState(() {
                    seePassword = !seePassword;
                  });
                },
                icon: Icon(
                  Icons.remove_red_eye,
                  color: seePassword ? Colors.black : Colors.grey,
                ),
              ),),

          ],
        ),
      );
    }

    Widget forgottenPasswordView() {
      return Column(
        children: [
          authTextField("email",
              validateEmai: true,

              emailController,keyboardType:
              TextInputType.emailAddress),

        ],
      );
    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
leading: selectedIndex!=0?BackButton(
  onPressed: (){
    setState(() {
      selectedIndex=0;
    });
  },
):null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            [
              loginView(),
              signupView(),
              forgottenPasswordView()
            ][selectedIndex],
            SizedBox(height: 100,),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.blue.shade600
                ),
                padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                minimumSize: WidgetStatePropertyAll(Size(400,50)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                textStyle:WidgetStatePropertyAll(
                    GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    )
                )
              ),

              onPressed: (){AuthService().signInWithGoogle(isSignedIn: (v){
              goto(context, MainApp());
            });},
            icon: CircleAvatar(child: Image.asset("assets/google2.png")),
            label: Text("continue with google"),)
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            backgroundColor: WidgetStatePropertyAll(APPCOLOR),
            foregroundColor: WidgetStatePropertyAll(Colors.white70),

        ),
          child:
          loadable(
            child: Text(
              selectedIndex==0?"login"
              :selectedIndex==1?"sign up":

              "send reset link",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w800
            ),),
          ),
          onPressed: ()async{
            if(!isLoading){
              try{
                setState(() {
                  isLoading = true;
                });
                final auth = AuthService();
                if(selectedIndex ==0) {
                  await auth.login(emailController.text, passwordController.text,context);
                } else if(selectedIndex ==1)await auth.signup(emailController.text, passwordController.text,context);
                else await auth.sendForgottenPasswordEmail(context,emailController.text);

              }catch( e){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("email or password is incorrect  $e")));
              }
            }setState(() {
              isLoading = false;
            });
          },
        ),
      ),
    );
  }}

final listOfTabs = ["login","sign up", "forgotten password"];