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
    margin: EdgeInsets.all(14),
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
    onTap: () {
      VideoService videoService = Provider.of<VideoService>(context, listen: false );
      videoService.setCurso( curso );
      // Navigator.pushNamed(context, 'curso', arguments: curso );
      Navigator.push(context, MaterialPageRoute(builder: (_) => PlayPage( clips: curso.videos ) ));
    },
   )
    ]
    ),
  );
}



Widget carruselVertical(BuildContext context, Curso curso) {

  final videosLength = curso.videos.length.toString();
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
          ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(curso.portada,
            fit: BoxFit.cover,
            // height: 240,
            width: 130
            ),
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
                  child: Text(curso.titulo, style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: -.5 )),
                ),

              //VIDEOS
                Row(
                  children: [
                    Text( videosLength == '1'? '1  video' :'$videosLength  videos', style: TextStyle( fontSize: 10, fontWeight: FontWeight.w500 )),
                    Text('  ·  '+curso.ramo, style: TextStyle( fontSize: 10, fontWeight: FontWeight.w500 )),
                  ],
                ),
                
              //DESCRIPCION
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  height: 40,
                  width: pantalla.width * .52,
                  child: Text(curso.descripcion,
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
                ),
              ],
            ),
          ),   
        ]
      ),
    onTap: () {
      VideoService videoService = Provider.of<VideoService>(context, listen: false );
      AuthService authService = Provider.of<AuthService>(context, listen: false );
      SocketService socketService = Provider.of<SocketService>(context, listen: false );

      videoService.setCurso( curso );
      // Navigator.pushNamed(context, 'curso', arguments: curso );
      
      
      
      
      
      final historial = new Historial(
        curso: curso.cid,
        usuario: authService.usuario.uid,
        progreso: 0.1,
        // uid: authService.usuario.uid, 
        // texto: texto, 
        // animationController: AnimationController( vsync: this, duration: Duration(milliseconds: 200))
        );
      // _messages.insert(0, newMessage);
      // newMessage.animationController.forward(); 

      // setState(() { _estaEscribiendo = false; });

      socketService.emit('historial', {
        'curso': curso.cid,
        'usuario': authService.usuario.uid,
        // 'progreso': 0.1
        // 'de': authService.usuario.uid,
        // 'para': this.chatService.usuarioPara.uid,
        // 'mensaje': texto
      });

      Navigator.push(context, MaterialPageRoute(builder: (_) => PlayPage( clips: curso.videos ) ));
    },
   )
    //   ),
    //  ),
        
        
    ]
    ),
  );
}
