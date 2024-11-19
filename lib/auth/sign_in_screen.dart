
import 'package:blur/blur.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/privacy-policy.dart';
import 'package:grimoire/auth/tf.dart';
import 'package:grimoire/commons/views/bottom.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../read/markdown_screen.dart';
import '../constant/CONSTANT.dart';
import '../commons/views/loadable.dart';
import 'auth_service.dart';
import 'controller/create_user_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.child});
  final Widget child;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with TickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool seePassword = false;
  bool isLoading = false;
  int selectedIndex = 0;
  late TabController tabController;

  late AnimationController animatedController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    animatedController = AnimationController(vsync: this);

  }

  Widget loginView() {
    return Consumer<CreateUserController>(
      builder: (context,c,child)=> ListView(

        children: [
          authTextField("email",
              validateEmai: true,
              c.email, keyboardType:
              TextInputType.emailAddress),

          SizedBox(height: 15),
          authTextField(
            "password",
            c.password,
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
         forgottenPasswordButton(),
          SizedBox(height: 15,),
         agreementText(),


         ///
         GestureDetector(
             onTap: ()async{
               c.isLoading = true;
               try{
                 c.isLoading = true;
                 await AuthService().login(
                     c.email.text, c.password.text,
                     context, child: SizedBox());
               }catch(e){
                 showToast("Email or Password Is Incorrect");
               }
               c.isLoading = false;

             },

             child: BottomBar(

                 backgroundColor:c.isWriter? colorBlue:colorRed,
                 child:(fontSize,iconSize)=> Center(child: Text("Login",style
                 :GoogleFonts.montserrat(
                   fontWeight: FontWeight.w800,


                 ))))),
          SizedBox(height: 100,)


        ],
      ),
    );
  }

  Widget signUpView() {
    return Consumer<CreateUserController>(
      builder: (context,c,child)=> ListView(

        children: [
          authTextField("Full Name",c.full_name),

          SizedBox(height: 10),
          authTextField(c.isWriter?"Pen Name ":"Username",c.pen_name),

          SizedBox(height: 10),
          authTextField("Email",
              validateEmai: true,
              c.email, keyboardType:
              TextInputType.emailAddress),

          SizedBox(height: 10),
          authTextField(
            "password",
            c.password,
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
            ),),   SizedBox(height: 10),
          authTextField(
            "confirm password",
            c.confirm_password,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("I am a writer",
              style: GoogleFonts.montserrat(
                color: Colors.white70,
                fontWeight: FontWeight.w500
              ),),
              Switch(
                  activeColor: colorBlue,
                  inactiveTrackColor: Colors.red.shade400,
                  value: c.isWriter, onChanged: (v){
                c.isWriter = v;
              })
            ],
          ),
          forgottenPasswordButton(),
          SizedBox(height: 15,),
          agreementText(),

          GestureDetector(
              onTap: ()async{
                c.isLoading = true;
                try{
                  await AuthService().signup(
                      c.email.text, c.password.text,
                      context);
                await  c.createUser(context,widget.child);
                }catch(e){
                  showToast("Unable to sign you up at the moment.");
                }
                c.isLoading = false;

              },
              child: BottomBar(
                  backgroundColor:c.isWriter? colorBlue:colorRed,
                  child:(fontSize,iconSize)=> Center(child: Text("Sign Up",
                  style:GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800,


                  ))))),
          SizedBox(height: 100,)


        ],
      ),
    );
  }

    Widget forgottenPasswordView() {
      return Consumer<CreateUserController>(
        builder:(context,c,child)=> Column(
          children: [
            authTextField("email",
                validateEmai: true,

                emailController, keyboardType:
                TextInputType.emailAddress),
            SizedBox(height: 15,),
            GestureDetector(
                onTap: ()async{
                  c.isLoading = true;

                  await AuthService().sendForgottenPasswordEmail(
                      context, c.email.text);
                  c.isLoading = false;

                },
                child: BottomBar(
                    backgroundColor: colorRed,
                    child:(fontSize,iconSize)=> Center(child: Text("Send Reset Link",
                    style:GoogleFonts.montserrat(
                      fontWeight: FontWeight.w800
                    )))))


          ],
        ),
      );}
  Widget forgottenPasswordButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: (){
          tabController.animateTo(2);
        }, child: Text("Forgotten Password?",
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w700,
          color: Provider.of<CreateUserController>(context).isWriter? colorBlue:colorRed
        ),)),
      ],
    );
  }
  Widget agreementText(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text.rich(TextSpan(
          style: GoogleFonts.montserrat(
            fontSize: 12,
          ),
          children: [
            TextSpan(text: "By continuing, you agree to our",
            ),
            TextSpan(text: " Privacy Policy",
                style: GoogleFonts.montserrat(color: colorPurple,
                fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()..onTap=()=>
                       EasyLauncher.url(url: "https://grimoire.live/policy",mode: Mode.externalApp)
            ),
            TextSpan(text: " and"),
            TextSpan(text: " Terms of Use",
                style: GoogleFonts.montserrat(color: colorPurple,
                    fontWeight: FontWeight.w600),
    recognizer: TapGestureRecognizer()..onTap=()=>EasyLauncher.url(url: "https://grimoire.live/terms",mode: Mode.externalApp)
            ),
          ]
      ),
        style: GoogleFonts.montserrat(color: Colors.white70),

      ),
    );
  }
Widget build(BuildContext context){

      return Consumer<CreateUserController>(
        builder:(context,c,child)=> SafeArea(
          child: Scaffold(
              backgroundColor: Colors.black,
            body:Image(
              fit: BoxFit.fill,
              image: Svg("assets/image4.svg"),
              // image: Svg("assets/image2.svg"),
            ).blurred(
               blurColor: Colors.black12,

              overlay: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Welcome to Grimoire",
                      style: GoogleFonts.montserrat(
                          color: Colors.white70,
                          // fontSize: 30,
                          fontWeight: FontWeight.w900
                      ),),
                    SizedBox(height: 15,),
                    Text("Novels & More at 'ur Fingertip",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800
                      ),),
                  ],
                ),
              ),

            ),
            bottomSheet: BottomSheet(
              onClosing: (){},
              showDragHandle: true,
              enableDrag: true,
              animationController: animatedController,
              dragHandleColor: Colors.white,
              dragHandleSize: Size(300, 5),
              backgroundColor: Colors.black,
          
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              builder:(context)=> Container(
                height: MediaQuery.of(context).size.height-300,
                decoration: BoxDecoration(
                    color: Colors.black), child: Scaffold(
                backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    foregroundColor: Colors.white70,
                    centerTitle: true,
          
                    title: TabBar(
                      unselectedLabelColor: Colors.white,
                      labelColor: c.isWriter? colorBlue:colorRed,
                      indicatorColor: c.isWriter? colorBlue:colorRed,
                      isScrollable: false,
                        tabAlignment: TabAlignment.center,
          
                        controller: tabController,
                        tabs: [
                      Tab(text: "Login",),
                          Tab(text: "Sign Up",),
                          Tab(text: "",),
          
                    ]),
                  ),
                  body:
                   Center(
                        child: SizedBox(
                          width: 300,
                          child: TabBarView(
          
                            controller: tabController,
                            children:
                              [
                                loginView(),
                                signUpView(),
                                forgottenPasswordView()
                              ]),
                        ),
                      ),
                  ))
                      ),
                    ),
        ),

      );
    }
  }
//
// // import 'package:flutter/material.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key,this.editing = false});
// final bool editing;
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//
//   bool seePassword = false;
//   bool isLoading = false;
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return  Consumer<CreateUserController>(
//       builder:(context,c,child)=> Scaffold(
//         appBar:AppBar(),
//         bottomSheet: BottomSheet(
//           showDragHandle: true,
//
//           onClosing: (){},
//           builder:(context)=> Container(
//             decoration: BoxDecoration(
//               color: Colors.black
//             ),
//             width: 500,
//             height: MediaQuery.of(context).size.height-200,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 15),
//               child: ListView(
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(radius: 45,
//                         backgroundImage: NetworkImage(c.profilePicture),
//
//                       ),
//                       SizedBox(width: 20,),
//                       IconButton(onPressed: ()async{await c.captureProfilePicture(context, source: ImageSource.camera);},
//                           icon: Icon(Icons.camera_alt_outlined)),
//
//
//                       IconButton(onPressed: ()async{await c.captureProfilePicture(context, source: ImageSource.gallery);},
//                           icon: Icon(Icons.image_outlined)),
//                     ],
//                   ),
//                   authTextField("full name",
//                       c.full_name
//
//                   ),
//
//
//
//                   authTextField("email",
//                       validateEmai: true,
//
//
//                       c.email,keyboardType:
//                       TextInputType.emailAddress),
//
//                   authTextField(
//                     "phone number",
//                     c.phone_number,
//
//                   ),
//                   authTextField(
//                     "home address",
//                     c.home_address,
//
//                   ),
//                   authTextField(
//                     "city",
//                     c.city,
//                   ),
//                   authTextField(
//                     "state/Province",
//                     c.state,
//                   ),
//                   authTextField(
//                     "country",
//                     c.country,
//
//                   ),
//                   SizedBox(height: 15),
//
//
//
//
//                widget.editing?SizedBox.shrink():   authTextField(
//                     "password",
//                     c.password,
//                     obscureText: !seePassword,
//                     keyboardType: TextInputType.visiblePassword,
//                     suffix:
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           seePassword = !seePassword;
//                         });
//                       },
//                       icon: Icon(
//                         Icons.remove_red_eye,
//                         color: seePassword ? Colors.black : Colors.grey,
//                       ),
//                     ),),
//                   widget.editing?SizedBox.shrink():      authTextField(
//                     "confirm password",
//                     c.confirm_password,
//                     obscureText: !seePassword,
//                     keyboardType: TextInputType.visiblePassword,
//                     suffix:
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           seePassword = !seePassword;
//                         });
//                       },
//                       icon: Icon(
//                         Icons.remove_red_eye,
//                         color: seePassword ? Colors.black : Colors.grey,
//                       ),
//                     ),),
//                   SizedBox(height: 10,),
//                   ElevatedButton(
//                       style: ButtonStyle(
//                         minimumSize: WidgetStatePropertyAll(Size(400,50))
//                       ),
//                       onPressed: ()async{
//                     widget.editing?  c.createUser(context):
//
//                     await AuthService().signup(
//                         c.email.text, c.password.text,
//                         context).whenComplete((){
//                       Provider.of<CreateUserController>(context,listen:false).createUser(context);
//                     });;
//                   }, child: Text(widget.editing?"Update":"Sign Up",style: GoogleFonts.merriweather(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w800
//                   ),)),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//       ),
//
//     );
//
//   }
// }
