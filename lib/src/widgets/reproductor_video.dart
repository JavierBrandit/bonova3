import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:bonova0002/src/models/video_modelo.dart';
import 'package:bonova0002/src/services/videos_service.dart';

class BonovaPlayer extends StatefulWidget {
  //BonovaPlayer({Key key}) : super(key: key);
  @override
  _BonovaPlayerState createState() => _BonovaPlayerState();
}

class _BonovaPlayerState extends State<BonovaPlayer> {

  VideoService videoService;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  Video video;
  int currentIndex;
  Size pantalla;
  VideoPlayerValue value;
  Key key;
  // Duration duration;
  // Duration position;

  @override
  void initState() {
    
    this.videoService = Provider.of<VideoService>(context, listen: false);
    this.currentIndex = videoService.indexVideo;
    this.video = videoService.curso.videos[ currentIndex ];
    _controller = VideoPlayerController.network( video.path );
    _initializeVideoPlayerFuture = _controller.initialize();
    this.value = _controller.value;
    _controller.play();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    pantalla = MediaQuery.of(context).size;

    return Container(
       child: Stack(
         fit: StackFit.passthrough,
         children : [
           crearPlayer(),
           controles(pantalla),
           VideoProgressIndicator(_controller, colors: VideoProgressColors(), allowScrubbing: true,)


           //_ControlsOverlay( controller: _controller )
         ]
       ),
    );
  }

  Widget crearPlayer() { 
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if ( snapshot.connectionState == ConnectionState.done ) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      );
  }


  Widget controles( Size p ) {
    return Container(
      color: Colors.transparent,
      height: p.width * 9/16 ,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          controlesArriba(),
          
          IconButton(
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
            icon: _controller.value.isPlaying 
              ? Icon( Icons.pause, color: Colors.white, size: 40, )
              : SvgPicture.asset('assets/bvPlay.svg', color: Colors.white, height: 30)
          ),

          controlesAbajo(),

        ],
      ),
    ); 
  }

  Widget controlesArriba() {
    return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
              Row( children: [
                     Container( height: 20, width: 20, color: Colors.red),
              
              ]),
                
              Row( children: [
                     Container( height: 20, width: 20, color: Colors.red),
                     SizedBox( width: 20 ),
                     Container( height: 20, width: 20, color: Colors.greenAccent),
                     SizedBox( width: 20 ),
                     Container( height: 20, width: 20, color: Colors.red),
              ]),
               
            ]),
          );
  }
  Widget controlesAbajo() {
    return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
              Row( children: [
                    // Text( '${value.position.inMinutes}:${value.position.inSeconds} / ${value.duration.inMinutes}:${value.duration.inSeconds}', 
                    //   style: TextStyle( color: Colors.white ) ),
                    //  Container( height: 20, width: 20, color: Colors.red),
                     SizedBox( width: 20 ),
                    //  Slider( 
                    //    value: value.position.inSeconds.toDouble(), 
                    //    onChanged:
                    //  ),
                    //Container( height: 20, width: 230, color: Colors.red),

                     
              
              ]),
                
              Row( children: [
                     Container( height: 20, width: 20, color: Colors.red),
                     SizedBox( width: 20 ),
                     Container( height: 20, width: 20, color: Colors.greenAccent),
                     SizedBox( width: 20 ),
                     Container( height: 20, width: 20, color: Colors.red),
              ]),
               
            ]),
          );
  }
 

}




class _ControlsOverlay extends StatelessWidget {
  const 
  _ControlsOverlay({Key key, this.controller}) : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: PopupMenuButton<double>(
        //     initialValue: controller.value.playbackSpeed,
        //     tooltip: 'Playback speed',
        //     onSelected: (speed) {
        //       controller.setPlaybackSpeed(speed);
        //     },
        //     itemBuilder: (context) {
        //       return [
        //         for (final speed in _examplePlaybackRates)
        //           PopupMenuItem(
        //             value: speed,
        //             child: Text('${speed}x'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${controller.value.playbackSpeed}x'),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
