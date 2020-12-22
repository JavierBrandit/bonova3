// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'src/services/theme.dart';



// class SettingScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _SettingState();
// }

// class _SettingState extends State<SettingScreen> {
//   int _selectedPosition = -1;
//   var isDarkTheme;
//   List themes =  ["System default", "Light", "Dark"];
//   SharedPreferences prefs;
//   ThemeChanger themeNotifier;

//   @override
//   Widget build(BuildContext context) {
//     isDarkTheme = Theme.of(context).brightness == Brightness.dark;
//     themeNotifier = Provider.of<ThemeChanger>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(Constants.SETTING),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemBuilder: (context, position) {
//             return _createList(context, themes[position], position);
//           },
//           itemCount: themes.length,
//         ),
//       ),
//     );
//   }

//   _createList(context, item, position) {
//     return InkWell(
//       highlightColor: Colors.transparent,
//       splashColor: Colors.transparent,
//       onTap: () {
//         _updateState(position);
//       },
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Radio(
//             value: _selectedPosition,
//             groupValue: position,
//             activeColor: isDarkTheme ? AppColors.darkPink : AppColors.textBlack,
//             onChanged: (_) {
//               _updateState(position);
//             },
//           ),
//           Text(item),
//         ],
//       ),
//     );
//   }

//   _updateState(int position) {
//     setState(() {
//       _selectedPosition = position;
//     });
//     onThemeChanged(themes[position]);
//   }

//   void onThemeChanged(String value) async {
//     var prefs = await SharedPreferences.getInstance();
//     if (value == Constants.SYSTEM_DEFAULT) {
//       themeNotifier.setThemeMode(ThemeMode.system);
//     } else if (value == Constants.DARK) {
//       themeNotifier.setThemeMode(ThemeMode.dark);
//     } else {
//       themeNotifier.setThemeMode(ThemeMode.light);
//     }
//     prefs.setString(Constants.APP_THEME, value);
//   }
// }