import 'package:flutter/material.dart';

final ThemeData AppTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xff4F4F4F),
  accentColor: Color(0xff4F4F4F),
  // canvasColor: Colors.transparent,
  fontFamily: 'Roboto',

  textTheme: TextTheme(
    headline1: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
    headline6: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(
        fontSize: 14.0, fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
  ),

  scaffoldBackgroundColor: Color(0xFF1E1E1E),
  appBarTheme: AppBarTheme(
    color: Color(0xFF1E1E1E),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.black,
    onPrimary: Colors.black,
    primaryVariant: Colors.black,
    secondary: Colors.red,
  ),
  cardTheme: CardTheme(
    color: Colors.black,
  ),
  iconTheme: IconThemeData(
    color: Colors.white54,
  ),

  // bottomSheetTheme: BottomSheetThemeData(
  //     backgroundColor: Colors.transparent,
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(10)))),
);
