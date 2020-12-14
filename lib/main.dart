import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'src/services/auth_services.dart';
import 'src/services/chat_service.dart';
import 'src/services/socket_service.dart';
import 'src/routes/routes.dart';
import 'src/services/videos_service.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle( statusBarColor: Colors.transparent ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
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
      theme: ThemeData(
        fontFamily: 'MontserratAlternates',
        scaffoldBackgroundColor: Colors.grey[50],
        //primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
        primaryColorBrightness: Brightness.light,
        brightness: Brightness.light
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'loading',
      routes: appRoutes,
      ),
    );
  }
}
