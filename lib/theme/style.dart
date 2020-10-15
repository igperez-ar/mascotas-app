import 'package:flutter/material.dart';

class AppTheme {

  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.red,
    appBarTheme: AppBarTheme(
      color: Colors.red[300],
    ),
    primaryColorDark: Colors.red[100],
    accentTextTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.red[400],
        fontWeight: FontWeight.bold,
        fontSize: 15
      )
    ),
    bottomAppBarColor: Colors.white,
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[100],
    primaryIconTheme: IconThemeData(
      color: Colors.white
    ),
    iconTheme: IconThemeData(
      color: Colors.red[300]
    ),
    disabledColor: Colors.grey[300],
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.grey[800],
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.grey[700],
      ),
      headline3: TextStyle(
        fontSize: 16.0,
        color: Colors.grey[600],
      ),
      headline4: TextStyle(
        fontSize: 18,
        color: Colors.grey[800]
      ),
    ),
    accentColor: Colors.red,
    buttonColor: Colors.red[300]
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black38,
    primaryIconTheme: IconThemeData(
      color: Colors.white
    ),
    iconTheme: IconThemeData(
      color: Colors.redAccent
    ),
    primaryColorDark: Colors.red[700],
    accentTextTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.redAccent,
        fontWeight: FontWeight.bold,
        fontSize: 15
      )
    ),
    bottomAppBarColor: Colors.black12,
    disabledColor: Colors.grey,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.grey[400],
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.grey[300],
      ),
      headline3: TextStyle(
        fontSize: 16.0,
        color: Colors.grey[500],
      ),
      headline4: TextStyle(
        fontSize: 18,
        color: Colors.grey[300]
      ),
    ),
    accentColor: Colors.red,
    buttonColor: Colors.red[700]
  );

}