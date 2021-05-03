import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bonova0002/theme.dart';
import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/theme.dart';
import 'package:bonova0002/src/services/prefs.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:full_screen_image/full_screen_image.dart';


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
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        title: Text(''),
        elevation: 0,
      ),
      body: Column(

        children: [
          // SizedBox( height: 40 ),

          // foto(usuario.foto),
          
          Row( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            GestureDetector(
              onTap: (){
                
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20, right:15),
                child: Hero(
                  tag: 'foto',
                  child: GestureDetector(
                    child: CircleAvatar(backgroundImage: NetworkImage(usuario.foto), radius: 57 ),
                    onTap: () => Navigator.pushNamed(context, 'foto', arguments: usuario)
                    
                  ),
                ),
              ),
            ),
            //SizedBox( width: 20 ),
            infoUsuario( context, pantalla, usuario ),


          ]),

          SizedBox( height: 20 ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10 ),
            child: Divider(),
          ),

          tiraDiaNoche(),
          
          // Divider( color: Colors.transparent, height: 8),
          tira( 'Configuracion', Icon( FluentIcons.settings_24_regular, color: isDarkTheme? Colors.blue[300] : Colors.blue[600], size: 25 ), 'config' ),
          // Divider( color: Colors.transparent, height: 8),
          tira( 'Biblioteca', Icon( FluentIcons.bookmark_24_regular, color: isDarkTheme? Colors.yellow[300] : Colors.yellow[700], size: 25), 'biblioteca'),
          // Divider( color: Colors.transparent, height: 8),
          tira( 'Actividad', Icon( FluentIcons.alert_24_regular, color: isDarkTheme? Colors.red[300] : Colors.redAccent[700], size: 25), 'actividad'),
          // Divider( color: Colors.transparent, height: 8),
          tira( 'Ayuda', Icon( FluentIcons.chat_help_24_regular, color: isDarkTheme? Colors.grey[300] : Colors.grey[600], size: 25), 'ayuda'),
          // Divider( color: Colors.transparent, height: 8),
          

        ],
      ),  
      
    );
  }

  foto(String img){
    return Container(
      height: 70,
      width: 70,

      child: FullScreenWidget(
          child: Hero(
            tag: "customTag",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                img, fit: BoxFit.cover, height: 70, width: 70,
              ),
            ),
          ),
        ),
    );

  }

  Widget infoUsuario( BuildContext c, Size size, Usuario usuario ) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      // child: Container(
      //   // decoration: BoxDecoration( 
      //   //   boxShadow: [BoxShadow(
      //   //     color: isDarkTheme? Colors.black.withOpacity(0.01) : Colors.grey[100],
      //   //     offset: Offset.fromDirection(-10),
      //   //     blurRadius: 10
      //   //     )]),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(15),
          child: Container(
            width: size.width * 0.55,
            // height: 160,
            decoration: BoxDecoration( 
                border: Border.all( width: .3, color: isDarkTheme? Colors.transparent : Colors.grey[300] ),
                color: isDarkTheme? Colors.blueGrey[900].withOpacity(.6) : Colors.blueGrey[50].withOpacity(.6),
                borderRadius: BorderRadius.circular(15)
            ),
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(right: 25, left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(usuario.profesor?'Profesor' :'Alumno', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w500, color: isDarkTheme? Colors.grey[400] : Colors.grey[700], ) ),
                Text(usuario.nombre, style: TextStyle( fontSize: 26, fontWeight: FontWeight.w500, letterSpacing: -.3, color: isDarkTheme? Colors.white : Colors.grey[800] ) ),
                SizedBox( height: 10 ),
                Text('Curso', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w500, color: isDarkTheme? Colors.grey[400] : Colors.grey[700], ) ),
                Text('${usuario.curso} · ${usuario.colegio}', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: isDarkTheme? Colors.grey[50] : Colors.grey[850] ) ),
                SizedBox( height: 15 ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(FluentIcons.person_16_regular, size: 16, color: Colors.tealAccent[700]),
                          ),
                          Text('ver perfil', style: TextStyle( fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: -0.3, color: Colors.tealAccent[700] ) ),
                        ],
                      ),
                      onTap: () => Navigator.pushNamed(context, 'perfil', arguments: usuario),
                    ),
                    SizedBox( height: 6 ),
                    GestureDetector(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(FluentIcons.leaf_one_16_regular, size: 16, color: Colors.amber[300]),
                          ),
                          Text('editar info', style: TextStyle( fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: -0.3, color: Colors.amber[300] ) ),
                        ],
                      ),
                      onTap: () => Navigator.pushNamed(context, 'formulario'),
                    ),
                  ],
                ),
               
              ],
            ),
          // ),
        // ),
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
        padding: EdgeInsets.symmetric(horizontal: 25),
        // color: isDarkTheme? BonovaColors.azulNoche[750] : Colors.white,
        height: 60,
        child: Row(
          children: [

            FlutterSwitch(        
              width: 50,
              height: 35,
              valueFontSize: 25.0,
              toggleSize: 29.0,
              value: isDarkTheme,
              borderRadius: 30.0,
              switchBorder: Border.all( width: .3, color: isDarkTheme? Colors.transparent : Colors.blueGrey[100]),
              padding: 4,
              
              activeIcon: Icon(FluentIcons.weather_moon_16_regular, color: Colors.teal[50], size: 28,),
              activeColor: Colors.blueGrey[900].withOpacity(.8),
              activeToggleColor: Colors.transparent,

              inactiveIcon: Icon(FluentIcons.weather_sunny_24_regular, color: Colors.teal[600], size: 28,),
              inactiveColor: Colors.blueGrey[50],
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
        padding: EdgeInsets.symmetric(horizontal: 30),
        // color: isDarkTheme? BonovaColors.azulNoche[750] : Colors.white,
        height: 60,
        child: Row(
          children: [
            // SizedBox( width: 10 ),
            icon,
            //SvgPicture.asset( svg, height: 19 ),
            SizedBox( width: 20 ),
            Text( text , style: TextStyle( fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: -.4 ) ),
          ],
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, ruta);
      },
    );
  }
}