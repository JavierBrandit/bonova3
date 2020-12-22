import 'package:bonova0002/src/pages/user/perfil_page.dart';
import 'package:bonova0002/src/widgets/reproductor_video.dart';
import 'package:flutter/material.dart';
import 'package:bonova0002/src/pages/inicio/curso_page.dart';
import 'package:bonova0002/src/pages/user/user_page.dart';
import 'package:bonova0002/src/pages/explore/explore_page.dart';
import 'package:bonova0002/src/pages/inicio/chat_page.dart';
import 'package:bonova0002/src/pages/inicio/inicio_page.dart';
import 'package:bonova0002/src/pages/inicio/usuarioschat_page.dart';
import 'package:bonova0002/loading_page.dart';
import 'package:bonova0002/src/pages/login/register_page.dart';
import 'package:bonova0002/home_page.dart';
import 'package:bonova0002/src/pages/inicio/ramo_page.dart';
import 'package:bonova0002/src/pages/login/login_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
        'loading'       : (_) => LoadingPage(),
        'login'         : (_) => LoginPage(),
        'register'      : (_) => RegisterPage(),
        'explore'       : (_) => ExplorePage(),
        'user'          : (_) => UserPage(),
        'perfil'        : (_) => PerfilPage(),
        'home'          : (_) => HomePage(),
        'inicio'        : (_) => InicioPage(),
        //'upload'        : (_) => ProductoPage(),
        //'reproductor'   : (_) => VideosReproductor(),
        'ramo'          : (_) => RamoPage(),
        'curso'         : (_) => CursoPage(),
        'usuarios-chat' : (_) => UsuariosChatPage(),
        'chat'          : (_) => ChatPage(),



        //'test'            : ( BuildContext context) => PruebaMil(),

        //SettingsPage.routeName : ( BuildContext context) => SettingsPage(),

      };
