import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Widget carruselHorizontal(BuildContext context, Curso curso) {

  //final pantalla = MediaQuery.of(context).size;
  var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

  return Container(
    margin: EdgeInsets.all(14.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[

      Container(
        decoration: BoxDecoration( boxShadow: [BoxShadow(
          color: isDarkTheme? Colors.black.withOpacity(0.05) : Colors.grey[100],
          offset: Offset.fromDirection(60),
          blurRadius: 10
        )]),
        child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: GestureDetector(
                  child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.asset('assets/placeholder.png',
                  fit: BoxFit.cover,
                  height: 270.0,
                  width: double.infinity
                ),
                Container(
                  color: isDarkTheme? Colors.grey[850] : Colors.white, 
                  height: 135,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric( horizontal: 18.0 ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          //SizedBox( width: 18),
                          Text(curso.titulo, style: TextStyle( fontSize: 15, fontWeight: FontWeight.w500 ),)
                        ]
                      ),
                      SizedBox( height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //SizedBox( width: 18),
                          Container(
                            height: 65,
                            width: 210,
                            child: Text('Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar.',
                              style: TextStyle( fontSize: 11, fontWeight: FontWeight.w300, letterSpacing: 0.3, height: 1.5),
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                          ),
                          //SizedBox(width: 18),
                        ]
                      ),
                      SizedBox( height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //SizedBox( width: 20),
                          Row(
                            children: [
                              Icon( FluentSystemIcons.ic_fluent_star_filled, size: 11, color: Colors.teal[300],),
                              SizedBox(width: 3,),
                              Text('5', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w300) ),
                            ],
                          ),
                          //SizedBox( width: 20),
                          Text(curso.ramo + ' · ' + curso.nivel + 'º', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w300) ),
                          //SizedBox( width: 20),
                        ]
                      ),
                      SizedBox( height: 14),
                    ],
                  ),
                ),
              ]
          ),
        onTap: () {
          VideoService videoService = Provider.of<VideoService>(context, listen: false );
          videoService.curso = curso;
          Navigator.pushNamed(context, 'curso', arguments: curso );
        },
       )
      ),
     ),
        
        
    ]
    ),
  );
}
