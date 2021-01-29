import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/theme.dart';
import 'package:bonova0002/src/services/prefs.dart';
import 'package:bonova0002/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';

 
class UserPage extends StatefulWidget { 
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  Color grisfondo = Colors.grey[850];
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final Size pantalla = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
      ),
      body: Column(

        children: [
          SizedBox( height: 40 ),
          
          Row( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: CircleAvatar(backgroundImage: AssetImage('assets/placeBonova.jpg'), radius: 55 ),
            ),
            //SizedBox( width: 20 ),
            infoUsuario( context, pantalla, usuario ),


          ]),

          SizedBox( height: 50 ),

          tiraDiaNoche(),
          
          // Divider( color: Colors.transparent, height: 8),
          tira( 'Configuracion', Icon( FluentIcons.settings_24_regular, color: isDarkTheme? Colors.blue[700] : Colors.blue[300]), 'config' ),
          // Divider( color: Colors.transparent, height: 8),
          tira( 'Biblioteca', Icon( FluentIcons.bookmark_16_regular, color: isDarkTheme? Colors.yellow[700] : Colors.yellow[600]), 'biblioteca'),
          // Divider( color: Colors.transparent, height: 8),
          tira( 'Actividad', Icon( FluentIcons.alert_16_regular, color: isDarkTheme? Colors.red[700] : Colors.redAccent[100]), 'actividad'),
          // Divider( color: Colors.transparent, height: 8),
          tira( 'Ayuda', Icon( FluentIcons.chat_help_24_regular, color: isDarkTheme? Colors.grey[500] : Colors.grey[400]), 'ayuda'),
          // Divider( color: Colors.transparent, height: 8),
          

        ],
      ),  
      
    );
  }

  Widget infoUsuario( BuildContext c, Size size, Usuario usuario ) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration( 
          boxShadow: [BoxShadow(
            color: isDarkTheme? Colors.black.withOpacity(0.01) : Colors.grey[100],
            offset: Offset.fromDirection(-10),
            blurRadius: 10
            )]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: isDarkTheme? BonovaColors.azulNoche[700] : Colors.white,
            width: size.width * 0.54,
            height: 160,
            padding: EdgeInsets.all(18),
            // decoration: BoxDecoration(boxShadow: [BoxShadow(
            //     color: Colors.grey,
            //     offset: Offset.fromDirection(-10.0),
            //     blurRadius: 20.0
            //     )]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Alumno', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: isDarkTheme? Colors.grey[400] : Colors.grey[500], ) ),
                Text(usuario.nombre, style: TextStyle( fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.2, color: isDarkTheme? Colors.white : Colors.grey[800] ) ),
                SizedBox( height: 5 ),
                Text('Curso', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: isDarkTheme? Colors.grey[400] : Colors.grey[500], ) ),
                Text('3ro · Patricio Mekis · TP', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: isDarkTheme? Colors.grey[50] : Colors.grey[850] ) ),
                SizedBox( height: 15 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Text('editar informacion', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.6, color: Colors.tealAccent[700] ) ),
                      onTap: () => Navigator.pushNamed(context, 'formulario'),
                    ),
                  ],
                ),
               
              ],
            ),
          ),
        ),
      ),
      onTap: (){
        Navigator.pushNamed( c, 'perfil', arguments: usuario);
      },
    );
  }

  Widget tiraDiaNoche() {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 29),
        // color: isDarkTheme? BonovaColors.azulNoche[750] : Colors.white,
        height: 60,
        child: Row(
          children: [

            FlutterSwitch(        
              width: 45,
              height: 33,
              valueFontSize: 25.0,
              toggleSize: 25.0,
              value: isDarkTheme,
              borderRadius: 30.0,
              padding: 4,
              
              activeIcon: Icon(FluentIcons.weather_moon_16_regular, color: Colors.teal[50]),
              activeColor: Colors.black26,
              activeToggleColor: Colors.transparent,

              inactiveIcon: Icon(FluentIcons.weather_sunny_24_regular, color: Colors.tealAccent[700], size: 28,),
              inactiveColor: Colors.grey[100],
              inactiveToggleColor: Colors.transparent,

              onToggle: (val) {
                  val = isDarkTheme;
                final tema = Provider.of<ThemeChanger>(context, listen: false);
                isDarkTheme 
                  ? tema.setTheme(ThemeMode.light) 
                  : tema.setTheme(ThemeMode.dark);
                setState(() {});  
              },
            ),

            SizedBox( width: 15 ),
            Text( isDarkTheme? 'Modo Noche' : 'Modo Día' , 
              style: TextStyle( fontSize: 17, fontWeight: FontWeight.w500 ) ),
          ],
        ),
      ),
      onTap: (){
        final tema = Provider.of<ThemeChanger>(context, listen: false);
        isDarkTheme 
          ? tema.setTheme(ThemeMode.light) 
          : tema.setTheme(ThemeMode.dark);
        setState(() {});
      },
    );
  }
  
  Widget tira( String text, Widget icon, String ruta) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        // color: isDarkTheme? BonovaColors.azulNoche[750] : Colors.white,
        height: 60,
        child: Row(
          children: [
            SizedBox( width: 10 ),
            icon,
            //SvgPicture.asset( svg, height: 19 ),
            SizedBox( width: 29 ),
            Text( text , style: TextStyle( fontSize: 17, fontWeight: FontWeight.w500, ) ),
          ],
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, ruta);
      },
    );
  }
}