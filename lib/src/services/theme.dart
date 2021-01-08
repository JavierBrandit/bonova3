import 'package:flutter/material.dart';
import 'package:bonova0002/src/services/prefs.dart';


class ThemeChanger with ChangeNotifier {

  final prefs = new PreferenciasUsuario();

  ThemeMode _themeData;

  ThemeChanger( this._themeData );

  ThemeMode getTheme() => _themeData;

  ThemeMode setTheme( ThemeMode theme ) {
    this._themeData = theme;
    var isDarkTheme = theme == ThemeMode.dark;
    prefs.colorSecundario = isDarkTheme;
    print(prefs.colorSecundario);
    notifyListeners();
  }


}