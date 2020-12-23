import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'src/services/auth_services.dart';
import 'src/services/chat_service.dart';
import 'src/services/socket_service.dart';
import 'src/services/theme.dart';
import 'src/routes/routes.dart';
import 'src/services/videos_service.dart';
import 'src/services/prefs.dart';
import 'package:bonova0002/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle( statusBarColor: Colors.transparent ));
  // final prefs = new PreferenciasUsuario();
  // await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //final themeChanger = Provider.of<ThemeChanger>(context);
    // final prefs = new PreferenciasUsuario();
    // bool isDarkTheme = prefs.colorSecundario;
    
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeMode.light),
      child: AppWithTheme(),
    );

    
  }
}

class AppWithTheme extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final tema = Provider.of<ThemeChanger>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService() ),
        ChangeNotifierProvider(create: (_) => SocketService() ),
        ChangeNotifierProvider(create: (_) => ChatService() ),
        ChangeNotifierProvider(create: (_) => VideoService() ),
        ChangeNotifierProvider(create: (_) => CursoService() ),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bonova',
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: tema.getTheme(),
      // theme: ThemeData(
      //   fontFamily: 'MontserratAlternates',
      //   scaffoldBackgroundColor: Colors.white,
      //   //primarySwatch: Colors.teal,
      //   primaryColor: Colors.teal,
      //   primaryColorBrightness: Brightness.light,
      //   brightness: Brightness.light
      //   //visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      initialRoute: 'loading',
      routes: appRoutes,
      ),
    );
  }
}
