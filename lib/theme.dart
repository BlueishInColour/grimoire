import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black87
    ),
    canvasColor: Colors.grey[50],   //
    scaffoldBackgroundColor: Colors.grey[50],   //
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,

    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: UnderlineInputBorder(
        borderRadius: 
          BorderRadius.circular(3)
      )

      
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black),
            foregroundColor: WidgetStatePropertyAll(Colors.white70),
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            )
        )
    )
  // Define additional light theme properties here
);final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  primaryColor: Colors.grey[900],
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.white60,
    foregroundColor: Colors.black,

  ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white60
    ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.white),
      foregroundColor: WidgetStatePropertyAll(Colors.black),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      )
    )
  )
);