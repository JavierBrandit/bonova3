import 'package:bonova0002/src/models/historial.dart';
import 'package:bonova0002/src/pages/player/mis_cursos.dart';
import 'package:bonova0002/src/pages/player/reproductor_video.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:bonova0002/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:websafe_svg/websafe_svg.dart';


Widget carruselHorizontal(BuildContext context, Historial historial) {

  final videosLength = historial.curso.videos.length.toString();
  var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

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
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.network(historial.curso.portada,
                  fit: BoxFit.cover,
                  // height: 240,
                  width: 210
                ),
                historial.progreso != null 
                ? Container(
                  color: isDarkTheme? Colors.black12 : Colors.white24,
                  width: 210,
                  height: 3,
                ) : Container(),
                historial.progreso != null
                ? Container(
                  color: isDarkTheme? Colors.tealAccent[400] : Colors.teal[400],
                  width: 210 * (historial.index + historial.progreso)/historial.curso.videos.length,
                  height: 3,
                ) : Container(),
              ],
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
                  child: Text(historial.curso.titulo, style: TextStyle( fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: -.5 )),
                ),

              //VIDEOS
                Text(videosLength == '1'? '1  video' :'$videosLength  videos', style: TextStyle( fontSize: 9, fontWeight: FontWeight.w500 )),
                
              //DESCRIPCION
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  height: 40,
                  width: 220,
                  child: Text(historial.curso.descripcion,
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
                        Text(historial.curso.rate.toString(), style: TextStyle( fontSize: 12, fontWeight: FontWeight.w300) ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(historial.curso.profesor.nombre, style: TextStyle( fontSize: 10, fontWeight: FontWeight.w400) ),
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

      // final historiala = Historial(
      //   curso: historial,
      //   // guardado: false,
      //   // progreso: _position.inSeconds / _duration.inSeconds,
      //   largo: historial.videos.length,
      //   // index: 0,
      //   // prefs: []
      // );
      
      CursoService cursoService = Provider.of<CursoService>(context, listen: false );
      AuthService authService = Provider.of<AuthService>(context, listen: false );
      final socketService = Provider.of<SocketService>(context, listen: false );
      // videoService.setCurso( historial.curso );

      // cursoService.setReproduciendo(true);
      cursoService.setHistorial(historial);
      // cursoService.setDisposed(false);
      

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
  final duracion = historial.curso.videos.length;
  final posicion = historial.index + historial.progreso;
  final progreso = posicion / duracion;
  // final progresoCurso = ((historial.index) *historial.progreso/ historial.curso.videos.length) + historial.progreso;
  var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

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
            // crossAxisAlignment: CrossAxisAlignment.start,
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
              Stack(
                children: [
                  Container(
                    height: 2,
                    width: 110,
                    color: isDarkTheme? Colors.white10 :Colors.grey[200],

                  ),
                  Container(
                    height: 2,
                    width: historial.progreso != null
                            ? 110 * progreso
                            : 0,
                    color: isDarkTheme? Colors.tealAccent[400] : Colors.teal[400],

                  ),
                ],
              ),
              SizedBox(height: 7),
              Text(
              historial.index != null
                ?  'Clase nº ${historial.index + 1}   ·   Progreso: ${(progreso*100).toStringAsFixed(1)} %'
                :  'Comenzar Curso',
              style: TextStyle( fontSize: 9, letterSpacing: -.3, fontWeight: FontWeight.w500)
              ),
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
                      // Text(historial.progreso.toString()),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(historial.curso.profesor.nombre, style: TextStyle( fontSize: 10, fontWeight: FontWeight.w400) ),
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

      CursoService cursoService = Provider.of<CursoService>(context, listen: false );
      AuthService authService = Provider.of<AuthService>(context, listen: false );
      // viService.setCurso( historial.curso );
      
      final socketService = Provider.of<SocketService>(context, listen: false );
      
      // final historialx = Historial(
      //   curso: historial.curso,
      //   usuario: authService.usuario.uid,
      //   // guardado: false,
      //   // progreso: _position.inSeconds / _duration.inSeconds,
      //   largo: historial.curso.videos.length,
      //   // index: 0,
      //   // prefs: []
      // );
      // cursoService.setReproduciendo(true);
      cursoService.setHistorial(historial);
      // cursoService.setDisposed(false);

      socketService.emit('historial', {
        'curso': historial.curso.cid,
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


Widget carruselHistorial(BuildContext context, Historial historial) {

  final videosLength = historial.curso.videos.length.toString();
  final pantalla = MediaQuery.of(context).size;
  final duracion = historial.curso.videos.length;
  final posicion = historial.index + historial.progreso;
  final progreso = posicion / duracion;
  var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
  // final progresoCurso = ((historial.index) *historial.progreso/ historial.curso.videos.length) + historial.progreso;

  return Container(
    margin: EdgeInsets.only(bottom: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[

    GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox( height: 100),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(historial.curso.portada,
                    fit: BoxFit.cover,
                    // height: 240,
                    width: 150
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(.04),
                    width: 150,
                    height: 9/16 * 150,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(.07), blurRadius: 12)]),
                    child: WebsafeSvg.asset('assets/bvPlay.svg', height: 20, width: 20, color: Colors.white,)
                  ), 
                ],
              ),
              SizedBox( height: 10),
              Stack(
                children: [
                  Container(
                    height: 3,
                    width: 130,
                    color: isDarkTheme? Colors.white10 :Colors.grey[200],

                  ),
                  Container(
                    height: 3,
                    width: historial.progreso != null
                            ? 130 * progreso
                            : 0,
                    color: isDarkTheme? Colors.tealAccent[400] : Colors.teal[400],

                  ),
                ],
              ),
            ],
          ),
          Container(
            // color: Colors.tealAccent,
            margin: EdgeInsets.only(left: 20),
            width: pantalla.width * .37,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              //TITULO
                Padding(
                  padding: EdgeInsets.only( bottom: 5),
                  child: Text(historial.curso.titulo, style: TextStyle( fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: -.5 )),
                ),

              //VIDEOS
                Row(
                  children: [
                    Text( videosLength == '1'? '1  video' :'$videosLength  videos', style: TextStyle( fontSize: 10, fontWeight: FontWeight.w500 )),
                    Text('  ·  '+historial.curso.ramo, style: TextStyle( fontSize: 10, fontWeight: FontWeight.w500 )),
                  ],
                ),
                
              //DESCRIPCION
                // Container(
                //   margin: EdgeInsets.only(top: 5, bottom: 5),
                //   height: 40,
                //   width: pantalla.width * .52,
                //   child: Text(historial.curso.cid,
                //     style: TextStyle( fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: -.2, height: 1.5),
                //     overflow: TextOverflow.clip,
                //     softWrap: true,
                //   ),
                // ),
                
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
                      // Text(historial.progreso.toString()),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 10),
                      //   child: Text(historial.curso.profesor, style: TextStyle( fontSize: 10, fontWeight: FontWeight.w400) ),
                      // ),
                      // SizedBox(width: 5),
                    ]
                  ),
                ),
                SizedBox( height: 10),
                Text(
                  historial.index != null
                    ?  'Clase nº ${historial.index + 1}   ·   Progreso: ${(progreso*100).toStringAsFixed(0)} %'
                    :  'Comenzar Curso',
                  style: TextStyle( fontSize: 9, letterSpacing: -.1, fontWeight: FontWeight.w500)
                ),
              ],
            ),
          ), 
          // Container(
          //   color: Colors.grey[400],
          //   height: 80,
          //   width: .2,
          // )
        ]
      ),
    onTap: () {

      CursoService cursoService = Provider.of<CursoService>(context, listen: false );
      AuthService authService = Provider.of<AuthService>(context, listen: false );
      // videoService.setCurso( historial.curso );
      
      final socketService = Provider.of<SocketService>(context, listen: false );
      
      // final historialx = Historial(
      //   curso: historial.curso,
      //   usuario: authService.usuario.uid,
      //   // guardado: false,
      //   // progreso: _position.inSeconds / _duration.inSeconds,
      //   largo: historial.curso.videos.length,
      //   // index: 0,
      //   // prefs: []
      // );

      // cursoService.setReproduciendo(true);
      cursoService.setHistorial(historial);
      // cursoService.setDisposed(false);

      socketService.emit('historial', {
        'curso': historial.curso.cid,
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
