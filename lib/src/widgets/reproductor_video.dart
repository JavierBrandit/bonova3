import 'dart:async';
import 'dart:math';
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

import 'list_videos.dart';

class PlayPage extends StatefulWidget {
  PlayPage({Key key, @required this.clips}) : super(key: key);

  final List<Video> clips;

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  VideoPlayerController _controller;

  List<Video> get _clips {
    return widget.clips;
  }
  VideoService videoService;
  
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

  var _playing = false;
  bool get _isPlaying {
    return _playing;
  }

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

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _initializeAndPlay(0);
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
      });
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

    videoService = Provider.of<VideoService>(context);
    final curso = videoService.getCurso();
    final Size pantalla = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _isFullScreen? null
          : AppBar(
              elevation: 0.0,
              title: Text('${curso.titulo}  ·  ${curso.nivel}º medio', style: TextStyle( fontSize: 19, letterSpacing: -1, fontWeight: FontWeight.w400 ))              
            ),
      body: _isFullScreen
          ? Container(
            child: Center(child: _playView(context)),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.black),
          )
          : Column(children: <Widget>[
              Container(
                child: Center(child: _playView(context)),
                decoration: BoxDecoration(color: Colors.black),
              ),
              Expanded(
                child: ListVideos(clips: _clips),
              ),
            ]),
    );
  }


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
                : Container( height: 800 ),
          ],
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Center(
            child: CircularProgressIndicator( strokeWidth: 1.5, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
        ),
      );
    }
  }

  Widget _controlView(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Expanded(
        child: Column(
          children: <Widget>[
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
              _controller?.pause();
              _isPlaying = false;
            } else {
              final controller = _controller;
              if (controller != null) {
                final pos = _position?.inSeconds ?? 0;
                final dur = _duration?.inSeconds ?? 0;
                final isEnd = pos == dur - 1;
                if (isEnd) {
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
          : Container(height: 35, width: 35, child: SvgPicture.asset('assets/bvPlay.svg', fit: BoxFit.contain, alignment: Alignment.center, color: Colors.white)),
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        
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

    final duration = _duration?.inSeconds ?? 0;
    final durationMin = _duration.inMinutes ?? 0;
    final position = _position?.inSeconds ?? 0;
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
                          setState(() {
                            _progress = value * 0.01;
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



}

