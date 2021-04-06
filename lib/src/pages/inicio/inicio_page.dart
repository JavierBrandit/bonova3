import 'dart:ui';
import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/models/historial.dart';
import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/src/widgets/carrusel_horizontal.dart';
import 'package:bonova0002/src/widgets/header_titulo.dart';
import 'package:bonova0002/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/rendering.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:bonova0002/src/widgets/portadas_categorias.dart';
import 'package:bonova0002/src/services/usuarios_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:websafe_svg/websafe_svg.dart';


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
  List cursosUltimos;
  List historial;
  AuthService authService = AuthService();
  SocketService socketService;

  
  @override
  void initState() {
    // : 
    this._cargarHistorial();

    this._cargarUsuarios();
    this._cargarUltimosCursos();
    this.socketService = Provider.of<SocketService>(context, listen: false );
    // historial != null

    // ? 
    this.socketService.socket.on('ver-historial', (payload){
      this.historial = ( payload?? '' as List)
          .map( (h) => Historial.fromJson( h ) )
          .toList();
      this._cargarUltimosCursos();
          // print('payload  '+ payload.toString());
          setState(() {});
          
      });

    super.initState();
  }
  

  @override
  void dispose() { 
    this.socketService.socket.off('ver-historial');
    // this.socketService.socket.off('ver-cursos');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
  }

  @override
  Widget build(BuildContext context) {

    socketService = Provider.of<SocketService>(context);
    final Size pantalla = MediaQuery.of(context).size;
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      //backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: true,
      // appBar: AppBar( toolbarHeight: 0, elevation: 0,),
      body: SafeArea(
        child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _actualizar,
        header: WaterDropHeader(
          complete: CircleAvatar(backgroundColor: Colors.teal[200].withOpacity(.2), radius: 20 ,child: Icon(FluentIcons.checkmark_circle_24_regular, color: Colors.tealAccent[700], )),
          idleIcon: CircleAvatar(backgroundColor: Colors.teal[200].withOpacity(.2), radius: 20, child: Icon(FluentIcons.arrow_clockwise_24_regular, color: isDarkTheme? Colors.blueGrey[50] : Colors.grey[700], )),
          waterDropColor: Colors.transparent,
        ),
        child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[

              _crearAppbar(),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(height: 10),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 15, bottom: 25),
                    //   child: CrearPortadas(pantalla:pantalla),
                    // ),
                    HeaderTitulo(titulo: 'materias', paginaDestino: '',),
                    _listaRamos(),
                    SizedBox(height: 10),

                    usuarios == [] || usuarios == null 
                      ? Center(child: CircularProgressIndicator( strokeWidth: 1 ))
                      : _listViewUsuarios(),
                    // SizedBox(height: 15),
                    
                    HeaderTitulo(titulo: 'continuar viendo', paginaDestino: '',),
                    _listaHistorial(),
                    SizedBox(height: 13),
                    HeaderTitulo(titulo: 'sugeridos para ti', paginaDestino: '',),
                    SizedBox(height: 8),
                    cursosUltimos == [] || cursosUltimos == null 
                      ? Center(child: CircularProgressIndicator( strokeWidth: 1 ))
                      : _listaCursos(),
                    
                    // HeaderTitulo(titulo: 'Sugeridos Para Ti', paginaDestino: '',),
                    // SizedBox(height: 8),
                    // _listaCursos(),
                    SizedBox(height: 120),
                  ],
                ),
              ),

            ],
          ),
        ))
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
        HeaderTitulo( titulo: 'profesores', paginaDestino: '' ),
        // SizedBox(height: 3),
        Container(
          height: 150,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 18, bottom: 20 ),
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
        padding: EdgeInsets.only( right: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            u.foto == '' || u.foto == null
            ? CircleAvatar(
              radius: 35,
              backgroundColor: isDarkTheme ? Colors.teal[800] : Colors.tealAccent[100],
              child: Text( u.nombre.substring(0,2), style: TextStyle( color: isDarkTheme ? Colors.white : Colors.teal[900] ))
            )
            : CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(u.foto),
            ),
            SizedBox(height: 8),
            Text( u.nombre, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
              style: TextStyle(
                       fontSize: 10, letterSpacing: -.4,
                       fontWeight: FontWeight.w500 
                       ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
  
  
  Widget _listaRamos() {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final imagen = [
                    'assets/portadaMatematica.png',
                    'assets/portadaFisica.png',
                    'assets/portadaQuimica.png',
                    'assets/portadaBiologia.png'
                    ];
    final imagenNoche = [
                    'assets/portadaMatematicaNoche.png',
                    'assets/portadaFisicaNoche.png',
                    'assets/portadaQuimicaNoche.png',
                    'assets/portadaBiologiaNoche.png'
                    ];
    final ruta = [
                    'matematica',
                    'fisica',
                    'matematica',
                    'matematica'
                    ];
                    
    return Container(
      height: 190,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 26, bottom: 5),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        // pageSnapping: false,
        itemBuilder: (_, i) => portada(context, isDarkTheme? imagenNoche[i] :imagen[i] , ruta[i] ),
        itemCount: imagen.length,
        controller: _scrollController,
      //   controller: PageController(
      //     viewportFraction: 0.57 ), 
      ),
    );
  }

  Widget portada( BuildContext context, String img, String path ) {

    return Container(
      margin: EdgeInsets.only(right: 12),
      width: 110,
      child: GestureDetector(
        onTap: (){
          CursoService cursoService = Provider.of<CursoService>(context, listen: false );
          cursoService.ramo = path;

          Navigator.pushNamed(context, 'ramo'); 
        },
        child: Image.asset(img)
      ),
    );
  }

  _cargarUltimosCursos() async {
    this.cursosUltimos = await cursoService.getAllCursos();
    setState((){});
  }

  Widget _listaCursos() {
    return Container(
      height: 255,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 26, bottom: 5),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        // pageSnapping: false,
        itemBuilder: (_, i) => carruselHorizontal(context, cursosUltimos.reversed.toList()[i]),
        itemCount: cursosUltimos?.length?? 0,
        controller: _scrollController,
      //   controller: PageController(
      //     viewportFraction: 0.57 ), 
      ),
    );
  }

   _listaHistorial() {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    // return FutureBuilder(
    //   future: authService.verHistorial(),
    //   builder: (_, AsyncSnapshot<List<Historial>> s) {

    //     if (s.hasData) {
          
          return Container(
            color: isDarkTheme? BonovaColors.azulNoche[750].withOpacity(.9) :Colors.grey[100],
            height: 160,
            child: PageView.builder(
              // padding: EdgeInsets.only(left: 26, bottom: 5),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              // shrinkWrap: true,
              // pageSnapping: false,
              itemBuilder: (_, i) => carruselHistorial(context, historial[i]),
              itemCount: historial?.length?? 0,
              // controller: _scrollController,
              controller: PageController(
                viewportFraction: 0.8 ), 
            ),
          );

    //     } else {
    //       return CircularProgressIndicator();
    //     }

    //   },
    // );

  }

  Widget _crearAppbar() {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 63,
      elevation: 0,
      floating: true,
      pinned: true,
      snap: false,
      flexibleSpace: Container(
        padding: const EdgeInsets.only(top: 19, bottom: 1, right: 5),
        decoration: BoxDecoration( border: Border(
                                              // bottom: BorderSide(width: .08, color: Colors.grey[600],),
                                              // top: BorderSide(width: .05, color: Colors.white ),
                                               )),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                margin: EdgeInsets.only(left: 22),
                child: Padding(
                  padding: const EdgeInsets.only(top:5),
                  child: Hero(
                    tag: 'logo',
                    child: WebsafeSvg.asset('assets/bv_ic.svg',
                      color: isDarkTheme? Colors.tealAccent : Colors.teal[700],
                      alignment: Alignment.bottomCenter,
                      height: 27,
                      fit: BoxFit.cover,),
                  ),
                ),
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                IconButton(
                  padding: EdgeInsets.only(bottom: 7),
                  icon: Icon(FluentIcons.chat_16_regular, size: 30, color: isDarkTheme? Colors.tealAccent :Colors.teal[700],),
                  onPressed: () => Navigator.pushNamed(context, 'usuarios-chat'),
                ),


              ],)
            ] ),
      ),
    );
  }
  _cargarHistorial() async {
    this.historial = await authService.verHistorial();
    setState((){});
  }

  _actualizar() async {
    _refreshController.refreshCompleted();
    Navigator.pushReplacementNamed(context, 'home');
  }

}