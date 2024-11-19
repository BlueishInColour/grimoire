import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/constant/CONSTANT.dart';

final ThemeData lightTheme = ThemeData(
  colorSchemeSeed: Colors.black,
  brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      // foregroundColor: Colors.black87,
     titleTextStyle: GoogleFonts.merriweather(fontSize: 15,color: Colors.black),
    ),
    scaffoldBackgroundColor: Colors.white,   //
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,

    ),
    inputDecorationTheme: InputDecorationTheme(

      labelStyle: GoogleFonts.merriweather(
          color: Colors.black54,
          fontSize: 13
      ),
      filled: true,

      fillColor: Colors.grey[200],
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,


    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(GoogleFonts.merriweather(
          fontWeight: FontWeight.w900
        ))
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black),
            foregroundColor: WidgetStatePropertyAll(Colors.white70),
            minimumSize: WidgetStatePropertyAll(Size(100,50)),
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                )
            )
        )
    ),
  tabBarTheme: TabBarTheme(
    // isScrollable: true,
    tabAlignment: TabAlignment.start,

    labelStyle: GoogleFonts.merriweather(
        fontWeight: FontWeight.w900,
        fontSize: 15
    ),
    unselectedLabelStyle: GoogleFonts.merriweather(
        fontWeight: FontWeight.w700,
        fontSize: 13
    ),

    labelColor:Colors.black,
    // tabAlignment: TabAlignment.center,

    unselectedLabelColor:Colors.black54,
    indicatorSize: TabBarIndicatorSize.label,
    indicatorColor:Colors.black,
    dividerColor: Colors.transparent,

  ),
  bottomSheetTheme: BottomSheetThemeData(
    dragHandleColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    showDragHandle: true

  ),
  // Define additional light theme properties here
);