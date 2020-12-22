import 'dart:ui';
import 'package:bonova0002/src/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/rendering.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:bonova0002/src/widgets/carrusel_profesores.dart';
import 'package:bonova0002/src/widgets/portadas_categorias.dart';
import 'package:bonova0002/src/services/usuarios_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {

  ScrollController _scrollController;
  List<Usuario> usuarios = [];
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final usuarioService = new UsuarioService();
  Color grisfondo = Colors.grey[850];



  @override
  void initState() {
    _cargarUsuarios();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Size pantalla = MediaQuery.of(context).size;
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
        //backgroundColor: Colors.grey[50],
        extendBodyBehindAppBar: true,
        appBar: AppBar( toolbarHeight: 0, elevation: 0,),
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[

              _crearAppbar(),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    //SizedBox(height: 80),
                    //CarruselProfesores( usuarios: usuarios ),
                    //_listUsuarios(),
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

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      //brightness: Brightness.light,
      //backgroundColor: Colors.white,
      //expandedHeight: 75.0,
      collapsedHeight: 75,
      elevation: 0,
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
                    color: isDarkTheme? Colors.tealAccent[400] : Colors.teal,
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
                  color: isDarkTheme? Colors.grey[100] : Colors.grey[600],
                  onPressed: () => Navigator.pushNamed(context, 'upload'),
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/send.svg', height: 20.0, width: 20.0, color: isDarkTheme? Colors.white : Colors.grey[600],),
                  //color:  Colors.teal,
                  onPressed: () => Navigator.pushNamed(context, 'usuarios-chat'),
                ),
                SizedBox(width: 12.0,)
              ],)
            ] ),
      ),
    );
  }

  _cargarUsuarios() async {
    
    this.usuarios = await usuarioService.getUsuarios();
    setState(() {});

    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    //_refreshController.refreshCompleted();
  }
  _listUsuarios() {
    return ListView.builder(
      shrinkWrap: true,
      controller: ScrollController(),
      scrollDirection: Axis.horizontal,
      itemCount: usuarios.length,
      itemBuilder: ( _ , i ) => _itemUsuario( usuarios[i] )
    );
  }
  _itemUsuario( Usuario u ) {
    return Column(
      children: [
        Text(u.nombre),
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.teal,
        ),
      ],
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