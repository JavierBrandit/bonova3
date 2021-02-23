import 'package:bonova0002/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/services/videos_service.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:bonova0002/src/widgets/reproductor_video.dart';


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
    //   ),
    //  ),
        
        
    ]
    ),
  );
}
