import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {

  ThemeMode _themeData;

  ThemeChanger( this._themeData );

  ThemeMode getTheme() => _themeData;

  ThemeMode setTheme( ThemeMode theme ) {
    this._themeData = theme;
    notifyListeners();
  }


}