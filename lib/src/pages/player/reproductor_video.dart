import 'dart:async';
import 'dart:math';
import 'package:bonova0002/home_page.dart';
import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/models/historial.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:bonova0002/theme.dart';

import 'package:flutter/services.dart';
import 'package:bonova0002/src/services/videos_service.dart';

import 'package:bonova0002/src/models/video_modelo.dart';
import 'package:video_player/video_player.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'list_videos.dart';

class PlayPage extends StatefulWidget {
  // PlayPage({Key key, @required this.clips}) : super(key: key);
  PlayPage({Key key, @required this.curso, @required this.historial}) : super(key: key);

  // final List<Video> clips;
  final Curso curso;
  final Historial historial;

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  VideoPlayerController _controller;

  List<Video> get _clips {
    return widget.curso.videos;
  }
  Curso get _curso {
    return widget.curso;
  }
  Historial get _historial {
    return widget.historial;
  }

  // VideoService videoService;
  CursoService cursoService;
  
  var _playingIndex = -1;
  var _disposed = false;
  var _isFullScreen = false;
  var _isEndOfClip = false;
  var _progress = 0.0;
  var _showingDialog = false;
  var _updateProgressInterval = 0.0;
  double _controlAlpha = 1.0;
  Timer _timerVisibleControl;
  Duration _duration;
  Duration _position;

  SocketService socketService;
  AuthService auth;
  var guardado = false;

  var _playing = false;
  bool get _isPlaying {
    return _playing;
  }

  // Historial historial;

  set _isPlaying(bool value) {
    _playing = value;
    _timerVisibleControl?.cancel();
    if (value) {
      _timerVisibleControl = Timer(Duration(seconds: 2), () {
        if (_disposed) return;
        setState(() {
          _controlAlpha = 0.0;
        });
      });
    } else {
      _timerVisibleControl = Timer(Duration(milliseconds: 200), () {
        if (_disposed) return;
        setState(() {
          _controlAlpha = 1.0;
        });
      });
    }
  }

  void _onTapVideo() {
    debugPrint("_onTapVideo $_controlAlpha");
    setState(() {
      _controlAlpha = _controlAlpha > 0 ? 0 : 1;
    });
    _timerVisibleControl?.cancel();
    _timerVisibleControl = Timer(Duration(seconds: 2), () {
      if (_isPlaying) {
        setState(() {
          _controlAlpha = 0.0;
        });
      }
    });
  }

  // void _escucharHistorial( dynamic payload ) {
    
  //   // Historial historial = new Historial(

  //   //   curso: payload.curso,
  //   //   // usuario: payload.usuario,
  //   //   progreso: payload?.progreso
  //   // );
  //   // setState(() {
  //   // });
  // }
  

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // final curso = _curso;
    // final historial = _historial;

    // this.socketService = Provider.of<SocketService>(context, listen: false );
    // this.socketService.socket.on('historial', (payload){
    //   _historial = Historial(
    //     usuario: payload['usuario'],
    //     curso: payload['usuario'],
    //     progreso: payload['usuario'],
    //     index: payload['usuario']
    //   );
    //       setState(() {});
    //   // print('payload ' + payload.toString());
    // });

    this.cursoService = Provider.of<CursoService>(context, listen: false );
    
    _initializeAndPlay( _historial.index!= null?  _historial.index  :0 );
    cursoService.setDisposed(false);
    super.initState();
  }

  @override
  void dispose() {
    _disposed = true;
    _timerVisibleControl?.cancel();
    // Screen.keepOn(false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _exitFullScreen();
    _controller?.pause(); // mute instantly
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  void _toggleFullscreen() async {
    if (_isFullScreen) {
      _exitFullScreen();
    } else {
      _enterFullScreen();
    }
  }

  void _enterFullScreen() async {
    debugPrint("enterFullScreen");
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    if (_disposed) return;
    setState(() {
      _isFullScreen = true;
    });
  }

  void _exitFullScreen() async {
    debugPrint("exitFullScreen");
    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (_disposed) return;
    setState(() {
      _isFullScreen = false;
    });
  }

  void _initializeAndPlay(int index) async {

    // final duration = _controller?.value?.duration ?? 0;
    // final progresx = _historial?.progreso ?? 0;
    // final posicion = Duration( seconds: (progresx * duration) .toInt() );
    // _historial.index = index;
    print("_initializeAndPlay ---------> $index");
    final clip = _clips[index];

    final controller = VideoPlayerController.network( clip.path );

    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdated);
      old.pause();
      debugPrint("---- old contoller paused.");
    }

    debugPrint("---- controller changed.");
    setState(() {});

    controller
      ..initialize().then((_) {
        debugPrint("---- controller initialized");
        old?.dispose();
        _playingIndex = index;
        _duration = null;
        _position = null;
        controller.addListener(_onControllerUpdated);
        controller.play();
        // controller.seekTo(posicion);
        setState(() {});
      });
  }

  void _onControllerUpdated() async {
    if (_disposed) return;
    // blocking too many updation
    // important !!
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_updateProgressInterval > now) {
      return;
    }
    _updateProgressInterval = now + 500.0;

    final controller = _controller;
    if (controller == null) return;
    if (!controller.value.initialized) return;
    if (_duration == null) {
      _duration = _controller.value.duration;
    }
    var duration = _duration;
    if (duration == null) return;

    var position = await controller.position;
    _position = position;
    final playing = controller.value.isPlaying;
    final isEndOfClip = position.inMilliseconds > 0 && position.inSeconds + 1 >= duration.inSeconds;
    if (playing) {
      // handle progress indicator
      if (_disposed) return;
      setState(() {
        _progress = position.inMilliseconds.ceilToDouble() / duration.inMilliseconds.ceilToDouble();
        // historial.progreso = _progress;
      });
      // await auth.agregarHistorial(historial);
    }

    // handle clip end
    if (_isPlaying != playing || _isEndOfClip != isEndOfClip) {
      _isPlaying = playing;
      _isEndOfClip = isEndOfClip;
      debugPrint("updated -----> isPlaying=$playing / isEndOfClip=$isEndOfClip");
      if (isEndOfClip && !playing) {
        debugPrint("========================== End of Clip / Handle NEXT ========================== ");
        final isComplete = _playingIndex == _clips.length - 1;
        if (isComplete) {
          print("played all!!");
          if (!_showingDialog) {
            _showingDialog = true;
            _showPlayedAllDialog().then((value) {
              _exitFullScreen();
              _showingDialog = false;
            });
          }
        } else {
          _initializeAndPlay(_playingIndex + 1);
        }
      }
    }
  }

  Future<bool> _showPlayedAllDialog() async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(child: Text("Fin del Curso")),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () => Navigator.pop(context, true),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    cursoService = Provider.of<CursoService>(context);
    // final curso = videoService.getCurso();
    final Size pantalla = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: _isFullScreen? BonovaColors.azulNoche[900] : null,
        // appBar: _isFullScreen? null
        //     : AppBar(
        //         toolbarHeight: 40,
        //         elevation: 0.0,
        //         title: Text('${_curso.titulo}  ·  ${_curso.nivel}º medio', style: TextStyle( fontSize: 19, letterSpacing: -1, fontWeight: FontWeight.w400 ))              
        //       ),
        body: _isFullScreen || MediaQuery.of(context).orientation == Orientation.landscape
            ? Center(
              child: Container(
                child: Expanded(child: _playView(context)),
                // height: double.infinity,
                // width: double.infinity,
                color: BonovaColors.azulNoche[900],
              ),
            )
            : Column(children: <Widget>[
                // Container(
                //   child:
                  //  Hero(
                  //    tag: 'player',
                  //    child: 
                     Center(child: _playView(context)),
                  //  ),
                  // decoration: BoxDecoration(color: Colors.black),
                // ),
                Expanded(
                  child: metodo(_curso) //ListVideos(clips: _clips),
                ),
              ]),
      ),
    );
  }

  // subirHistorial(Historial historial) async {
  //   await auth.agregarHistorial(historial);
  // }


  Widget _playView(BuildContext context) {
    // _isFullScreen;
    final controller = _controller;
    if (controller != null && controller.value.initialized) {
      
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: VideoPlayer(controller),
              onTap: _onTapVideo,
            ),
            _controlAlpha > 0
                ? AnimatedOpacity(
                    opacity: _controlAlpha,
                    duration: Duration(milliseconds: 250),
                    child: _controlView(context),
                  )
                : Container(  ),
          ],
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
            child: CircularProgressIndicator( strokeWidth: 1.5, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
        ),
      );
    }
  }

  Widget _controlView(BuildContext context) {
    return Hero(
      tag: 'player',
      child: Container(
        // width: double.infinity,
        color: Colors.black26,
        child: Column(
          children: [
            _topUI(),
            Expanded(
              child: _centerUI(),
            ),
            _bottomUI(),
            // _bottomUI2(),
          ],

        ),
      ),
    );
  }

  Widget _centerUI() {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        
        FlatButton(
          onPressed: () async {
            final index = _playingIndex - 1;
            if (index > 0 && _clips.length > 0) {
              _initializeAndPlay(index);
            }
          },
          child: Icon(
            FluentIcons.previous_24_filled,
            size: 25,
            color: Colors.white,
          ),
        ),
        FlatButton(
          
          onPressed: () async {
            if (_isPlaying) {
              // subirHistorial(_historial);
              _controller?.pause();
              _isPlaying = false;
            } else {
              final controller = _controller;
              if (controller != null) {
                final pos = _position?.inSeconds ?? 0;
                final dur = _duration?.inSeconds ?? 0;
                final isEnd = pos == dur - 1;
                if (isEnd) {
                  // subirHistorial(_historial);
                  _initializeAndPlay(_playingIndex);
                } else {
                  controller.play();
                }
              }
            }
            setState(() {});
          },
          child: _isPlaying 
          ? Icon( FluentIcons.pause_20_filled, size: 40, color: Colors.white )
          : Container(height: 35, width: 35, child: WebsafeSvg.asset('assets/bvPlay.svg', fit: BoxFit.contain, alignment: Alignment.center, color: Colors.white)),
        ),
        FlatButton(
          padding: EdgeInsets.all(10),
          onPressed: () async {
            final index = _playingIndex + 1;
            if (index < _clips.length - 1) {
              _initializeAndPlay(index);
            }
          },
          child: Icon(
            FluentIcons.next_24_filled,
            size: 25,
            color: Colors.white,
          ),
        ),
        // FlatButton(
        //   onPressed: () async {
        //     // final index = _playingIndex + 1;
        //     // if (index < _clips.length - 1) {
        //     //   _initializeAndPlay(index);
        //     // }
        //   },
        //   child: Icon(
        //     FluentSystemIcons.ic_fluent_timer_10_regular,
        //     size: 25,
        //     color: Colors.white,
        //   ),
        // ),
      ],
    ));
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _topUI() {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final controller = _controller;
    final noMute = (_controller?.value?.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final min = convertTwo(remained ~/ 60.0);
    final sec = convertTwo(remained % 60);
    const _examplePlaybackRates = [
      0.7,
      1.0,
      1.2,
      1.5,
      2.0,
      2.2
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[

        IconButton(
          icon: Icon( FluentIcons.chevron_down_12_regular, color: Colors.white,), 
          onPressed: (){
          //  cursoService.setReproduciendo(false);
           Navigator.pop(context);
          }
        ),
        
        PopupMenuButton(
            color: isDarkTheme? Colors.blueGrey[900].withOpacity(.55) : Colors.white.withOpacity(.85),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0.001,
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
              setState(() {});
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    height: 37,
                    value: speed,
                    child: Text('${speed}x', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: .2),),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right:4),
                    child: Icon(FluentIcons.top_speed_24_filled, color: Colors.white, size: 18,),
                  ),
                  Text(controller.value.playbackSpeed == 1.0 || controller.value.playbackSpeed == 2.0? '${controller.value.playbackSpeed.round()}x' : '${controller.value.playbackSpeed}x', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 15, letterSpacing: .2 ),),
                ],
              ),
            ),
          ),
      ],
    );
  }
  
  Widget _bottomUI() {

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final duration = _duration?.inSeconds ?? 0;
    final durationMin = _duration.inMinutes ?? 0;
    final position = _position?.inSeconds ?? 0;
    
    print(position.toString());
    print(_progress.toString());
    // _progress != null
    
    socketService.emit('historial', {
        'curso': _curso.cid,
        'usuario': authService.usuario.uid,
        'progreso': _progress,
        'index': _playingIndex
    });
    
    final positionMin = _position?.inMinutes ?? 0;
    // final headMin = _position?.inMinutes ?? 0;

    // final remained = max(0, duration - head);
    final minPos = positionMin ~/ 60.0;
    final secPos = convertTwo(position % 60);

    // final secPos = convertTwo(_position.inSeconds % 60);
    final miniDur = durationMin ~/ 60;
    final secDur = convertTwo(duration % 60);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "$minPos:$secPos / $miniDur:$secDur",
                  style: TextStyle(
                    color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.2,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 1.0),
                        blurRadius: 4.0,
                        color: Color.fromARGB(150, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(width: 180),
              // _isFullScreen 
              //     ? 
                  Expanded(
                      child:  Slider(
                        // activeColor: Colors.tealAccent[700],
                        // inactiveColor: Colors.white38,
                        value: max(0, min(_progress * 100, 100)),
                        min: 0,
                        max: 100,
                        onChanged: (value) {
                          // final pos = _controller?.value?.position;
                          // print('value: $pos');
                          // print('progress: '+ _progress.toString());
                          setState(() {
                            _progress = value * 0.01;
                            // _historial.progreso = _progress;
                          });
                        },
                        onChangeStart: (value) {
                          debugPrint("-- onChangeStart $value");
                          _controller?.pause();
                        },
                        onChangeEnd: (value) {
                          debugPrint("-- onChangeEnd $value");
                          final duration = _controller?.value?.duration;
                          if (duration != null) {
                            var newValue = max(0, min(value, 99)) * 0.01;
                            var millis = (duration.inMilliseconds * newValue).toInt();
                            _controller?.seekTo(Duration(milliseconds: millis));
                            _controller?.play();
                          }
                        },
                      ),
                    ),
                  // : Container(), 
              IconButton(
                color: Colors.yellow,
                icon: Icon(
                  FluentIcons.arrow_expand_24_regular,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: _toggleFullscreen,
              ),
            ],
          ),
        ],
      ),
    );
  }


















  Widget metodo(Curso curso){

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 107,
          automaticallyImplyLeading: false,
          // flexibleSpace: _reaccionar(),
          title: Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3),
                Text(_playingIndex==-1
                  ? ''
                  : curso.titulo, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: -.2)),
                SizedBox(height: 3),
                Text(_playingIndex==-1
                  ? ''
                  : 'Clase '+(_playingIndex+1).toString()+':  '+ curso.videos[_playingIndex].titulo, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: -.2)),
                SizedBox(height: 3),
                // Text(curso.profesor.nombre, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: -.2)),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(FluentIcons.more_vertical_16_regular), 
              onPressed: (){
                menuMore();
              },
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'clases'),
              Tab(text: 'informacion'),
              // Tab(text: 'documentos'),
            ]),
          
          ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            pageBody(0),
            pageBody(1),
            // pageBody(2),
          ],
        ),
        // PageView.builder(
        //   itemCount: 3,
        //   itemBuilder: (_,i) => pageBody(i)
        // )
        
        
        // CustomScrollView(
        //   slivers: [
        //     SliverAppBar(
        //       automaticallyImplyLeading: false,
        //       toolbarHeight: 80,
        //       floating: true,
        //       elevation: 0,
        //       title: Expanded(child: _reaccionar()),
        //     ),
        //     SliverToBoxAdapter(
        //     child: Column(
        //       children: [
        //         _listView(),
        //         Container(
        //           height: 800,
        //           width: 2,
        //           color: Colors.black
        //         ),
        //         // Container(
        //         //   height: 400,
        //         //   color: Colors.red
        //         // ),

        //       ],
        //     ),
        //   ),
        //   ]),
      ),
    );
  }
  pageBody(int i){
    cursoService = Provider.of<CursoService>(context, listen: false);
    final historial = cursoService.getHistorial();
    return CustomScrollView(
          slivers: [
            // i==0 ? 
            // SliverAppBar(
            //   automaticallyImplyLeading: false,
            //   toolbarHeight: 80,
            //   // snap: true,
            //   // snap: true,
            //   floating: true,
            //   elevation: 0,
            //   actions: 
            //    [
            //     SizedBox(width: 40),
            //     Expanded(child: botonReaccion(Icon(FluentIcons.bookmark_24_regular), (){}, 'Guardar')),        
            //     Expanded(child: botonReaccion(Icon(FluentIcons.share_android_24_regular), (){}, 'Compartir')),       
            //     Expanded(child: botonReaccion(Icon(FluentIcons.more_horizontal_24_filled),(){}, 'Opciones')),
            //     SizedBox(width: 40),
            //   ],
            //   bottom: TabBar(
            //     tabs: [
            //         Tab(text: 'clases'),
            //         Tab(text: 'documentos'),
            //         Tab(text: 'informacion'),
            //     ]),
            //   // title: Expanded(child: _reaccionar()),
            // ), //: SliverToBoxAdapter(child: Text('')),
            
            SliverToBoxAdapter(
            child: Column(
              children: [

               
                
                if (i == 0)
                _tabList(),
                if (i == 1)
                _tabSocial(historial.curso),
                // if (i == 2)
                // _tabInfo(historial.curso),
                // Container(
                //   height: 800,
                //   width: 2,
                //   color: Colors.black
                // ),
                // Container(
                //   height: 400,
                //   color: Colors.red
                // ),

              ],
            ),
          ),
          ]
    );
  }



  _tabSocial(Curso curso){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top:15, bottom: 12),
            child: Text('Acerca del profesor', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: -.4)),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(curso.profesor.foto),
                ),
              SizedBox(width: 20),
              Column( 
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                SizedBox(height: 10),
                Text(curso.profesor.nombre, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: -.3)),
                SizedBox(height: 5),
                Text('"'+curso.profesor.descripcion+'"', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: -.2)),
                SizedBox(height: 8),
                Text('Contactar', style: TextStyle(color: Colors.tealAccent[700], fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: -.4)),

              ])
            ],
          ),
          SizedBox( height: 20),
          Padding(
            padding: EdgeInsets.only(top:15, bottom: 12),
            child: Text('Valoración del curso', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: -.4)),
          ),
          Text('4.8 /5', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300
          
          ),),
          
          SizedBox( height: 20),
          
          Padding(
            padding: EdgeInsets.only(top:15, bottom: 12),
            child: Text('¿Qué encontrarás en este curso?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: -.4)),
          ),
          listTileInfo('Dificultad', FluentIcons.data_line_24_regular, 'baja'),
          listTileInfo('Duración total', FluentIcons.timer_16_regular, '2 h 41 min' ),
          listTileInfo('Estudiantes', FluentIcons.hat_graduation_16_regular, '27k'),
          listTileInfo('Audio', FluentIcons.speaker_2_16_regular, 'español'),
          listTileInfo('Ultima Actualización', FluentIcons.calendar_ltr_24_regular, curso.updatedAt.day.toString() +' - '+ curso.updatedAt.month.toString() +' - '+ curso.updatedAt.year.toString()  )

          

        ],
      ),
    );
  }

  menuMore(){
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final names = [
      'Consultar al profesor',
      'Conectar',
      'Compartir',
      'Calificar',
      'Cómo podemos ayudarte'
    ];

    final icons = [
      FluentIcons.chat_16_regular,
      FluentIcons.person_add_24_regular,
      FluentIcons.arrow_reply_16_regular,
      FluentIcons.star_16_regular,
      FluentIcons.chat_help_24_regular,

    ];


    showModalBottomSheet(
      backgroundColor: isDarkTheme? BonovaColors.azulNoche[800] : Colors.blueGrey[50],
      context: context, 
      builder: (_){
        return ListView.builder(
          padding: EdgeInsets.only( top: 20, left: 5),
          itemCount: names.length,
          itemBuilder: (_,i){
            return ListTile(
              // contentPadding: EdgeInsets.only( left: 10),
              title: Text(names[i], style: TextStyle( fontWeight: FontWeight.w500 ),),
              leading: Icon(icons[i], color: isDarkTheme? Colors.grey[50] : Colors.grey[900]),
            );
          },
        );
      }
    );
  }

  _tabInfo(Curso curso) {
    final auth = Provider.of<AuthService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    final cursoService = Provider.of<CursoService>(context);
    final usuario = auth.usuario;
    // final historial = new Historial(
    //     curso: curso.cid,
    //     progreso: 0.1,
    //     );

    
    // var guardado = auth.getGuardado(usuario, _curso);
    // final gg = auth.getGg();

    guardado = _historial?.guardado?? false;

    return Column(
      children: [

        (guardado == null)
          ? CircularProgressIndicator()
          : 
          Center(child: IconButton(
          icon: 
          // _historial.guardado != null 
          //   ? 
          //   guardado? Icon( FluentIcons.bookmark_16_filled) : Icon( FluentIcons.bookmark_16_regular)
          //   : 
            cursoService.getGuardado()? Icon( FluentIcons.bookmark_16_filled) : Icon( FluentIcons.bookmark_16_regular),
          
          onPressed: () {

            print('onTap');
            if (guardado == true) {
              
              cursoService.setGuardado(false);
              socketService.emit('historial', {
                'curso': curso.cid,
                'usuario': usuario.uid,
                'guardado': false
              });
              setState(() {});
              
            } else {

              cursoService.setGuardado(true);
              socketService.emit('historial', {
                'curso': curso.cid,
                'usuario': usuario.uid,
                'guardado': true
              });

              setState(() {});

            }
            

            // if (curso.guardado || guardado) {
            //   await auth.borrarGuardado(context, curso);
              // final gg = auth.setGuardado(false, curso);

            //   return gg;

            // } else {
            //   await auth.agregarGuardado(context, curso);
            //   final gg = auth.setGuardado(true, curso);

            //   setState(() {});
            //   return gg;
            // }
          },

        ))
      ],
    );
  }

  Widget _tabList() {
    // final _clips = Provider.of<VideoService>(context).getCurso().videos;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      controller: ScrollController(),
      padding: EdgeInsets.symmetric(vertical: 0),
      itemCount: _clips.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          splashColor: Colors.blue[100],
          onTap: () {
            _onTapCard(index);
          },
          child: _buildCard(index),
        );
      },
    ).build(context);
  }

  void _onTapCard(int index) {
    _initializeAndPlay(index);
  }

  Widget _reaccionar(){
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
       color: isDarkTheme? BonovaColors.azulNoche[800] : Colors.white,
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        children: [
          
          botonReaccion(Icon(FluentIcons.bookmark_24_regular), (){}, 'Guardar'),        
          botonReaccion(Icon(FluentIcons.share_android_24_regular), (){}, 'Compartir'),       
          botonReaccion(Icon(FluentIcons.more_horizontal_24_filled),(){}, 'Opciones'),        


        ]),
    );
  }

  Widget botonReaccion(Widget icon, Function onTap, String label){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton( icon: icon, onPressed: onTap, iconSize: 20),
        Text( label, style: TextStyle( fontSize: 10, fontWeight: FontWeight.w600)),
        SizedBox( height: 10 )
      ]);          
  }

  Widget _buildCard(int index) {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final clip = _clips[index];
    final playing = index == _playingIndex;
    return Container(
        color: colorTira(playing),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 22),
        margin: EdgeInsets.only(top: 3),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(right: 35, left: 10),
              child: Text( (index + 1).toString(), style: TextStyle( fontSize: 14, fontWeight: FontWeight.w700 ), )
            ),
            Expanded(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text( clip.titulo, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: -.5)),
                    Padding(
                      child: Text("${clip.tituloMod}", style: TextStyle(fontSize: 13, color: Colors.grey[500], letterSpacing: -.5)),
                      padding: EdgeInsets.only(top: 3),
                    )
                  ]),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: playing
                  ? Icon(FluentIcons.arrow_download_16_regular, size: 20)
                  : Icon(
                      FluentIcons.arrow_download_16_regular,
                      color: Colors.grey.withOpacity(0.5),
                      size: 20,
                    ),
            ),
          ],
        ),
    );
  }

  Color colorTira(bool playing) {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    if (playing) {
      return isDarkTheme
      ? Colors.blueGrey[900].withOpacity(.5)
      : Colors.blueGrey[50].withOpacity(.3);
    } else {
      return isDarkTheme
      ? BonovaColors.azulNoche[800]
      : Colors.grey[50];
    }

  }

  listTileInfo(String titulo, IconData icon, String descripcion){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [

          Padding(
            padding: EdgeInsets.only(right: 23),
            child: Icon(icon, size: 18),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, letterSpacing: -.3)),
              Text(descripcion, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: -.3),),
            ],
          )

      ]),
    );
  }




}



