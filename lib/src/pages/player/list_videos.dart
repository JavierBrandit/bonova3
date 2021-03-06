// import 'dart:async';

// import 'package:bonova0002/src/models/curso_modelo.dart';
// import 'package:bonova0002/src/models/video_modelo.dart';
// import 'package:bonova0002/src/services/videos_service.dart';
// import 'package:bonova0002/theme.dart';
// import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';

// class ListVideos extends StatefulWidget {
//   const ListVideos({Key key, @required this.clips}) : super(key: key);
//   final List<Video> clips;
//   @override
//   _ListVideosState createState() => _ListVideosState();
// }

// class _ListVideosState extends State<ListVideos> {
//   List<Video> get _clips {
//     return widget.clips;
//   }
//   VideoPlayerController _controller;
//   var _playingIndex = -1;
//   var _updateProgressInterval = 0.0;
//   var _disposed = false;
//   var _isFullScreen = false;
//   var _isEndOfClip = false;
//   var _showingDialog = false;
//   var _playing = false;
//   var _progress = 0.0;
//   Timer _timerVisibleControl;
//   double _controlAlpha = 1.0;
//   Duration _duration;
//   Duration _position;
//   VideoService videoService;
//   bool get _isPlaying {
//     return _playing;
//   }
//   set _isPlaying(bool value) {
//     _playing = value;
//     _timerVisibleControl?.cancel();
//     if (value) {
//       _timerVisibleControl = Timer(Duration(seconds: 2), () {
//         if (_disposed) return;
//         setState(() {
//           _controlAlpha = 0.0;
//         });
//       });
//     } else {
//       _timerVisibleControl = Timer(Duration(milliseconds: 200), () {
//         if (_disposed) return;
//         setState(() {
//           _controlAlpha = 1.0;
//         });
//       });
//     }
//   }
//   @override
//   void initState() { 
//     _initializeAndPlay(0);
//     super.initState();
//   }
//   @override
//   void dispose() {
//     _disposed = true;
//     _timerVisibleControl?.cancel();
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
//     _exitFullScreen();
//     _controller?.pause(); // mute instantly
//     _controller?.dispose();
//     _controller = null;
//   }
//   void _enterFullScreen() async {
//     debugPrint("enterFullScreen");
//     await SystemChrome.setEnabledSystemUIOverlays([]);
//     await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
//     if (_disposed) return;
//     setState(() {
//       _isFullScreen = true;
//     });
//   }
//   void _exitFullScreen() async {
//     debugPrint("exitFullScreen");
//     await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//     await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     if (_disposed) return;
//     setState(() {
//       _isFullScreen = false;
//     });
//   }
//   void _initializeAndPlay(int index) async {
//     print("_initializeAndPlay ---------> $index");
//     final clip = _clips[index];

//     final controller = VideoPlayerController.network( clip.path );

//     final old = _controller;
//     _controller = controller;
//     if (old != null) {
//       old.removeListener(_onControllerUpdated);
//       old.pause();
//       debugPrint("---- old contoller paused.");
//     }

//     debugPrint("---- controller changed.");
//     setState(() {});

//     controller
//       ..initialize().then((_) {
//         debugPrint("---- controller initialized");
//         old?.dispose();
//         _playingIndex = index;
//         _duration = null;
//         _position = null;
//         controller.addListener(_onControllerUpdated);
//         controller.play();
//         setState(() {});
//       });
//   }
//   void _onControllerUpdated() async {
//     if (_disposed) return;
//     // blocking too many updation
//     // important !!
//     final now = DateTime.now().millisecondsSinceEpoch;
//     if (_updateProgressInterval > now) {
//       return;
//     }
//     _updateProgressInterval = now + 500.0;

//     final controller = _controller;
//     if (controller == null) return;
//     if (!controller.value.initialized) return;
//     if (_duration == null) {
//       _duration = _controller.value.duration;
//     }
//     var duration = _duration;
//     if (duration == null) return;

//     var position = await controller.position;
//     _position = position;
//     final playing = controller.value.isPlaying;
//     final isEndOfClip = position.inMilliseconds > 0 && position.inSeconds + 1 >= duration.inSeconds;
//     if (playing) {
//       // handle progress indicator
//       if (_disposed) return;
//       setState(() {
//         _progress = position.inMilliseconds.ceilToDouble() / duration.inMilliseconds.ceilToDouble();
//       });
//     }

//     // handle clip end
//     if (_isPlaying != playing || _isEndOfClip != isEndOfClip) {
//       _isPlaying = playing;
//       _isEndOfClip = isEndOfClip;
//       debugPrint("updated -----> isPlaying=$playing / isEndOfClip=$isEndOfClip");
//       if (isEndOfClip && !playing) {
//         debugPrint("========================== End of Clip / Handle NEXT ========================== ");
//         final isComplete = _playingIndex == _clips.length - 1;
//         if (isComplete) {
//           print("played all!!");
//           if (!_showingDialog) {
//             _showingDialog = true;
//             _showPlayedAllDialog().then((value) {
//               _exitFullScreen();
//               _showingDialog = false;
//             });
//           }
//         } else {
//           _initializeAndPlay(_playingIndex + 1);
//         }
//       }
//     }
//   }
//   Future<bool> _showPlayedAllDialog() async {
//     return showDialog<bool>(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: SingleChildScrollView(child: Text("Fin del Curso")),
//           actions: <Widget>[
//             FlatButton(
//               child: Text("Ok"),
//               onPressed: () => Navigator.pop(context, true),
//             )
//           ],
//         );
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
//     videoService = Provider.of<VideoService>(context);
//     // final curso = videoService.getCurso();
    
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 107,
//           automaticallyImplyLeading: false,
//           // flexibleSpace: _reaccionar(),
//           title: Padding(
//             padding: EdgeInsets.all(4),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 3),
//                 Text(_playingIndex==-1
//                   ? ''
//                   : 'Clase '+(_playingIndex+1).toString()+':  '+ curso.videos[_playingIndex].titulo, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: -.2)),
//                 SizedBox(height: 3),
//                 Text(curso.profesor.nombre, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: -.2)),
//               ],
//             ),
//           ),
//           // actions: [
//           //   SizedBox(width: 40),
//           //   Expanded(child: botonReaccion(Icon(FluentIcons.bookmark_24_regular), (){}, 'Guardar')),        
//           //   Expanded(child: botonReaccion(Icon(FluentIcons.share_android_24_regular), (){}, 'Compartir')),       
//           //   Expanded(child: botonReaccion(Icon(FluentIcons.more_horizontal_24_filled),(){}, 'Opciones')),
//           //   SizedBox(width: 40),
//           // ],
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'clases'),
//               Tab(text: 'documentos'),
//               Tab(text: 'informacion'),
//             ]),
          
//           ),
//         body: TabBarView(
//           children: [
//             pageBody(0),
//             pageBody(1),
//             pageBody(2),
//           ],
//         ),
//         // PageView.builder(
//         //   itemCount: 3,
//         //   itemBuilder: (_,i) => pageBody(i)
//         // )
        
        
//         // CustomScrollView(
//         //   slivers: [
//         //     SliverAppBar(
//         //       automaticallyImplyLeading: false,
//         //       toolbarHeight: 80,
//         //       floating: true,
//         //       elevation: 0,
//         //       title: Expanded(child: _reaccionar()),
//         //     ),
//         //     SliverToBoxAdapter(
//         //     child: Column(
//         //       children: [
//         //         _listView(),
//         //         Container(
//         //           height: 800,
//         //           width: 2,
//         //           color: Colors.black
//         //         ),
//         //         // Container(
//         //         //   height: 400,
//         //         //   color: Colors.red
//         //         // ),

//         //       ],
//         //     ),
//         //   ),
//         //   ]),
//       ),
//     );
//   }

//   pageBody(int i){
//     videoService = Provider.of<VideoService>(context);
//     final curso = videoService.getCurso();
//     return CustomScrollView(
//           slivers: [
//             // i==0 ? 
//             // SliverAppBar(
//             //   automaticallyImplyLeading: false,
//             //   toolbarHeight: 80,
//             //   floating: true,
//             //   elevation: 0,
//             //   actions: 
//             //    [
//             //     SizedBox(width: 40),
//             //     Expanded(child: botonReaccion(Icon(FluentIcons.bookmark_24_regular), (){}, 'Guardar')),        
//             //     Expanded(child: botonReaccion(Icon(FluentIcons.share_android_24_regular), (){}, 'Compartir')),       
//             //     Expanded(child: botonReaccion(Icon(FluentIcons.more_horizontal_24_filled),(){}, 'Opciones')),
//             //     SizedBox(width: 40),
//             //   ],
//             //   bottom: TabBar(

//             //   // title: Expanded(child: _reaccionar()),
//             // ) : SliverToBoxAdapter(child: Text('')),
            
//             SliverToBoxAdapter(
//             child: Column(
//               children: [

               
                
//                 if (i == 0)
//                 _tabList(),
//                 if (i == 1)
//                 _tabSocial(curso),
//                 if (i == 2)
//                 _tabInfo(),
//                 // Container(
//                 //   height: 800,
//                 //   width: 2,
//                 //   color: Colors.black
//                 // ),
//                 // Container(
//                 //   height: 400,
//                 //   color: Colors.red
//                 // ),

//               ],
//             ),
//           ),
//           ]
//     );
//   }



//   _tabSocial(Curso curso){
//     return Padding(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top:15, bottom: 12),
//             child: Text('Acerca del profesor', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: -.4)),
//           ),
//           Row(
//             children: [
//               CircleAvatar(
//                   radius: 35,
//                 ),
//               SizedBox(width: 10),
//               Column( 
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                 Text(curso.profesor.nombre, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: -.4)),
//                 SizedBox(height: 4),
//                 Text('5', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: -.4)),

//               ])
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.only(top:15, bottom: 12),
//             child: Text('Valoración del curso', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: -.4)),
//           ),
//           Text('5.0', style: TextStyle(fontSize: 35
          
//           ),),
          
//           Padding(
//             padding: EdgeInsets.only(top:15, bottom: 12),
//             child: Text('¿Qué encontrarás en este curso?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: -.4)),
//           ),
//           listTileInfo('Dificultad', Icons.bar_chart, 'baja'),
//           listTileInfo('Duración total', Icons.bar_chart, 'baja'),
//           listTileInfo('Estudiantes', Icons.bar_chart, 'baja'),
//           listTileInfo('Audio', Icons.bar_chart, 'baja'),
//           listTileInfo('Ultima Actualización', Icons.bar_chart, 'baja'),

          

//         ],
//       ),
//     );
//   }
//   _tabInfo(){
//     return Column(
//       children: [
//         Text('ellow2'),
//         Container(),
//       ],
//     );
//   }

//   void _onTapCard(int index) {
//     _initializeAndPlay(index);
//   }

//   Widget _reaccionar(){
//     var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    
//     return Container(
//        color: isDarkTheme? BonovaColors.azulNoche[800] : Colors.white,
//       padding: EdgeInsets.symmetric(vertical: 7),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
//         children: [
          
//           botonReaccion(Icon(FluentIcons.bookmark_24_regular), (){}, 'Guardar'),        
//           botonReaccion(Icon(FluentIcons.share_android_24_regular), (){}, 'Compartir'),       
//           botonReaccion(Icon(FluentIcons.more_horizontal_24_filled),(){}, 'Opciones'),        


//         ]),
//     );
//   }

//   Widget botonReaccion(Widget icon, Function onTap, String label){
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton( icon: icon, onPressed: onTap, iconSize: 20),
//         Text( label, style: TextStyle( fontSize: 10, fontWeight: FontWeight.w600)),
//         SizedBox( height: 10 )
//       ]);          
//   }

//   Widget _tabList() {
//     // final _clips = Provider.of<VideoService>(context).getCurso().videos;
//     return ListView.builder(
//       padding: EdgeInsets.symmetric(vertical: 0),
//       itemCount: _clips.length,
//       shrinkWrap: true,
//       itemBuilder: (BuildContext context, int index) {
//         return InkWell(
//           borderRadius: BorderRadius.all(Radius.circular(6)),
//           splashColor: Colors.blue[100],
//           onTap: () {
//             _onTapCard(index);
//           },
//           child: _buildCard(index),
//         );
//       },
//     ).build(context);
//   }

//   Widget _buildCard(int index) {
//     var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
//     final clip = _clips[index];
//     final playing = index == _playingIndex;
//     return Container(
//         color: colorTira(playing),
//         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 22),
//         margin: EdgeInsets.only(top: 3),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[

//             Padding(
//               padding: EdgeInsets.only(right: 35, left: 10),
//               child: Text( (index + 1).toString(), style: TextStyle( fontSize: 14, fontWeight: FontWeight.w700 ), )
//             ),
//             Expanded(
//               child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text( clip.titulo, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: -.5)),
//                     Padding(
//                       child: Text("${clip.tituloMod}", style: TextStyle(fontSize: 13, color: Colors.grey[500], letterSpacing: -.5)),
//                       padding: EdgeInsets.only(top: 3),
//                     )
//                   ]),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: playing
//                   ? Icon(FluentIcons.arrow_download_16_regular, size: 20)
//                   : Icon(
//                       FluentIcons.arrow_download_16_regular,
//                       color: Colors.grey.withOpacity(0.5),
//                       size: 20,
//                     ),
//             ),
//           ],
//         ),
//     );
//   }

//   Color colorTira(bool playing) {
//     var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

//     if (playing) {
//       return isDarkTheme
//       ? Colors.blueGrey[900].withOpacity(0.5)
//       : Colors.tealAccent.withOpacity(.1);
//     } else {
//       return isDarkTheme
//       ? BonovaColors.azulNoche[800]
//       : Colors.grey[100];
//     }

//   }

//   listTileInfo(String titulo, IconData icon, String descripcion){
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [

//           Padding(
//             padding: EdgeInsets.only(right: 23),
//             child: Icon(icon, size: 18),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(titulo, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, letterSpacing: -.3)),
//               Text(descripcion, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: -.3),),
//             ],
//           )

//       ]),
//     );
//   }
// }
