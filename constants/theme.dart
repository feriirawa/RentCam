import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.green,
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          foregroundColor: Colors.green,
          textStyle: TextStyle(
            color: Colors.green,
          ),
          side: BorderSide(color: Color.fromARGB(255, 0, 146, 5), width: 1.9),
          disabledForegroundColor: Colors.green.withOpacity(0.38))),
  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    focusedBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 0, 160, 5),
      textStyle: TextStyle(
        fontSize: 18,
      ),
      foregroundColor: Colors.white,
    ),
  ),
  primarySwatch: Colors.green,
  canvasColor: Color.fromARGB(255, 0, 160, 5),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    toolbarTextStyle: TextStyle(
      color: Colors.black
    ),
    iconTheme: IconThemeData(color: Colors.black)
  )
);

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);
