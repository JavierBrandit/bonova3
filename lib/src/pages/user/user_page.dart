import 'package:bonova0002/src/services/theme.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

 
class UserPage extends StatefulWidget {
 
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  Color grisfondo = Colors.grey[850];

  @override
  Widget build(BuildContext context) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final Size pantalla = MediaQuery.of(context).size;
    final tema = Provider.of<ThemeChanger>(context);
    
    return Scaffold(
      //backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(''),
        //backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(

        children: [
          SizedBox( height: 40 ),
          
          Row( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(backgroundImage: AssetImage('assets/placeBonova.jpg'), radius: 55 ),
            ),
            //SizedBox( width: 20 ),
            infoUsuario( context, pantalla ),


          ]),

          SizedBox( height: 50 ),

          tira( 'Modo Noche', Icon( FluentSystemIcons.ic_fluent_weather_moon_filled, color: Colors.teal[300] ) ),
          Divider( color: Colors.transparent, height: 8),
          tira( 'Biblioteca', Icon( FluentSystemIcons.ic_fluent_folder_filled, color: Colors.yellow[400] )),
          Divider( color: Colors.transparent, height: 8),
          tira( 'Actividad', Icon( FluentSystemIcons.ic_fluent_heart_filled, color: Colors.redAccent[100] )),
          Divider( color: Colors.transparent, height: 8),
          tira( 'Configuracion', Icon( FluentSystemIcons.ic_fluent_settings_filled, color: Colors.blue[100] )),
          Divider( color: Colors.transparent, height: 8),
          tira( 'Ayuda', Icon( FluentSystemIcons.ic_fluent_help_circle_filled, color: Colors.grey[400] )),
          Divider( color: Colors.transparent, height: 8),
          

        ],
      ),  
      
    );
  }

  Widget infoUsuario( BuildContext c, Size size ) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Navigator.pushNamed( c, 'perfil'),
      child: Container(
        decoration: BoxDecoration( boxShadow: [BoxShadow(
            color: isDarkTheme? Colors.black.withOpacity(0.03) : Colors.grey[100],
            offset: Offset.fromDirection(-10),
            blurRadius: 10
            )]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: isDarkTheme? grisfondo : Colors.white,
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
              children: [
                Text('Alumno', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: isDarkTheme? Colors.grey[400] : Colors.grey[500], ) ),
                Text('Javier Gonzalez D.', style: TextStyle( fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.2, color: isDarkTheme? Colors.white : Colors.grey[800] ) ),
                SizedBox( height: 10 ),
                Text('Curso', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: isDarkTheme? Colors.grey[400] : Colors.grey[500], ) ),
                Text('3ro · Patricio Mekis · TP', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.2, color: isDarkTheme? Colors.grey[50] : Colors.grey[850] ) ),
                SizedBox( height: 35 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('editar informacion', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.6, color: Colors.tealAccent[700], ) ),
                  ],
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tira( String text, Icon icon) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 33),
        color: isDarkTheme? grisfondo : Colors.white,
        height: 60,
        child: Row(
          children: [
            icon,
            //SvgPicture.asset( svg, height: 19 ),
            SizedBox( width: 20 ),
            Text( text , style: TextStyle( fontSize: 17, fontWeight: FontWeight.w400, color: isDarkTheme? Colors.grey[50] : Colors.grey[850] ) ),
          ],
        ),
      ),
      onTap: (){
        final tema = Provider.of<ThemeChanger>(context, listen: false);
        tema.setTheme(ThemeMode.dark);
        setState(() {});
      },
    );
  }
}