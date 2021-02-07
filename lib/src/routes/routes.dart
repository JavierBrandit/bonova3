import 'package:bonova0002/src/pages/inicio/upload.dart';
import 'package:bonova0002/src/pages/user/about.dart';
import 'package:bonova0002/src/pages/user/foto.dart';
import 'package:bonova0002/src/pages/user/password.dart';
import 'package:bonova0002/src/pages/user/perfil_page.dart';
import 'package:bonova0002/src/pages/user/formulario.dart';
import 'package:bonova0002/src/pages/user/config.dart';
import 'package:bonova0002/src/pages/user/biblioteca.dart';
import 'package:bonova0002/src/pages/user/actividad.dart';
import 'package:bonova0002/src/pages/user/ayuda.dart';
import 'package:bonova0002/src/pages/user/preguntas.dart';
import 'package:bonova0002/src/pages/user/profesor.dart';
import 'package:bonova0002/src/pages/user/puntos.dart';
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
  // Login
        'loading'       : (_) => LoadingPage(),
        'login'         : (_) => LoginPage(),
        'register'      : (_) => RegisterPage(),
        'home'          : (_) => HomePage(),
  // Explore      
        'explore'       : (_) => ExplorePage(),
  // Usuario      
        'user'          : (_) => UserPage(),
        'perfil'        : (_) => PerfilPage(),
        'formulario'    : (_) => Formulario(),
        'config'        : (_) => Configuracion(),
        'biblioteca'    : (_) => Biblioteca(),
        'actividad'     : (_) => Actividad(),
        'ayuda'         : (_) => Ayuda(),
        'profesor'      : (_) => Profesor(),
        'puntos'        : (_) => Puntos(),
        'password'      : (_) => Password(),
        'about'         : (_) => About(),
        'preguntas'     : (_) => Preguntas(),
        'foto'          : (_) => Foto(),
        'subir'         : (_) => SubirFoto(),




  // Inicio      
        'inicio'        : (_) => InicioPage(),
        'ramo'          : (_) => RamoPage(),
        'curso'         : (_) => CursoPage(),
        'usuarios-chat' : (_) => UsuariosChatPage(),
        'chat'          : (_) => ChatPage(),

      };
