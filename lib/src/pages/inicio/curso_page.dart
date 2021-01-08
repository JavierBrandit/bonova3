import 'package:bonova0002/home_page.dart';
import 'package:bonova0002/src/widgets/reproductor_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'dart:ui';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/src/models/video_modelo.dart';
import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:video_player/video_player.dart';

class CursoPage extends StatefulWidget {

  @override
  _CursoPageState createState() => _CursoPageState();
}

class _CursoPageState extends State<CursoPage> {
  
  VideoPlayerController _controller;
  VideoPlayerValue value;
  Future<void> _initializeVideoPlayerFuture;
  ScrollController _scrollController;
  
  VideoService videoService;
  List<Video> videos = [];
  Video video;
  int indexx = 0;
  Curso curso;

  @override
  void initState() { 
    super.initState();
    this.videoService = Provider.of<VideoService>(context, listen: false);
    this._cargarVideos(videoService.getCurso());
  }

    
  @override
  Widget build(BuildContext context) {

    videoService = Provider.of<VideoService>(context);
    curso = videoService.getCurso();
    video = videoService.getVideo();
    indexx = videoService.getIndex();
    
    Size pantalla = MediaQuery.of(context).size;

    return Scaffold(
        body: CustomScrollView(
          //controller: _scrollController,
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
                          
            SliverAppBar(title: Text(curso.videos[indexx].titulo), elevation: 0.0, pinned: true, toolbarHeight: 55, ),
            // SliverAppBar(
            //   //title: crearPlayer(),
            //   //titleSpacing: 0,
            //   backgroundColor: Colors.grey[900],
            //   automaticallyImplyLeading: false,
            //   pinned: true,
            //   elevation: 0.0,
            //   collapsedHeight: 210,

            //   flexibleSpace: FlexibleSpaceBar( title: crearPlayer(), centerTitle: true,),
            // ),
            SliverToBoxAdapter( child: Column(
              children: <Widget>[

                // Container( 
                //   width: double.infinity,
                //   height: pantalla.width * 9/16,
                //   child: KiddVideoPlayer(
                //     fromUrl: true, 
                //     videoUrl: '${curso.videos[indexx].path}',
                //     layoutConfigs: KiddLayoutConfigs(
                //       showVolumeControl: false,
                //       backgroundSliderColor: Colors.white24,
                //       // playIcon: FluentSystemIcons.ic_fluent_play_filled
                //     ),
                //   )),

                // BonovaPlayer(),
                // PlayPage( clips: curso.videos,),
                _listVideos(),


              ],
            )),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     setState(() {
        //       if (_controller.value.isPlaying) {
        //         _controller.pause();
        //       } else {
        //         _controller.play();
        //       }
        //     });
        //   },
        //   child: _controller.value.isPlaying 
        //     ? Icon( Icons.pause )
        //     : SvgPicture.asset('assets/bvPlay.svg', color: Colors.white, height: 15,)
        // ),
        
    );

    
  }


  _cargarVideos( Curso cursox) async {
    this.videos = cursox.videos;
    setState((){});
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    //_refreshController.refreshCompleted();
  }

  ListView _listVideos() {
    return ListView.separated(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, i) => _videoListTile(videos[i], i), 
      separatorBuilder: (_, i) => Divider(), 
      itemCount: videos.length
    );
  }

  ListTile _videoListTile(Video video, int i ) {
    return ListTile(
        title: Text( video.titulo, style: TextStyle( fontWeight: FontWeight.w500, fontSize: 15), ),
        // subtitle: Text( video.path, style: TextStyle( color: Colors.grey[400]) ),
        onTap: () async {
          final videoService = Provider.of<VideoService>(context, listen: false);
          //TO DO:
          // videoService.indexVideo = index;
          // videoService.setVideo( video );
          videoService.setIndex( i );
          print(videoService.getIndex());
          // print(video.titulo);
          // await _controller.initialize();
          setState(() {});
          
          

        },
      );
  }

}

