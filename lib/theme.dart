import 'package:flutter/material.dart';

class AppTheme {
  
  ThemeData get lightTheme => ThemeData(

      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.grey[50],
      brightness: Brightness.light,
      sliderTheme: SliderThemeData(trackHeight: 5, activeTrackColor: Colors.white.withOpacity(.9), inactiveTrackColor: Colors.white10, thumbColor: Colors.grey[50] ),

      appBarTheme: AppBarTheme( brightness: Brightness.light, color: Colors.grey[50], elevation: 0 ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.white),
      ),
      
      canvasColor: Colors.white,
      accentColor: Colors.tealAccent[700],
      primaryColor: Colors.teal[600],
      primaryColorBrightness: Brightness.light,
      accentIconTheme: IconThemeData(color: Colors.black),
      fontFamily: 'MontserratAlternates',

      bottomNavigationBarTheme: BottomNavigationBarThemeData( 
        backgroundColor: Colors.grey[50], selectedItemColor: Colors.teal[700], unselectedItemColor: Colors.grey[800],
        type: BottomNavigationBarType.fixed ),
      // pageTransitionsTheme: PageTransitionsTheme(builders: )
      );


      //ThemeData(
      //   //visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),

  ThemeData get darkTheme => ThemeData(

      
        
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: BonovaColors.azulNoche[800],
      brightness: Brightness.dark,
      sliderTheme: SliderThemeData(trackHeight: 5, activeTrackColor: Colors.white.withOpacity(.9), inactiveTrackColor: Colors.white10, thumbColor: Colors.grey[50] ),

      appBarTheme: AppBarTheme( brightness: Brightness.dark, color: BonovaColors.azulNoche[800], elevation: 0 ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.white),
      ),
      
      canvasColor: Colors.grey[700],
      accentColor: Colors.teal[400],
      primaryColor: Colors.teal,
      primaryColorBrightness: Brightness.dark,
      accentIconTheme: IconThemeData(color: Colors.white),
      fontFamily: 'MontserratAlternates',

      backgroundColor: Colors.green,
      dialogBackgroundColor: Colors.green,
      bottomNavigationBarTheme: BottomNavigationBarThemeData( unselectedItemColor: Colors.teal[50], selectedItemColor: Colors.tealAccent,
        backgroundColor: BonovaColors.azulNoche[800], type: BottomNavigationBarType.fixed )


      );
}

  
class BonovaColors {
  BonovaColors._(); // this basically makes it so you can instantiate this class
 
 static const _azulNoche = 0xFF081C4D;

  static const MaterialColor azulNoche = const MaterialColor(
    _azulNoche,
    const <int, Color>{
      50:  const Color(0xFF2E4499),
      100: const Color(0xFF162970),
      200: const Color(0xFF0C2866),
      300: const Color(0xFF09225C),
      400: const Color(0xFF071E54),
      500: const Color(_azulNoche),
      600: const Color(0xFF091638),
      700: const Color(0xFF091129),
      750: const Color(0xFF080F24),
      800: const Color(0xFF070C1A),
      900: const Color(0xFF04060D),
    },
  );
}