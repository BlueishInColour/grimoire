import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/constant/CONSTANT.dart';

final ThemeData lightTheme = ThemeData(
  colorSchemeSeed: Colors.black,
  brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      // foregroundColor: Colors.black87,
     titleTextStyle: GoogleFonts.montserrat(
         fontWeight: FontWeight.w700,
         fontSize: 15,color: Colors.black),
    ),
    scaffoldBackgroundColor: Colors.white,   //
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,

    ),
    inputDecorationTheme: InputDecorationTheme(



      labelStyle: GoogleFonts.montserrat(
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
        textStyle: WidgetStatePropertyAll(GoogleFonts.montserrat(
          fontWeight: FontWeight.w900
        ))
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black),
            foregroundColor: WidgetStatePropertyAll(Colors.white70),
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


    labelStyle: GoogleFonts.montserrat(
        fontWeight: FontWeight.w900,
        fontSize: 13,
      color: colorRed,

    ),
    unselectedLabelStyle: GoogleFonts.montserrat(
        fontWeight: FontWeight.w700,
        fontSize: 11
    ),

    labelColor:Colors.black,
    // tabAlignment: TabAlignment.center,

    unselectedLabelColor:Colors.black54,
    indicatorSize: TabBarIndicatorSize.label,
    indicatorColor:Colors.black,
    dividerColor: Colors.transparent,

  ),
  bottomSheetTheme: BottomSheetThemeData(
    dragHandleColor: Colors.white60,
    backgroundColor: Colors.black,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    showDragHandle: true

  ),
  searchBarTheme: SearchBarThemeData(
    textStyle: WidgetStatePropertyAll((GoogleFonts.montserrat(
        fontSize: 12,
        color: Colors.black87
    )),),

    elevation: WidgetStatePropertyAll(0),
    backgroundColor: WidgetStatePropertyAll(Colors.grey.shade200),
    hintStyle: WidgetStatePropertyAll(GoogleFonts.montserrat(
        fontSize: 12,
        color: Colors.black45
    )),
  )
  // Define additional light theme properties here
);