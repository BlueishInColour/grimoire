
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/privacy-policy.dart';
import 'package:grimoire/auth/tf.dart';
import 'package:grimoire/commons/views/bottom.dart';
import 'package:grimoire/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../read/markdown_screen.dart';
import '../constant/CONSTANT.dart';
import '../commons/views/loadable.dart';
import 'auth_service.dart';
import 'controller/create_user_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget loginView() {
    return Consumer<CreateUserController>(
      builder: (context,c,child)=> Column(

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
          Row(
            children: [
              TextButton(onPressed: () {
                setState(() {
                  selectedIndex = 1;
                });
              }, child: Text("Sign Up",
                style: GoogleFonts.merriweather(
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    color: Colors.black
                ),
              )),
            ],
          ),
          Row(
            children: [
              TextButton(onPressed: () {
                setState(() {
                  selectedIndex = 2;
                });
              }, child: Text("Forgotten Password?",
                style: GoogleFonts.merriweather(
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    color: Colors.black
                ),
              )),
            ],
          ),


        ],
      ),
    );
  }

  Widget signUpView() {
    return Consumer<CreateUserController>(
      builder: (context,c,child)=> Column(

        children: [
          authTextField("Full Name",c.full_name),

          SizedBox(height: 10),
          authTextField("Pen Name (Username)",c.pen_name),

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
          Row(
            children: [
              TextButton(onPressed: () {
                setState(() {
                  selectedIndex=0;
                });
              }, child: Text("Login",
                style: GoogleFonts.merriweather(
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    color: Colors.black
                ),
              )),
            ],
          ),
          Row(
            children: [
              TextButton(onPressed: () {
                setState(() {
                  selectedIndex = 2;
                });
              }, child: Text("Forgotten Password?",
                style: GoogleFonts.merriweather(
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    color: Colors.black
                ),
              )),
            ],
          ),


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
            Row(
              children: [
                TextButton(onPressed: () {
                  setState(() {
                    selectedIndex=0;
                  });
                }, child: Text("Login",
                  style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      color: Colors.black
                  ),
                )),
              ],
            ),
            Row(
              children: [
                TextButton(onPressed: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                }, child: Text("You don't have an account? Sign Up",
                  style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      color: Colors.black
                  ),
                )),
              ],
            ),

          ],
        ),
      );}
Widget build(BuildContext context){

      return Consumer<CreateUserController>(
        builder:(context,c,child)=> Container(
          decoration: BoxDecoration(

            gradient: SweepGradient(

                colors: [
              Colors.purple.shade100,
              Colors.blue.shade100,
              Colors.red.shade100,
              Colors.green.shade100,
            ])
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,

            body: ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Container(
                      // height: 450,
                        width: 400,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [
                          [
                            loginView(),
                            signUpView(),
                            forgottenPasswordView()
                          ][selectedIndex],
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [

                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap:  () async {
                                    if (!isLoading) {
                                      try {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        final auth = AuthService();
                                        if (selectedIndex == 0) {
                                          await auth.login(
                                              c.email.text, c.password.text,
                                              context);
                                        }
                                        else if(selectedIndex ==1){
                                          await AuthService().signup(
                                              c.email.text, c.password.text,
                                              context).whenComplete((){
                                            c.createUser(context);
                                          });;
                                        }
                                        else
                                          await auth.sendForgottenPasswordEmail(
                                              context, c.email.text);
                                      } catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text(
                                                "email or password is incorrect  $e")));
                                      }
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  child: BottomBar(child:(fontSize,iconSize)=> Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Text(
                                  selectedIndex == 0 ? "Login"
                                  :selectedIndex==1?"Sign up":

                                    "Send Reset Link",
                                    style: GoogleFonts.merriweather(
                                        fontWeight: FontWeight.w800,
                                      color: Colors.white70,
                                      fontSize: fontSize
                                    ),),

                                    ],
                                  )),
                                ),

                                SizedBox(height: 10,),
                                Text.rich(TextSpan(
                                    style: GoogleFonts.merriweather(
                                      fontSize: 12,
                                    ),
                                    children: [
                                      TextSpan(text: "By continuing, you agree to our"),
                                      TextSpan(text: " Privacy Policy",
                                          style: GoogleFonts.merriweather(color: Colors.purple),
                                          onEnter: (v) {
                                            goto(context,

                                                MarkdownScreen(data: privacyPolicy));
                                          }
                                      ),
                                      TextSpan(text: " and"),
                                      TextSpan(text: " Terms of Use",
                                          style: GoogleFonts.merriweather(color: Colors.purple),
                                          onEnter: (v) {
                                            goto(context,
                                                MarkdownScreen(data: privacyPolicy));
                                          }
                                      ),
                                    ]
                                )),
                              ],
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      );
    }
  }

// import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key,this.editing = false});
final bool editing;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool seePassword = false;
  bool isLoading = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Consumer<CreateUserController>(
      builder:(context,c,child)=> Scaffold(
        appBar:AppBar(),
        body: Center(
          child: SizedBox(
            width: 500,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: ListView(
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: 45,
                        backgroundImage: NetworkImage(c.profilePicture),

                      ),
                      SizedBox(width: 20,),
                      IconButton(onPressed: ()async{await c.captureProfilePicture(context, source: ImageSource.camera);},
                          icon: Icon(Icons.camera_alt_outlined)),


                      IconButton(onPressed: ()async{await c.captureProfilePicture(context, source: ImageSource.gallery);},
                          icon: Icon(Icons.image_outlined)),
                    ],
                  ),
                  authTextField("full name",
                      c.full_name

                  ),



                  authTextField("email",
                      validateEmai: true,


                      c.email,keyboardType:
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
                    "state/Province",
                    c.state,
                  ),
                  authTextField(
                    "country",
                    c.country,

                  ),
                  SizedBox(height: 15),




               widget.editing?SizedBox.shrink():   authTextField(
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
                  widget.editing?SizedBox.shrink():      authTextField(
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
                  SizedBox(height: 10,),
                  ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(400,50))
                      ),
                      onPressed: ()async{
                    widget.editing?  c.createUser(context):

                    await AuthService().signup(
                        c.email.text, c.password.text,
                        context).whenComplete((){
                      Provider.of<CreateUserController>(context,listen:false).createUser(context);
                    });;
                  }, child: Text(widget.editing?"Update":"Sign Up",style: GoogleFonts.merriweather(
                    color: Colors.white,
                    fontWeight: FontWeight.w800
                  ),)),

                ],
              ),
            ),
          ),
        ),

      ),
    );

  }
}
