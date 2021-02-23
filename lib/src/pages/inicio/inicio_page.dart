import 'dart:ui';
import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/src/widgets/carrusel_horizontal.dart';
import 'package:bonova0002/src/widgets/header_titulo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/rendering.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:bonova0002/src/widgets/portadas_categorias.dart';
import 'package:bonova0002/src/services/usuarios_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {

  final cursoService = new CursoService();
  ScrollController _scrollController;
  PageController _pageController;
  List<Usuario> usuarios = [];
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final usuarioService = new UsuarioService();
  Color grisfondo = Colors.grey[850];
  List<Curso> cursosUltimos = [];



  @override
  void initState() {
    this._cargarUsuarios();
    this._cargarUltimosCursos();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 25),
                      child: CrearPortadas(pantalla:pantalla),
                    ),
                    _listViewUsuarios(),
                    SizedBox(height: 15),

                    HeaderTitulo(titulo: 'Sugeridos Para Ti', paginaDestino: '',),
                    SizedBox(height: 8),
                    _listaCursos(),
                    SizedBox(height: 80),
                  ],
                ),
              ),

            ],
          ),
        ),
    );

  }

  _cargarUsuarios() async {

    this.usuarios = await usuarioService.getUsuarios();
    setState(() {});
  }
  Widget _listViewUsuarios() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderTitulo( titulo: 'Profesores Particulares', paginaDestino: '' ),
        SizedBox(height: 5),
        Container(
          height: 130,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 13),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: usuarios.length,
            itemBuilder: (_, i) => _itemUsuario(usuarios[i])
            ),
        ),
      ],
    );
  }
  _itemUsuario( Usuario u ) {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Navigator.pushNamed( context, 'perfil', arguments: u ),
      child: Container(
        width: 95,
        padding: EdgeInsets.symmetric( horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            u.foto == '' || u.foto == null
            ? CircleAvatar(
              radius: 32,
              backgroundColor: isDarkTheme ? Colors.teal[800] : Colors.tealAccent[100],
              child: Text( u.nombre.substring(0,2), style: TextStyle( color: isDarkTheme ? Colors.white : Colors.teal[900] ))
            )
            : CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(u.foto),
            ),
            SizedBox(height: 8),
            Text( u.nombre, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
              style: TextStyle(
                       fontSize: 10.5, letterSpacing: -.5,
                       fontWeight: FontWeight.w500 
                       ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }


  _cargarUltimosCursos() async {
    this.cursosUltimos = await cursoService.getAllCursos();
    setState((){});
  }
  // Widget _listaCursos() {

  //   return Container(
  //     height: 270,
  //     child: PageView.builder(
  //       physics: BouncingScrollPhysics(),
  //       pageSnapping: false,
  //       itemBuilder: (_, i) => carruselHorizontala(context, cursosUltimos[i]),
  //       itemCount: cursosUltimos.length,
  //       controller: PageController(
  //         viewportFraction: 0.57 ), 
  //     ),
  //   );
  // }
  
  Widget _listaCursos() {
    return Container(
      height: 270,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 13),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        // pageSnapping: false,
        itemBuilder: (_, i) => carruselHorizontal(context, cursosUltimos[i]),
        itemCount: cursosUltimos.length,
        controller: _scrollController,
      //   controller: PageController(
      //     viewportFraction: 0.57 ), 
      ),
    );
  }

  Widget _crearAppbar() {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      toolbarHeight: 60,
      elevation: 0,
      floating: true,
      pinned: true,
      snap: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 15.0),

        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                margin: EdgeInsets.only(left: 24.0),
                child: Padding(
                  padding: const EdgeInsets.only(top:8),
                  child: SvgPicture.asset('assets/bv_ic.svg',
                    color: isDarkTheme? Colors.tealAccent : Colors.teal[600],
                    alignment: Alignment.bottomCenter,
                    height: 27.0,
                    fit: BoxFit.cover,),
                ),
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(top:3, right: 15),
                  child: IconButton(
                    icon: SvgPicture.asset('assets/sendd.svg', height: 21, width: 21, color: isDarkTheme? Colors.tealAccent : Colors.teal[700],),
                    onPressed: () => Navigator.pushNamed(context, 'usuarios-chat'),
                  ),
                ),
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