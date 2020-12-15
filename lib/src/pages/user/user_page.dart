import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
 
class UserPage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {

    final Size pantalla = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
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
            Container(
              decoration: BoxDecoration( boxShadow: [BoxShadow(
                  color: Colors.grey[100],
                  offset: Offset.fromDirection(-10),
                  blurRadius: 10
                  )]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.white,
                  width: pantalla.width * 0.54,
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
                      Text('Alumno', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: Colors.grey[500], ) ),
                      Text(' Javier Gonzalez D.', style: TextStyle( fontSize: 21, fontWeight: FontWeight.w600, letterSpacing: 0.2, color: Colors.grey[700] ) ),
                      SizedBox( height: 10 ),
                      Text('Curso', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: Colors.grey[500], ) ),
                      Text(' 3ro · Patricio Mekis · TP', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.2, color: Colors.grey[600] ) ),
                      SizedBox( height: 10 ),
                      Text('editar', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: Colors.teal, ) ),
                     
                    ],
                  ),
                ),
              ),
            ),


          ]),

          SizedBox( height: 50 ),

          // FlatButton.icon(
          //   icon: Icon( Icons.add, size: 18 ),
          //   onPressed: (){},
          //   label: Text('Seguir', style: TextStyle( fontSize: 16, fontWeight: FontWeight.w700),),
          //   color: Colors.tealAccent[400],
          //   colorBrightness: Brightness.dark,
          //   shape: StadiumBorder(),
          // ),
          
          // Card(
          //   borderOnForeground: true,
          //   elevation: 0.4,
          //   margin: EdgeInsets.all(12),
          //   child: Container(
          //     padding: EdgeInsets.all(14),
          //     width: double.infinity,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text('Sobre Mi', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w500)),
          //         SizedBox( height: 6 ),
          //         Text('sobre mi sobre misobre mi sobre mi sobre mi sobre mi sobre misobre mi sobre mi sobre mi'
          //         , style: TextStyle( fontSize: 14, fontWeight: FontWeight.w300)),
          //         SizedBox( height: 12 ),
          //         Text('Estudios', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w500)),
          //         SizedBox( height: 6 ),
          //         Text('Fue a la Universidad de Santiago'
          //         , style: TextStyle( fontSize: 14, fontWeight: FontWeight.w300)),
          //     ]),
          //   ),
          // ),

          tira( 'Modo Noche', Icon( FluentSystemIcons.ic_fluent_weather_moon_filled, color: Colors.teal[400] ) ),
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

  Widget tira( String text, Icon icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 33),
      color: Colors.white,
      height: 60,
      child: Row(
        children: [
          icon,
          //SvgPicture.asset( svg, height: 19 ),
          SizedBox( width: 30 ),
          Text( text , style: TextStyle( fontSize: 17, fontWeight: FontWeight.w500, color: Colors.grey[800] ) ),
        ],
      ),
    );
  }

}