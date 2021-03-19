import 'package:bonova0002/src/models/historial.dart';
import 'package:bonova0002/src/pages/player/mis_cursos.dart';
import 'package:bonova0002/src/pages/player/reproductor_video.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:bonova0002/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';


Widget carruselHorizontal(BuildContext context, Curso curso) {

  final videosLength = curso.videos.length.toString();

  return Container(
    margin: EdgeInsets.only(right:15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[

    GestureDetector(
      child: Column(
        children: [
          ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(curso.portada,
            fit: BoxFit.cover,
            // height: 240,
            width: 210
            ),
          ),
          Container(
            height: 115,
            width: 210,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //TITULO
                Padding(
                  padding: const EdgeInsets.only(top:10, bottom:6),
                  child: Text(curso.titulo, style: TextStyle( fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: -.5 )),
                ),

              //VIDEOS
                Text(videosLength == '1'? '1  video' :'$videosLength  videos', style: TextStyle( fontSize: 9, fontWeight: FontWeight.w500 )),
                
              //DESCRIPCION
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  height: 40,
                  width: 220,
                  child: Text(curso.descripcion,
                    style: TextStyle( fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: -.2, height: 1.5),
                    overflow: TextOverflow.clip,
                    softWrap: true,
                  ),
                ),
                
              //RATE Y PROFESOR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon( FluentIcons.star_24_filled, size: 11, color: Colors.teal[300],),
                        SizedBox(width: 3),
                        Text(curso.rate.toString(), style: TextStyle( fontSize: 12, fontWeight: FontWeight.w300) ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(curso.profesor, style: TextStyle( fontSize: 10, fontWeight: FontWeight.w400) ),
                    ),
                    // SizedBox(width: 5),
                  ]
                ),
              ],
            ),
          ),   
        ]
      ),
    onTap: () async {

      final historial = Historial(
        curso: curso,
        guardado: false,
        // progreso: _position.inSeconds / _duration.inSeconds,
        largo: curso.videos.length,
        index: 0,
        prefs: []
      );
      
      VideoService videoService = Provider.of<VideoService>(context, listen: false );
      AuthService authService = Provider.of<AuthService>(context, listen: false );
      videoService.setCurso( historial.curso );
      
      final socketService = Provider.of<SocketService>(context, listen: false );

      socketService.emit('historial', {
        'curso': historial.curso.cid,
        'usuario': authService.usuario.uid
      });

      Navigator.push(context, MaterialPageRoute(builder: (_) => PlayPage( curso: historial.curso, historial: historial ) ));
    },
   )
    ]
    ),
  );
}



Widget carruselVertical(BuildContext context, Historial historial) {

  final videosLength = historial.curso.videos.length.toString();
  final pantalla = MediaQuery.of(context).size;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[

    GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(historial.curso.portada,
                fit: BoxFit.cover,
                // height: 240,
                width: 130
                ),
              ),
              SizedBox( height: 10),
              Container(
                height: 3,
                width: 130,
                color: Colors.grey.withOpacity(.3),

              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            width: pantalla.width * .53,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              //TITULO
                Padding(
                  padding: EdgeInsets.only( bottom: 5),
                  child: Text(historial.curso.titulo, style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: -.5 )),
                ),

              //VIDEOS
                Row(
                  children: [
                    Text( videosLength == '1'? '1  video' :'$videosLength  videos', style: TextStyle( fontSize: 10, fontWeight: FontWeight.w500 )),
                    Text('  ·  '+historial.curso.ramo, style: TextStyle( fontSize: 10, fontWeight: FontWeight.w500 )),
                  ],
                ),
                
              //DESCRIPCION
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  height: 40,
                  width: pantalla.width * .52,
                  child: Text(historial.curso.descripcion,
                    style: TextStyle( fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: -.2, height: 1.5),
                    overflow: TextOverflow.clip,
                    softWrap: true,
                  ),
                ),
                
              //RATE Y PROFESOR
                Padding(
                  padding: const EdgeInsets.only( top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon( FluentIcons.star_24_filled, size: 11, color: Colors.teal[300],),
                          SizedBox(width: 3),
                          Text(historial.curso.rate.toString(), style: TextStyle( fontSize: 12, fontWeight: FontWeight.w300) ),
                        ],
                      ),
                      Text(historial.progreso.toString()),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(historial.curso.profesor, style: TextStyle( fontSize: 10, fontWeight: FontWeight.w400) ),
                      ),
                      // SizedBox(width: 5),
                    ]
                  ),
                ),
              ],
            ),
          ),   
        ]
      ),
    onTap: () async {

      final histor = Historial(
        curso: historial.curso,
        guardado: false,
        // progreso: _position.inSeconds / _duration.inSeconds,
        largo: historial.curso.videos.length,
        index: 0,
        prefs: []
      );
      
      VideoService videoService = Provider.of<VideoService>(context, listen: false );
      AuthService authService = Provider.of<AuthService>(context, listen: false );
      videoService.setCurso( historial.curso );
      
      final socketService = Provider.of<SocketService>(context, listen: false );

      socketService.emit('historial', {
        'curso': historial.curso,
        'usuario': authService.usuario.uid
      });

      Navigator.push(context, MaterialPageRoute(builder: (_) => PlayPage( curso: historial.curso, historial: historial ) ));
    },
   )
    //   ),
    //  ),
        
        
    ]
    ),
  );
}
