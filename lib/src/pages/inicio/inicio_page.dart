import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

import 'package:bonova0002/src/models/video_modelo.dart';
import 'package:bonova0002/src/widgets/portadas_categorias.dart';
import 'package:bonova0002/src/widgets/post_feed.dart';

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {

  //VideoPlayerController _videoPlayerController;
  //ChewieController _chewieController;
  ScrollController _scrollController;
  //final VideosProvider videosProvider = new VideosProvider();
  //final VideoModelo videoModelo = new VideoModelo();
  //final  fire = new FirebaseServicios();
  //final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Size pantalla = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.grey[50],
        extendBodyBehindAppBar: true,
        //floatingActionButton: FloatingActionButton(child: Icon(FluentSystemIcons.ic_fluent_video_filled), onPressed: () => Navigator.pushNamed(context, 'upload'),),
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[

              _crearAppbar(),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30.0,),
                    //CarruselProfesores(),
                    CrearPortadas(pantalla:pantalla),
                    //_listadoCarrusel(),
                    SizedBox(height: 60.0,),
                    //_crearListadoPost(),
                  ],
                ),
              ),

            ],
          ),
        ),
    );

  }

  Widget _crearAppbar() {
    return SliverAppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.grey[50],
      //expandedHeight: 75.0,
      collapsedHeight: 60.0,
      elevation: 0.0,
      floating: true,
      pinned: true,
      snap: false,
      //leading: ,
      //title: Text('bonova'),
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 15.0),

        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Container(
                margin: EdgeInsets.only(left: 24.0),
                child: Padding(
                  padding: const EdgeInsets.only(top:0.0),
                  child: SvgPicture.asset('assets/bv_ic.svg',
                    color: Colors.teal,
                    alignment: Alignment.bottomCenter,
                    height: 27.0,
                    fit: BoxFit.cover,),
                ),
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                IconButton(
                  icon: Icon(FluentSystemIcons.ic_fluent_upload_filled),
                  color: Colors.teal,
                  onPressed: () => Navigator.pushNamed(context, 'upload'),
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/send.svg', height: 20.0, width: 20.0, color: Colors.teal,),
                  color: Colors.teal,
                  onPressed: () => Navigator.pushNamed(context, 'usuarios-chat'),
                ),
                SizedBox(width: 12.0,)
              ],)
            ] ),
      ),
    );
  }

  // Widget _crearListadoPost() {
  //   return FutureBuilder(
  //       //future: Future,
  //       builder: (BuildContext context, AsyncSnapshot<List<VideoModelo>> snapshot) {
  //         if (snapshot.hasData) {
  //           final videos = snapshot.data;
  //           final post = PostFeed();
  //           print(videos);

  //             return ListView.builder(
  //                 shrinkWrap: true,
  //                 controller: _scrollController,
  //                 itemCount: videos.length,
  //                 itemBuilder: (context, i) =>
  //                     post.crearItem(context, videos[i]),
  //                 );
  //         } else {
  //               return Container(
  //                   height: 500.0,
  //                   child: Center(child: CircularProgressIndicator()));
  //         }
  //       }
  //   );
  // }


}