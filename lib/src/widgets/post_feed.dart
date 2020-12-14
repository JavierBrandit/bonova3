// import 'package:bonova0002/src/models/video_modelo.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:videos_player/model/control.model.dart';
// import 'package:videos_player/model/video.model.dart';
// import 'package:videos_player/videos_player.dart';

// class PostFeed  {
//   final String nombreProfesor;
//   final String materia;
//   final VideoModelo video = new VideoModelo();

//    PostFeed({
//     Key key,
//     this.nombreProfesor,
//     this.materia,

//   });


//   Widget crearItem(BuildContext context, VideoModelo video) {

//     return Container(
//       color: Colors.white,
//       //shadowColor: Colors.black87,
//       margin: EdgeInsets.only(bottom: 20.0,),
//       child: Column(
//         children: <Widget>[

//           SizedBox(height: 12.0,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Row(
//                   children: <Widget>[
//                     SizedBox(width: 15.0,),
//                     CircleAvatar(radius: 20.0, backgroundColor: Colors.tealAccent, child: CircleAvatar( radius: 18.0, backgroundColor:Colors.grey,)),
//                     SizedBox(width: 8.0,),
//                     Text('Nombre Profesor', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),),
//                     //trailing: FlatButton.icon(onPressed: (){}, icon: Icon(FluentSystemIcons.ic_fluent_activity_regular) ,)
//                     //onTap: () => Navigator.pushNamed(context, 'reproductor', arguments: video)
//                   ]),
//               Container( margin: EdgeInsets.only(right: 15.0), height: 17.0, width: 17.0, child: Icon(FluentSystemIcons.ic_fluent_more_vertical_regular, color: Colors.black54,)),
//             ],
//           ),
//           SizedBox(height: 15.0,),

//           (video.videoUrl == null)
//               ? Image(image: AssetImage('assets/no-image.png'))
//               : VideosPlayer(
//                   networkVideos: [
//                     new NetworkVideo(
//                         id: "${ video.tituloVideo }",
//                         name: "${ video.tituloVideo }",
//                         videoUrl:
//                         "${ video.videoUrl }",
//                         thumbnailUrl:
//                         "${ video.fotoUrl }",
//                         videoControl: new NetworkVideoControl(
//                             showControlsOnInitialize: false,
//                             allowFullScreen: false
//                         )),
//                   ],
//                 ),

//           ListTile(
//               contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
//               title: Text('${ video.tituloVideo }', style: TextStyle(fontWeight: FontWeight.w400),),
//               subtitle: Text('${ video.videoUrl }', style: TextStyle(fontSize: 12.0),),
//               onTap: () => Navigator.pushNamed(context, 'reproductor', arguments: video)
//           ),
//           //SizedBox(height: 10.0,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               Text('Matematica', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w600, color: Colors.black54),),
//               Container( height: 18.0, width: 18.0, margin: EdgeInsets.only(right: 15.0, left: 5.0), decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.cyan), child: Icon(Icons.book, size: 10.0, color: Colors.white,), ),
//             ],
//           ),
//           Divider( indent: 20.0, endIndent: 20.0,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               FlatButton.icon(
//                   icon: Icon(FluentSystemIcons.ic_fluent_thumb_like_regular),
//                   label: Text('like'),
//                   textColor: Colors.black54,
//                   onPressed: (){}
//               ),
//               FlatButton.icon(
//                   icon: Icon(FluentSystemIcons.ic_fluent_chat_help_regular),
//                   label: Text('duda'),
//                   textColor: Colors.black54,
//                   onPressed: (){}
//               ),
//               FlatButton.icon(
//                   icon: Icon(FluentSystemIcons.ic_fluent_share_regular),
//                   label: Text('enviar'),
//                   textColor: Colors.black54,
//                   onPressed: (){}
//               ),
//             ],)
//         ],
//       ),
//     );
//   }

// }