import 'package:flutter/material.dart';

class AppTheme {
  
  ThemeData get lightTheme => ThemeData(

      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.grey[50],
      brightness: Brightness.light,

      appBarTheme: AppBarTheme( brightness: Brightness.light, color: Colors.white ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.white),
      ),
      
      canvasColor: Colors.white,
      accentColor: Colors.grey,
      primaryColor: Colors.teal,
      primaryColorBrightness: Brightness.light,
      accentIconTheme: IconThemeData(color: Colors.black),
      fontFamily: 'MontserratAlternates',

      bottomNavigationBarTheme: BottomNavigationBarThemeData( backgroundColor: Colors.white )

      );


      //ThemeData(
      //   //visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),

  ThemeData get darkTheme => ThemeData(
        
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.grey[900],
      brightness: Brightness.dark,

      appBarTheme: AppBarTheme( brightness: Brightness.dark, color: Colors.grey[850] ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.white),
      ),
      
      canvasColor: Colors.grey[700],
      accentColor: Colors.tealAccent[700],
      primaryColor: Colors.teal,
      primaryColorBrightness: Brightness.dark,
      accentIconTheme: IconThemeData(color: Colors.white),
      fontFamily: 'MontserratAlternates',

      backgroundColor: Colors.green,
      dialogBackgroundColor: Colors.green,

      bottomNavigationBarTheme: BottomNavigationBarThemeData( backgroundColor: Colors.grey[850] )


      );

}