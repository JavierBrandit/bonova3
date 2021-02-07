import 'package:bonova0002/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/services/videos_service.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:bonova0002/src/widgets/reproductor_video.dart';


Widget carruselHorizontal(BuildContext context, Curso curso) {

  //final pantalla = MediaQuery.of(context).size;
  var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

  return Container(
    margin: EdgeInsets.all(14),
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
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
                  child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                
                 Image.network(curso.portada,
                  fit: BoxFit.cover,
                  height: 270,
                  width: double.infinity
                ),
                Container(
                  color: isDarkTheme? BonovaColors.azulNoche[600] : Colors.white, 
                  height: 135,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric( horizontal: 18 ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox( height: 10),
                      Row(
                        children: [
                          Text(curso.titulo, style: TextStyle( fontSize: 15, fontWeight: FontWeight.w600 ),),
                        ]
                      ),
                      SizedBox( height: 3),
                      Text(curso.videos.length.toString() + ' videos', style: TextStyle( fontSize: 11, fontWeight: FontWeight.w500 )),
                      SizedBox( height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //SizedBox( width: 18),
                          Container(
                            height: 60,
                            width: 210,
                            child: Text(curso.descripcion,
                              style: TextStyle( fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 0.3, height: 1.5),
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                          ),
                          //SizedBox(width: 18),
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon( FluentIcons.star_24_filled, size: 11, color: Colors.teal[300],),
                              SizedBox(width: 3,),
                              Text(curso.rate.toString(), style: TextStyle( fontSize: 12, fontWeight: FontWeight.w300) ),
                            ],
                          ),
                          Text(curso.profesor, style: TextStyle( fontSize: 12, fontWeight: FontWeight.w400) ),
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
      ),
     ),
        
        
    ]
    ),
  );
}
