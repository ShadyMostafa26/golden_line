import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xff404E5A),
    accentColor: Color(0xffff5405),
    backgroundColor: Color(0xff4E5D6A),
    dividerColor: Color(0xffff5405),
    scaffoldBackgroundColor: Color(0xff404E5A),
    bottomAppBarColor: Color(0xff404E5A),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color(0xff404E5A),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff404E5A),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 25,
    ),
    appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Color(0xff404E5A),
          ),
        ),
        color: Color(0xff404E5A),
        actionsIconTheme: IconThemeData(color: Color(0xff404E5A))));

ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Color(0xfff5f5f5),
    accentColor: Color(0xffff5405),
    dividerColor: Color(0xffff5405),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 25,
    ),
    // scaffoldBackgroundColor: Color(0xff404E5A),.
    backgroundColor: Color(0xfff5f5f5),
    scaffoldBackgroundColor: Color(0xfff5f5f5),
    appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Color(0xff404E5A),
            fontSize: 20,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        color: Color(0xfff5f5f5),
        actionsIconTheme: IconThemeData(color: Color(0xff404E5A))),
    primaryTextTheme: TextTheme(
      headline1: TextStyle(color: Colors.blue),
    ));
